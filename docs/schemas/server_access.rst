server_access
======================================================================

Server Access

Explicit passwd entries for shell acounts and sftp.

This module sends the following signals:
 - server_access/sftp
 - server_access/ssh

.. contents:: Schema Contents
   :local:
   :depth: 2



Tables
------


.. _TABLE-server_access.user:

``server_access.user``
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

unix user

Primary key
 - user


.. BEGIN FKs

Foreign keys
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
 - .. _COLUMN-server_access.user.service_entity_name:
   
   ``service_entity_name`` :ref:`dns.t_domain <DOMAIN-dns.t_domain>`
     Service entity name





 - .. _COLUMN-server_access.user.service:
   
   ``service`` :ref:`commons.t_key <DOMAIN-commons.t_key>`
     Service (e.g. email, jabber)





 - .. _COLUMN-server_access.user.subservice:
   
   ``subservice`` :ref:`commons.t_key <DOMAIN-commons.t_key>`
     Subservice (e.g. account, alias)





 - .. _COLUMN-server_access.user.backend_status:
   
   ``backend_status`` *NULL* | :ref:`backend.t_status <DOMAIN-backend.t_status>`
     Status of database entry in backend. NULL: nothing pending,
     'ins': entry not present on backend client, 'upd': update
     pending on backend client, 'del': deletion peding on
     backend client.

   Default
    .. code-block:: sql

     'ins'




 - .. _COLUMN-server_access.user.owner:
   
   ``owner`` :ref:`user.t_user <DOMAIN-user.t_user>`
     Owner


   References :ref:`user.user.owner <COLUMN-user.user.owner>`


   On Update: CASCADE

 - .. _COLUMN-server_access.user.uid:
   
   ``uid`` :ref:`integer <DOMAIN-integer>`
     Unix user identifier

   Default
    .. code-block:: sql

     nextval('commons.uid')




 - .. _COLUMN-server_access.user.user:
   
   ``user`` :ref:`server_access.t_user <DOMAIN-server_access.t_user>`
     User





 - .. _COLUMN-server_access.user.password:
   
   ``password`` *NULL* | :ref:`commons.t_password <DOMAIN-commons.t_password>`
     Unix shadow crypt format










Functions
---------



.. _FUNCTION-server_access.del_user:

``server_access.del_user``
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

delete

Parameters
 - ``p_user`` :ref:`server_access.t_user <DOMAIN-server_access.t_user>`
   
    
 - ``p_service_entity_name`` :ref:`dns.t_domain <DOMAIN-dns.t_domain>`
   
    


Variables defined for body
 - ``v_subservice`` :ref:`commons.t_key <DOMAIN-commons.t_key>`
   
   
 - ``v_owner`` :ref:`user.t_user <DOMAIN-user.t_user>`
   
   
 - ``v_login`` :ref:`user.t_user <DOMAIN-user.t_user>`
   
   

Returns
 void


Execute privilege
 - :ref:`userlogin <ROLE-userlogin>`

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



.. _FUNCTION-server_access.ins_user:

``server_access.ins_user``
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

ins user

Parameters
 - ``p_user`` :ref:`server_access.t_user <DOMAIN-server_access.t_user>`
   
    
 - ``p_service_entity_name`` :ref:`dns.t_domain <DOMAIN-dns.t_domain>`
   
    
 - ``p_subservice`` :ref:`commons.t_key <DOMAIN-commons.t_key>`
   
    
 - ``p_password`` :ref:`commons.t_password_plaintext <DOMAIN-commons.t_password_plaintext>`
   
    


Variables defined for body
 - ``v_password`` :ref:`commons.t_password <DOMAIN-commons.t_password>`
   
   
 - ``v_owner`` :ref:`user.t_user <DOMAIN-user.t_user>`
   
   
 - ``v_login`` :ref:`user.t_user <DOMAIN-user.t_user>`
   
   

Returns
 void


Execute privilege
 - :ref:`userlogin <ROLE-userlogin>`

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



.. _FUNCTION-server_access.sel_user:

``server_access.sel_user``
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

sel user

Parameters
 *None*


Variables defined for body
 - ``v_owner`` :ref:`user.t_user <DOMAIN-user.t_user>`
   
   
 - ``v_login`` :ref:`user.t_user <DOMAIN-user.t_user>`
   
   

Returns
 TABLE

