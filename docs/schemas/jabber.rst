jabber
======================================================================

Jabber (XMPP)

This module sends the following signals:
 - jabber/account

.. contents:: Module Contents
   :local:
   :depth: 2



Tables
------


.. _TABLE-jabber.account:

``jabber.account``
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Jabber accounts

Primary key
 - node
 - domain


.. BEGIN FKs

Foreign keys
 - reference dns (service)

   Local Columns
    - domain
    - service
    - service_entity_name

   Referenced Columns
    - :ref:`dns.service.domain <COLUMN-dns.service.domain>`
    - :ref:`dns.service.service <COLUMN-dns.service.service>`
    - :ref:`dns.service.service_entity_name <COLUMN-dns.service.service_entity_name>`

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
 - .. _COLUMN-jabber.account.domain:
   
   ``domain`` :ref:`dns.t_domain <DOMAIN-dns.t_domain>`
     Domain name





 - .. _COLUMN-jabber.account.service:
   
   ``service`` :ref:`commons.t_key <DOMAIN-commons.t_key>`
     Service





 - .. _COLUMN-jabber.account.service_entity_name:
   
   ``service_entity_name`` :ref:`dns.t_domain <DOMAIN-dns.t_domain>`
     ent. name





 - .. _COLUMN-jabber.account.subservice:
   
   ``subservice`` :ref:`commons.t_key <DOMAIN-commons.t_key>`
     Subservice (e.g. account, alias)





 - .. _COLUMN-jabber.account.owner:
   
   ``owner`` :ref:`user.t_user <DOMAIN-user.t_user>`
     Owner


   References :ref:`user.user.owner <COLUMN-user.user.owner>`


   On Update: CASCADE

 - .. _COLUMN-jabber.account.backend_status:
   
   ``backend_status`` *NULL* | :ref:`backend.t_status <DOMAIN-backend.t_status>`
     Status of database entry in backend. NULL: nothing pending,
     'ins': entry not present on backend client, 'upd': update
     pending on backend client, 'del': deletion peding on
     backend client.

   Default
    .. code-block:: sql

     'ins'




 - .. _COLUMN-jabber.account.node:
   
   ``node`` :ref:`email.t_localpart <DOMAIN-email.t_localpart>`
     part in front of the @ in account name





 - .. _COLUMN-jabber.account.password:
   
   ``password`` :ref:`commons.t_password <DOMAIN-commons.t_password>`
     Unix shadow crypt format










Functions
---------



.. _FUNCTION-jabber.del_account:

``jabber.del_account``
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Delete jabber account

Parameters
 - ``p_node`` :ref:`email.t_localpart <DOMAIN-email.t_localpart>`
   
    
 - ``p_domain`` :ref:`dns.t_domain <DOMAIN-dns.t_domain>`
   
    


Variables defined for body
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
   
   
   UPDATE jabber.account
   SET backend_status = 'del'
   WHERE
       node = p_node AND
       domain = p_domain AND
       owner = v_owner;
   
   PERFORM backend._conditional_notify(FOUND, 'jabber', 'account', p_domain);



.. _FUNCTION-jabber.ins_account:

``jabber.ins_account``
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Insert jabber account

Parameters
 - ``p_node`` :ref:`email.t_localpart <DOMAIN-email.t_localpart>`
   
    
 - ``p_domain`` :ref:`dns.t_domain <DOMAIN-dns.t_domain>`
   
    
 - ``p_password`` :ref:`commons.t_password_plaintext <DOMAIN-commons.t_password_plaintext>`
   
    


