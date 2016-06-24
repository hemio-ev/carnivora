======================================================================
backend
======================================================================

Carnivora Backend

The backend module provides everything required for the backend API.
The backend API delivers content required for building configs etc.
to clients, called machines.

.. contents:: Module Contents
   :local:
   :depth: 2


Tables
----------------------------------------------------------------------


.. _TBL-backend.auth:

``backend.auth``
``````````````````````````````````````````````````````````````````````

Grants rights to backend API clients based on SQL roles.

Primary key:

- role


.. BEGIN FKs


.. END FKs


Columns
''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''


.. _COLUMN-backend.auth.role:

- ``role`` *commons.t_key*
    Grantee for right to access the backend date for the defined machine.
    A role is basically a user or a user group on the SQL server.






.. _COLUMN-backend.auth.machine:

- ``machine`` *dns.t_domain*
    Machine for which the rights are granted.


  - References: :ref:`backend.machine.name <COLUMN-backend.machine.name>`

  - On Delete: CASCADE




.. _TBL-backend.machine:

``backend.machine``
``````````````````````````````````````````````````````````````````````

Physical or virtual machines that hosts services.

Primary key:

- name


.. BEGIN FKs


.. END FKs


Columns
''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''


.. _COLUMN-backend.machine.name:

- ``name`` *dns.t_domain*
    Machine name









Functions
---------


``backend._active``
``````````````````````````````````````````````````````````````````````

Is not 'del'

.. code-block:: plpgsql

   RETURN backend_status IS NULL OR (backend_status <> 'del' AND backend_status <> 'old');


``backend._conditional_notify``
``````````````````````````````````````````````````````````````````````

Notifies if first argument is true. Throws inaccessible otherwise.

.. code-block:: plpgsql

   IF p_condition THEN
       PERFORM backend._notify_domain(p_service, p_subservice, p_domain);
   ELSE
       PERFORM commons._raise_inaccessible_or_missing();
   END IF;


``backend._conditional_notify_service_entity_name``
``````````````````````````````````````````````````````````````````````

Notifies if first argument is true. Throws inaccessible otherwise.

.. code-block:: plpgsql

   IF p_condition THEN
       PERFORM backend._notify_service_entity_name(p_service_entity_name, p_service, p_subservice);
   ELSE
       PERFORM commons._raise_inaccessible_or_missing();
   END IF;


``backend._deleted``
``````````````````````````````````````````````````````````````````````

Is 'del'

.. code-block:: plpgsql

   RETURN backend_status IS NOT NULL AND backend_status = 'del';


``backend._get_login``
``````````````````````````````````````````````````````````````````````

Shows informations for the current backend login.
Throws an error if the current user is not a grantee
for a machine.

.. code-block:: plpgsql

   IF (SELECT TRUE FROM "backend"."auth"
      WHERE "role"=session_user)
   THEN
      RETURN QUERY SELECT backend.auth.machine FROM backend.auth
          WHERE "role"=session_user;
   ELSE
      RAISE 'Connected role `%` is not a grantee for a machine.', session_user;
   END IF;


``backend._machine_priviledged``
``````````````````````````````````````````````````````````````````````

Checks if a currently connected machine is priviledged to obtain data for
a certain service for a certain domain name.

WARNING: The parameter p_domain must be a domain, which means an entry in
the column dns.service.domain. It must not be confused with a service_entity_name.

.. code-block:: plpgsql

   v_machine := (SELECT "machine" FROM "backend"._get_login());
   
   RETURN COALESCE(
       (
       SELECT TRUE FROM system.service_entity_machine AS t
           JOIN dns.service AS s
           ON
               s.service = p_service AND
               s.domain = p_domain
   
           WHERE
               t.service = p_service AND
               t.service_entity_name = s.service_entity_name AND
               t.machine_name = v_machine
       )
   , FALSE);


``backend._machine_priviledged_service``
``````````````````````````````````````````````````````````````````````

Checks if a currently connected machine is priviledged to obtain data for
a certain service for a certain servicee name.

WARNING: The parameter p_server_name must be a service name. It must not be
confused with a domain.

.. code-block:: plpgsql

   v_machine := (SELECT "machine" FROM "backend"._get_login());
   
   RETURN COALESCE(
       (
       SELECT TRUE FROM system.service_entity_machine AS t
           WHERE
               t.service = p_service AND
               t.service_entity_name = p_service_entity_name AND
               t.machine_name = v_machine
       )
   , FALSE);


``backend._notify``
``````````````````````````````````````````````````````````````````````

Informs all machines about changes.

To listen to signals use LISTEN "carnivora/machine.name.example".
The payload has the form 'mail.domain.example/email/list'.

.. code-block:: plpgsql

   PERFORM
       pg_notify(
           'carnivora/' || p_machine,
            p_service_entity_name || '/' || p_service || '/' || p_subservice
           );


``backend._notify_domain``
``````````````````````````````````````````````````````````````````````

Informs all machines about changes.

WARNING: The parameter p_domain must be a domain, which means an entry in
the column dns.service.domain. It must not be confused with a service_entity_name.

.. code-block:: plpgsql

   PERFORM
       backend._notify(machine_name, s.service_entity_name, p_service, p_subservice)
   
   FROM system.service_entity_machine AS t
       JOIN dns.service AS s
       ON
           s.service = p_service AND
           s.domain = p_domain
   
       WHERE
           t.service = p_service AND
           t.service_entity_name = s.service_entity_name
   ;


``backend._notify_service_entity_name``
``````````````````````````````````````````````````````````````````````

Informs all machines about changes.

WARNING: The parameter p_service_entity_name must be a servcie name. It must not be
confused with a domain.

.. code-block:: plpgsql

   PERFORM
       backend._notify(machine_name, p_service_entity_name, p_service, p_subservice)
   
   FROM system.service_entity_machine AS t
       WHERE
           t.service = p_service AND
           t.service_entity_name = p_service_entity_name
   ;



