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

- ``backend_status`` *NULL* | *backend.t_status*
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

- ``password`` *NULL* | *commons.t_password*
    Unix shadow crypt format









Functions
---------


``server_access.del_user``
``````````````````````````````````````````````````````````````````````

delete

.. code-block:: plpgsql

   -- begin userlogin prelude
   v_login := (SELECT t.owner FROM "user"._get_login() AS t);
   v_owner := (SELECT t.act_as FROM "user"._get_login() AS t);
   -- end userlogin prelude
   
   BEGIN
       -- perform DELETE to trigger potential foreign key errors
       DELETE FROM server_access.user
       WHERE
           "user" = p_user AND
           service_entity_name = p_service_entity_name AND
           owner = v_owner;
   
       -- if not failed yet, emulate rollback of DELETE
       RAISE transaction_rollback;
   EXCEPTION
       WHEN transaction_rollback THEN
           UPDATE server_access.user
               SET backend_status = 'del'
           WHERE
               "user" = p_user AND
               service_entity_name = p_service_entity_name AND
               owner = v_owner
           RETURNING subservice INTO v_subservice;
   
           PERFORM backend._conditional_notify_service_entity_name(
                FOUND,  p_service_entity_name, 'server_access', v_subservice
            );
   END;


``server_access.ins_user``
``````````````````````````````````````````````````````````````````````

ins user

.. code-block:: plpgsql

   -- begin userlogin prelude
   v_login := (SELECT t.owner FROM "user"._get_login() AS t);
   v_owner := (SELECT t.act_as FROM "user"._get_login() AS t);
   -- end userlogin prelude
   
   IF p_password IS NULL THEN
       v_password := NULL;
   ELSE
       v_password := commons._hash_password(p_password);
   END IF;
   
   INSERT INTO server_access.user
       (service, subservice, service_entity_name, "user", password, owner)
   VALUES
       ('server_access', p_subservice, p_service_entity_name, p_user, v_password, v_owner);
   
   PERFORM backend._notify_service_entity_name(p_service_entity_name, 'server_access', p_subservice);


``server_access.sel_user``
``````````````````````````````````````````````````````````````````````

sel user

.. code-block:: plpgsql

   -- begin userlogin prelude
   v_login := (SELECT t.owner FROM "user"._get_login() AS t);
   v_owner := (SELECT t.act_as FROM "user"._get_login() AS t);
   -- end userlogin prelude
   
   RETURN QUERY
       SELECT
           t.user,
           t.password IS NOT NULL,
           t.service,
           t.subservice,
           t.service_entity_name,
           t.backend_status
       FROM
           server_access.user AS t
       WHERE
           owner = v_owner
       ORDER BY backend_status, "user";


``server_access.srv_user``
``````````````````````````````````````````````````````````````````````

backend server_access.user

.. code-block:: plpgsql

   v_machine := (SELECT "machine" FROM "backend"._get_login());
   
   RETURN QUERY
       WITH
   
       -- DELETE
       d AS (
           DELETE FROM server_access.user AS t
           WHERE
               backend._deleted(t.backend_status) AND
               backend._machine_priviledged_service(t.service, t.service_entity_name)
       ),
   
       -- UPDATE
       s AS (
           UPDATE server_access.user AS t
               SET backend_status = NULL
           WHERE
               backend._machine_priviledged_service(t.service, t.service_entity_name) AND
               backend._active(t.backend_status)
       )
   
       -- SELECT
       SELECT
           t.user,
           t.password,
           t.service,
           t.subservice,
           t.service_entity_name,
           t.backend_status,
           t.uid
       FROM server_access.user AS t
   
       WHERE
           backend._machine_priviledged_service(t.service, t.service_entity_name) AND
           (backend._active(t.backend_status) OR p_include_inactive);


``server_access.upd_user``
``````````````````````````````````````````````````````````````````````

passwd user

.. code-block:: plpgsql

   -- begin userlogin prelude
   v_login := (SELECT t.owner FROM "user"._get_login() AS t);
   v_owner := (SELECT t.act_as FROM "user"._get_login() AS t);
   -- end userlogin prelude
   
   IF p_password IS NOT NULL THEN
       v_password := commons._hash_password(p_password);
   END IF;
   
   UPDATE server_access.user
   SET
       password = v_password,
       backend_status = 'upd'
   WHERE
       "user" = p_user AND
       service_entity_name = p_service_entity_name
   RETURNING subservice INTO v_subservice;
   
   PERFORM backend._conditional_notify_service_entity_name(
       FOUND, p_service_entity_name, 'server_access', v_subservice
   );