Variables defined for body
 - ``v_num_total`` :ref:`integer <DOMAIN-integer>`
   
   
 - ``v_num_domain`` :ref:`integer <DOMAIN-integer>`
   
   
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
   
   
   v_num_total := (SELECT COUNT(*) FROM jabber.account AS t WHERE t.owner=v_owner);
   v_num_domain := (SELECT COUNT(*) FROM jabber.account AS t WHERE t.owner=v_owner AND t.domain = p_domain);
   
   PERFORM system._contingent_ensure(
       p_owner:=v_owner,
       p_domain:=p_domain,
       p_service:='jabber',
       p_subservice:='account',
       p_current_quantity_total:=v_num_total,
       p_current_quantity_domain:=v_num_domain);
   
   INSERT INTO jabber.account
       (service, subservice, node, domain, owner, password, service_entity_name) VALUES
       ('jabber', 'account', p_node, p_domain, v_owner, commons._hash_password(p_password),
       (SELECT service_entity_name FROM dns.service WHERE service='jabber' AND domain = p_domain));
   
   PERFORM backend._notify_domain('jabber', 'account', p_domain);



.. _FUNCTION-jabber.sel_account:

``jabber.sel_account``
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Select jabber accounts

Parameters
 *None*


Variables defined for body
 - ``v_owner`` :ref:`user.t_user <DOMAIN-user.t_user>`
   
   
 - ``v_login`` :ref:`user.t_user <DOMAIN-user.t_user>`
   
   

Returns
 TABLE

Returned columns
 - ``node`` :ref:`email.t_localpart <DOMAIN-email.t_localpart>`
    
 - ``domain`` :ref:`dns.t_domain <DOMAIN-dns.t_domain>`
    
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
           t.node,
           t.domain,
           t.backend_status
       FROM jabber.account AS t
       WHERE
           t.owner = v_owner
       ORDER BY t.backend_status, t.node, t.domain;



.. _FUNCTION-jabber.srv_account:

``jabber.srv_account``
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Lists all jabber accounts

Parameters
 - ``p_include_inactive`` :ref:`boolean <DOMAIN-boolean>`
   
    


Variables defined for body
 - ``v_machine`` :ref:`dns.t_domain <DOMAIN-dns.t_domain>`
   
   

Returns
 TABLE

Returned columns
 - ``node`` :ref:`email.t_localpart <DOMAIN-email.t_localpart>`
    
 - ``domain`` :ref:`dns.t_domain <DOMAIN-dns.t_domain>`
    
 - ``password`` :ref:`commons.t_password <DOMAIN-commons.t_password>`
    
 - ``backend_status`` :ref:`backend.t_status <DOMAIN-backend.t_status>`
    

Execute privilege
 - :ref:`backend <ROLE-backend>`

.. code-block:: plpgsql

   v_machine := (SELECT "machine" FROM "backend"._get_login());
   
   
   RETURN QUERY
       WITH
   
       -- DELETE
       d AS (
           DELETE FROM jabber.account AS t
           WHERE
               backend._deleted(t.backend_status) AND
               backend._machine_priviledged(t.service, t.domain)
       ),
   
       -- UPDATE
       s AS (
           UPDATE jabber.account AS t
               SET backend_status = NULL
           WHERE
               backend._machine_priviledged(t.service, t.domain) AND
               backend._active(t.backend_status)
       )
   
       -- SELECT
       SELECT
           t.node,
           t.domain,
           t.password,
           t.backend_status
       FROM jabber.account AS t
   
       WHERE
           backend._machine_priviledged(t.service, t.domain) AND
           (backend._active(t.backend_status) OR p_include_inactive);



.. _FUNCTION-jabber.upd_account:

``jabber.upd_account``
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Change jabber account password

Parameters
 - ``p_node`` :ref:`email.t_localpart <DOMAIN-email.t_localpart>`
   
    
 - ``p_domain`` :ref:`dns.t_domain <DOMAIN-dns.t_domain>`
   
    
 - ``p_password`` :ref:`commons.t_password_plaintext <DOMAIN-commons.t_password_plaintext>`
   
    


Variables defined for body
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
   
   
   UPDATE jabber.account
       SET
           password = commons._hash_password(p_password)
   WHERE
       node = p_node AND
       domain = p_domain AND
       owner = v_owner;
   
   PERFORM backend._conditional_notify(FOUND, 'jabber', 'account', p_domain);









