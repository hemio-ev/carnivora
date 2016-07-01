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
------


.. _TABLE-backend.auth:

``backend.auth``
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Grants rights to backend API clients based on SQL roles.

Primary key
 - role


.. BEGIN FKs


.. END FKs


Columns
 - .. _COLUMN-backend.auth.role:
   
   ``role`` :ref:`commons.t_key <DOMAIN-commons.t_key>`
     Grantee for right to access the backend date for the defined machine.
     A role is basically a user or a user group on the SQL server.





 - .. _COLUMN-backend.auth.machine:
   
   ``machine`` :ref:`dns.t_domain <DOMAIN-dns.t_domain>`
     Machine for which the rights are granted.


   References :ref:`backend.machine.name <COLUMN-backend.machine.name>`

   On Delete: CASCADE




.. _TABLE-backend.machine:

``backend.machine``
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Physical or virtual machines that hosts services.

Primary key
 - name


.. BEGIN FKs


.. END FKs


Columns
 - .. _COLUMN-backend.machine.name:
   
   ``name`` :ref:`dns.t_domain <DOMAIN-dns.t_domain>`
     Machine name










Functions
---------



.. _FUNCTION-backend._active:

``backend._active``
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Is not 'del'

Parameters
 - ``backend_status`` :ref:`backend.t_status <DOMAIN-backend.t_status>`
   
    



Returns
 boolean



.. code-block:: plpgsql

   
   RETURN backend_status IS NULL OR (backend_status <> 'del' AND backend_status <> 'old');



.. _FUNCTION-backend._conditional_notify:

``backend._conditional_notify``
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Notifies if first argument is true. Throws inaccessible otherwise.

Parameters
 - ``p_condition`` :ref:`boolean <DOMAIN-boolean>`
   
    
 - ``p_service`` :ref:`commons.t_key <DOMAIN-commons.t_key>`
   
    
 - ``p_subservice`` :ref:`commons.t_key <DOMAIN-commons.t_key>`
   
    
 - ``p_domain`` :ref:`dns.t_domain <DOMAIN-dns.t_domain>`
   
    



Returns
 void



.. code-block:: plpgsql

   
   IF p_condition THEN
       PERFORM backend._notify_domain(p_service, p_subservice, p_domain);
   ELSE
       PERFORM commons._raise_inaccessible_or_missing();
   END IF;



.. _FUNCTION-backend._conditional_notify_service_entity_name:

``backend._conditional_notify_service_entity_name``
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Notifies if first argument is true. Throws inaccessible otherwise.

Parameters
 - ``p_condition`` :ref:`boolean <DOMAIN-boolean>`
   
    
 - ``p_service_entity_name`` :ref:`dns.t_domain <DOMAIN-dns.t_domain>`
   
    
 - ``p_service`` :ref:`commons.t_key <DOMAIN-commons.t_key>`
   
    
 - ``p_subservice`` :ref:`commons.t_key <DOMAIN-commons.t_key>`
   
    



Returns
 void



.. code-block:: plpgsql

   
   IF p_condition THEN
       PERFORM backend._notify_service_entity_name(p_service_entity_name, p_service, p_subservice);
   ELSE
       PERFORM commons._raise_inaccessible_or_missing();
   END IF;



.. _FUNCTION-backend._deleted:

``backend._deleted``
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Is 'del'

Parameters
 - ``backend_status`` :ref:`backend.t_status <DOMAIN-backend.t_status>`
   
    



Returns
 boolean



.. code-block:: plpgsql

   
   RETURN backend_status IS NOT NULL AND backend_status = 'del';



.. _FUNCTION-backend._get_login:

``backend._get_login``
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Shows informations for the current backend login.
Throws an error if the current user is not a grantee
for a machine.

Parameters
 *None*



Returns
 TABLE

Returned columns
 - ``machine`` :ref:`dns.t_domain <DOMAIN-dns.t_domain>`
    


.. code-block:: plpgsql

   
   IF (SELECT TRUE FROM "backend"."auth"
      WHERE "role"=session_user)
   THEN
      RETURN QUERY SELECT backend.auth.machine FROM backend.auth
          WHERE "role"=session_user;
   ELSE
      RAISE 'Connected role `%` is not a grantee for a machine.', session_user;
   END IF;



.. _FUNCTION-backend._machine_priviledged:

``backend._machine_priviledged``
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Checks if a currently connected machine is priviledged to obtain data for
a certain service for a certain domain name.

.. warning::
   The parameter p_domain must be a domain, which means an entry in
   the column dns.service.domain. It must not be confused with a service_entity_name.

Parameters
 - ``p_service`` :ref:`commons.t_key <DOMAIN-commons.t_key>`
   
    
 - ``p_domain`` :ref:`dns.t_domain <DOMAIN-dns.t_domain>`
   
    
 - ``p_include_inactive`` :ref:`boolean <DOMAIN-boolean>`
   
    


Variables defined for body
 - ``v_machine`` :ref:`dns.t_domain <DOMAIN-dns.t_domain>`
   
   

Returns
 boolean


Execute privilege
 - :ref:`backend <ROLE-backend>`

.. code-block:: plpgsql

   v_machine := (SELECT "machine" FROM "backend"._get_login());



.. _FUNCTION-backend._machine_priviledged_service:

``backend._machine_priviledged_service``
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Checks if a currently connected machine is priviledged to obtain data for
a certain service for a certain servicee name.

.. warning:: 
 The parameter p_server_name must be a service name. It must not be
 confused with a domain.

Parameters
 - ``p_service`` :ref:`commons.t_key <DOMAIN-commons.t_key>`
   
    
 - ``p_service_entity_name`` :ref:`dns.t_domain <DOMAIN-dns.t_domain>`
   
    
 - ``p_include_inactive`` :ref:`boolean <DOMAIN-boolean>`
   
    


Variables defined for body
 - ``v_machine`` :ref:`dns.t_domain <DOMAIN-dns.t_domain>`
   
   

Returns
 boolean


Execute privilege
 - :ref:`backend <ROLE-backend>`

.. code-block:: plpgsql

   v_machine := (SELECT "machine" FROM "backend"._get_login());



.. _FUNCTION-backend._notify:

``backend._notify``
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Informs all machines about changes.

To listen to signals use LISTEN "carnivora/machine.name.example".
The payload has the form 'mail.domain.example/email/list'.

Parameters
 - ``p_machine`` :ref:`dns.t_domain <DOMAIN-dns.t_domain>`
   
    
 - ``p_service_entity_name`` :ref:`dns.t_domain <DOMAIN-dns.t_domain>`
   
    
 - ``p_service`` :ref:`commons.t_key <DOMAIN-commons.t_key>`
   
    
 - ``p_subservice`` :ref:`commons.t_key <DOMAIN-commons.t_key>`
   
    



Returns
 void



.. code-block:: plpgsql

   
   PERFORM
       pg_notify(
           'carnivora/' || p_machine,
            p_service_entity_name || '/' || p_service || '/' || p_subservice
           );



.. _FUNCTION-backend._notify_domain:

``backend._notify_domain``
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Informs all machines about changes.

.. warning::
 The parameter p_domain must be a domain, which means an entry in
 the column dns.service.domain. It must not be confused with a service_entity_name.

Parameters
 - ``p_service`` :ref:`commons.t_key <DOMAIN-commons.t_key>`
   
    
 - ``p_subservice`` :ref:`commons.t_key <DOMAIN-commons.t_key>`
   
    
 - ``p_domain`` :ref:`dns.t_domain <DOMAIN-dns.t_domain>`
   
    



Returns
 void



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



.. _FUNCTION-backend._notify_service_entity_name:

``backend._notify_service_entity_name``
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Informs all machines about changes.

.. warning::
 The parameter p_service_entity_name must be a servcie name. It must not be
 confused with a domain.

Parameters
 - ``p_service_entity_name`` :ref:`dns.t_domain <DOMAIN-dns.t_domain>`
   
    
 - ``p_service`` :ref:`commons.t_key <DOMAIN-commons.t_key>`
   
    
 - ``p_subservice`` :ref:`commons.t_key <DOMAIN-commons.t_key>`
   
    



Returns
 void



.. code-block:: plpgsql

   
   PERFORM
       backend._notify(machine_name, p_service_entity_name, p_service, p_subservice)
   
   FROM system.service_entity_machine AS t
       WHERE
           t.service = p_service AND
           t.service_entity_name = p_service_entity_name
   ;





Domains
-------



.. _DOMAIN-backend.t_status:

``backend.t_status``
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Backend status





Roles
-----


.. _ROLE-backend:

``backend``
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

vms

Login
 *Disabled*




