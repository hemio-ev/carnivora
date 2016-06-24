======================================================================
server_access
======================================================================

Server Access

Explicit passwd entries for shell acounts and sftp.

This module sends the following signals:
 - server_access/sftp
 - server_access/ssh

.. contents:: Module Contents
   :local:
   :depth: 2


Tables
----------------------------------------------------------------------


.. _TBL-server_access.user:

``server_access.user``
``````````````````````````````````````````````````````````````````````

unix user

Primary key:

- user


.. BEGIN FKs

Foreign keys:

- Reference service entity

  Local Columns
   - service_entity_name
   - service

  Referenced Columns
   - :ref:`system.service_entity.service_entity_name <COLUMN-system.service_entity.service_entity_name>`
   - :ref:`system.service_entity.service <COLUMN-system.service_entity.service>`

- Reference subservice entity

  Local Columns
   - service_entity_name
   - service
   - subservice

  Referenced Columns
   - :ref:`system.subservice_entity.service_entity_name <COLUMN-system.subservice_entity.service_entity_name>`
   - :ref:`system.subservice_entity.service <COLUMN-system.subservice_entity.service>`
   - :ref:`system.subservice_entity.subservice <COLUMN-system.subservice_entity.subservice>`


.. END FKs


Columns
''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''


.. _COLUMN-server_access.user.service_entity_name:

- ``service_entity_name`` *dns.t_domain*
    Service entity name






.. _COLUMN-server_access.user.service:

- ``service`` *commons.t_key*
    Service (e.g. email, jabber)






.. _COLUMN-server_access.user.subservice:

- ``subservice`` *commons.t_key*
    Subservice (e.g. account, alias)






.. _COLUMN-server_access.user.backend_status:

- ``backend_status`` *NULL | backend.t_status*
    Status of database entry in backend. NULL: nothing pending,
    'ins': entry not present on backend client, 'upd': update
    pending on backend client, 'del': deletion peding on
    backend client.

  - Default: :python:`'ins'`





.. _COLUMN-server_access.user.owner:

- ``owner`` *user.t_user*
    for ownage


  - References: :ref:`user.user.owner <COLUMN-user.user.owner>`




.. _COLUMN-server_access.user.uid:

- ``uid`` *SERIAL*
    Unix user identifier






.. _COLUMN-server_access.user.user:

- ``user`` *server_access.t_user*
    User






.. _COLUMN-server_access.user.password:

- ``password`` *NULL | commons.t_password*
    Unix shadow crypt format









Functions
---------


``server_access.del_user``
``````````````````````````````````````````````````````````````````````

delete


``server_access.ins_user``
``````````````````````````````````````````````````````````````````````

ins user


``server_access.sel_user``
``````````````````````````````````````````````````````````````````````

sel user


``server_access.srv_user``
``````````````````````````````````````````````````````````````````````

backend server_access.user


``server_access.upd_user``
``````````````````````````````````````````````````````````````````````

passwd user



