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


``backend._conditional_notify``
``````````````````````````````````````````````````````````````````````

Notifies if first argument is true. Throws inaccessible otherwise.


``backend._conditional_notify_service_entity_name``
``````````````````````````````````````````````````````````````````````

Notifies if first argument is true. Throws inaccessible otherwise.


``backend._deleted``
``````````````````````````````````````````````````````````````````````

Is 'del'


``backend._get_login``
``````````````````````````````````````````````````````````````````````

Shows informations for the current backend login.
Throws an error if the current user is not a grantee
for a machine.


``backend._machine_priviledged``
``````````````````````````````````````````````````````````````````````

Checks if a currently connected machine is priviledged to obtain data for
a certain service for a certain domain name.

WARNING: The parameter p_domain must be a domain, which means an entry in
the column dns.service.domain. It must not be confused with a service_entity_name.


``backend._machine_priviledged_service``
``````````````````````````````````````````````````````````````````````

Checks if a currently connected machine is priviledged to obtain data for
a certain service for a certain servicee name.

WARNING: The parameter p_server_name must be a service name. It must not be
confused with a domain.


``backend._notify``
``````````````````````````````````````````````````````````````````````

Informs all machines about changes.

To listen to signals use LISTEN "carnivora/machine.name.example".
The payload has the form 'mail.domain.example/email/list'.


``backend._notify_domain``
``````````````````````````````````````````````````````````````````````

Informs all machines about changes.

WARNING: The parameter p_domain must be a domain, which means an entry in
the column dns.service.domain. It must not be confused with a service_entity_name.


``backend._notify_service_entity_name``
``````````````````````````````````````````````````````````````````````

Informs all machines about changes.

WARNING: The parameter p_service_entity_name must be a servcie name. It must not be
confused with a domain.