Returned columns
 - ``user`` :ref:`server_access.t_user <DOMAIN-server_access.t_user>`
    
 - ``password_login`` :ref:`boolean <DOMAIN-boolean>`
    
 - ``service`` :ref:`commons.t_key <DOMAIN-commons.t_key>`
    
 - ``subservice`` :ref:`commons.t_key <DOMAIN-commons.t_key>`
    
 - ``service_entity_name`` :ref:`dns.t_domain <DOMAIN-dns.t_domain>`
    
 - ``backend_status`` :ref:`backend.t_status <DOMAIN-backend.t_status>`
    

Execute privilege
 - :ref:`userlogin <ROLE-userlogin>`

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
       ORDER BY backend_status, "user"
   ;



.. _FUNCTION-server_access.srv_user:

``server_access.srv_user``
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

backend server_access.user

Parameters
 - ``p_include_inactive`` :ref:`boolean <DOMAIN-boolean>`
   
    


Variables defined for body
 - ``v_machine`` :ref:`dns.t_domain <DOMAIN-dns.t_domain>`
   
   

Returns
 TABLE

Returned columns
 - ``user`` :ref:`server_access.t_user <DOMAIN-server_access.t_user>`
    
 - ``password`` :ref:`commons.t_password <DOMAIN-commons.t_password>`
    
 - ``service`` :ref:`commons.t_key <DOMAIN-commons.t_key>`
    
 - ``subservice`` :ref:`commons.t_key <DOMAIN-commons.t_key>`
    
 - ``service_entity_name`` :ref:`dns.t_domain <DOMAIN-dns.t_domain>`
    
 - ``backend_status`` :ref:`backend.t_status <DOMAIN-backend.t_status>`
    
 - ``uid`` :ref:`int <DOMAIN-int>`
    

Execute privilege
 - :ref:`backend <ROLE-backend>`

.. code-block:: plpgsql

   v_machine := (SELECT "machine" FROM "backend"._get_login());
   
   
   RETURN QUERY
       WITH
   
       -- DELETE
       d AS (
           DELETE FROM server_access.user AS t
           WHERE
               backend._deleted(t.backend_status) AND
               backend._machine_priviledged_entity(t.service, t.service_entity_name)
       ),
   
       -- UPDATE
       s AS (
           UPDATE server_access.user AS t
               SET backend_status = NULL
           WHERE
               backend._machine_priviledged_entity(t.service, t.service_entity_name) AND
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
           backend._machine_priviledged_entity(t.service, t.service_entity_name) AND
           (backend._active(t.backend_status) OR p_include_inactive);



.. _FUNCTION-server_access.upd_user:

``server_access.upd_user``
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

passwd user

Parameters
 - ``p_user`` :ref:`server_access.t_user <DOMAIN-server_access.t_user>`
   
    
 - ``p_service_entity_name`` :ref:`dns.t_domain <DOMAIN-dns.t_domain>`
   
    
 - ``p_password`` :ref:`commons.t_password_plaintext <DOMAIN-commons.t_password_plaintext>`
   
    


Variables defined for body
 - ``v_password`` :ref:`commons.t_password <DOMAIN-commons.t_password>`
   (default: ``NULL``)
   
 - ``v_subservice`` :ref:`commons.t_key <DOMAIN-commons.t_key>`
   
   
 - ``v_owner`` :ref:`user.t_user <DOMAIN-user.t_user>`
   
   
 - ``v_login`` :ref:`user.t_user <DOMAIN-user.t_user>`
   
   

Returns
 void


Execute privilege
 - :ref:`userlogin <ROLE-userlogin>`

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





Domains
-------



.. _DOMAIN-server_access.t_user:

``server_access.t_user``
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Unix user. This type only allows a subset of those names allowed by POSIX.

Checks
 - ``valid_characters``
    Only allow lower-case characters.

   .. code-block:: sql

    VALUE ~ '^[a-z0-9_-]+$'

 - ``no_repeated_hyphens``
    Reserve double hyphens as a seperator for system generated users.

   .. code-block:: sql

    NOT (VALUE LIKE '%--%')

 - ``no_starting_hyphen``
    No hyphens at the beginning:
    http://pubs.opengroup.org/onlinepubs/9699919799/basedefs/V1_chap03.html#tag_03_431

   .. code-block:: sql

    left(VALUE, 1) <> '-'







.. This file was generated via HamSql

