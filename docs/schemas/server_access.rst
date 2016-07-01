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
     for ownage


   References :ref:`user.user.owner <COLUMN-user.user.owner>`



 - .. _COLUMN-server_access.user.uid:
   
   ``uid`` :ref:`SERIAL <DOMAIN-SERIAL>`
     Unix user identifier





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







