web
======================================================================

Websites

This module sends the following signals:
 - web/alias
 - web/site

.. contents:: Schema Contents
   :local:
   :depth: 2



Tables
------


.. _TABLE-web.alias:

``web.alias``
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Aliases

Primary key
 - domain
 - site_port


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

 - site

   Local Columns
    - site
    - service_entity_name
    - site_port

   Referenced Columns
    - :ref:`web.site.domain <COLUMN-web.site.domain>`
    - :ref:`web.site.service_entity_name <COLUMN-web.site.service_entity_name>`
    - :ref:`web.site.port <COLUMN-web.site.port>`

 - dns

   Local Columns
    - domain
    - service
    - service_entity_name

   Referenced Columns
    - :ref:`dns.service.domain <COLUMN-dns.service.domain>`
    - :ref:`dns.service.service <COLUMN-dns.service.service>`
    - :ref:`dns.service.service_entity_name <COLUMN-dns.service.service_entity_name>`


.. END FKs


Columns
 - .. _COLUMN-web.alias.domain:
   
   ``domain`` :ref:`dns.t_hostname <DOMAIN-dns.t_hostname>`
     Domain name





 - .. _COLUMN-web.alias.service:
   
   ``service`` :ref:`commons.t_key <DOMAIN-commons.t_key>`
     Service





 - .. _COLUMN-web.alias.service_entity_name:
   
   ``service_entity_name`` :ref:`dns.t_hostname <DOMAIN-dns.t_hostname>`
     ent. name





 - .. _COLUMN-web.alias.subservice:
   
   ``subservice`` :ref:`commons.t_key <DOMAIN-commons.t_key>`
     Subservice (e.g. account, alias)





 - .. _COLUMN-web.alias.backend_status:
   
   ``backend_status`` *NULL* | :ref:`backend.t_status <DOMAIN-backend.t_status>`
     Status of database entry in backend. NULL: nothing pending,
     'ins': entry not present on backend client, 'upd': update
     pending on backend client, 'del': deletion peding on
     backend client.

   Default
    .. code-block:: sql

     'ins'




 - .. _COLUMN-web.alias.site:
   
   ``site`` :ref:`dns.t_hostname <DOMAIN-dns.t_hostname>`
     Site





 - .. _COLUMN-web.alias.site_port:
   
   ``site_port`` :ref:`commons.t_port <DOMAIN-commons.t_port>`
     port

   Default
    .. code-block:: sql

     80






.. _TABLE-web.site:

``web.site``
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Website

Primary key
 - domain
 - port


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

 - server_access

   Local Columns
    - user
    - service_entity_name
    - owner

   Referenced Columns
    - :ref:`server_access.user.user <COLUMN-server_access.user.user>`
    - :ref:`server_access.user.service_entity_name <COLUMN-server_access.user.service_entity_name>`
    - :ref:`server_access.user.owner <COLUMN-server_access.user.owner>`


.. END FKs


Columns
 - .. _COLUMN-web.site.domain:
   
   ``domain`` :ref:`dns.t_hostname <DOMAIN-dns.t_hostname>`
     Domain name





 - .. _COLUMN-web.site.service:
   
   ``service`` :ref:`commons.t_key <DOMAIN-commons.t_key>`
     Service





 - .. _COLUMN-web.site.service_entity_name:
   
   ``service_entity_name`` :ref:`dns.t_hostname <DOMAIN-dns.t_hostname>`
     ent. name





 - .. _COLUMN-web.site.subservice:
   
   ``subservice`` :ref:`commons.t_key <DOMAIN-commons.t_key>`
     Subservice (e.g. account, alias)





 - .. _COLUMN-web.site.backend_status:
   
   ``backend_status`` *NULL* | :ref:`backend.t_status <DOMAIN-backend.t_status>`
     Status of database entry in backend. NULL: nothing pending,
     'ins': entry not present on backend client, 'upd': update
     pending on backend client, 'del': deletion peding on
     backend client.

   Default
    .. code-block:: sql

     'ins'




 - .. _COLUMN-web.site.option:
   
   ``option`` :ref:`jsonb <DOMAIN-jsonb>`
     Free options in JSON format

   Default
    .. code-block:: sql

     '{}'




 - .. _COLUMN-web.site.owner:
   
   ``owner`` :ref:`user.t_user <DOMAIN-user.t_user>`
     Owner


   References :ref:`user.user.owner <COLUMN-user.user.owner>`


   On Update: CASCADE

 - .. _COLUMN-web.site.port:
   
   ``port`` :ref:`commons.t_port <DOMAIN-commons.t_port>`
     Port





 - .. _COLUMN-web.site.user:
   
   ``user`` :ref:`server_access.t_user <DOMAIN-server_access.t_user>`
     Server account under which the htdocs reside





 - .. _COLUMN-web.site.https:
   
   ``https`` :ref:`bool <DOMAIN-bool>`
     HTTPS










Functions
---------



.. _FUNCTION-web.del_alias:

``web.del_alias``
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

del

Parameters
 - ``p_domain`` :ref:`dns.t_hostname <DOMAIN-dns.t_hostname>`
   
    
 - ``p_site_port`` :ref:`commons.t_port <DOMAIN-commons.t_port>`
   
    


Variables defined for body
 - ``v_owner`` :ref:`user.t_user <DOMAIN-user.t_user>`
   
   

Returns
 void


Execute privilege
 - :ref:`userlogin <ROLE-userlogin>`

.. code-block:: plpgsql

   -- begin userlogin prelude
   v_owner := (SELECT t.act_as FROM "user"._get_login() AS t);
   -- end userlogin prelude
   
   
   UPDATE web.alias AS t
       SET backend_status = 'del'
   FROM web.site AS s, server_access.user AS u
   WHERE
       -- JOIN web.site
       s.domain = t.site AND
   
       -- JOIN server_access.user
       u.service_entity_name = t.service_entity_name AND
       u.user = s.user AND
   
       u.owner = v_owner AND
       t.domain = p_domain AND
       t.site_port = p_site_port;
   
   PERFORM backend._conditional_notify(FOUND, 'web', 'alias', p_domain);



.. _FUNCTION-web.del_site:

``web.del_site``
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

del

Parameters
 - ``p_domain`` :ref:`dns.t_hostname <DOMAIN-dns.t_hostname>`
   
    
 - ``p_port`` :ref:`commons.t_port <DOMAIN-commons.t_port>`
   
    


Variables defined for body
 - ``v_owner`` :ref:`user.t_user <DOMAIN-user.t_user>`
   
   

Returns
 void


Execute privilege
 - :ref:`userlogin <ROLE-userlogin>`

.. code-block:: plpgsql

   -- begin userlogin prelude
   v_owner := (SELECT t.act_as FROM "user"._get_login() AS t);
   -- end userlogin prelude
   
   
   UPDATE web.site AS t
       SET backend_status = 'del'
   FROM server_access.user AS s
   WHERE
       -- JOIN server_access.user
       s.user = t.user AND
       s.service_entity_name = t.service_entity_name AND
   
       t.domain = p_domain AND
       t.port = p_port AND
       s.owner = v_owner;
   
   PERFORM backend._conditional_notify(FOUND, 'web', 'site', p_domain);



.. _FUNCTION-web.ins_alias:

``web.ins_alias``
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Insert alias

Parameters
 - ``p_domain`` :ref:`dns.t_hostname <DOMAIN-dns.t_hostname>`
   
    
 - ``p_site`` :ref:`dns.t_hostname <DOMAIN-dns.t_hostname>`
   
    
 - ``p_site_port`` :ref:`commons.t_port <DOMAIN-commons.t_port>`
   
    


Variables defined for body
 - ``v_owner`` :ref:`user.t_user <DOMAIN-user.t_user>`
   
   

Returns
 void


Execute privilege
 - :ref:`userlogin <ROLE-userlogin>`

.. code-block:: plpgsql

   -- begin userlogin prelude
   v_owner := (SELECT t.act_as FROM "user"._get_login() AS t);
   -- end userlogin prelude
   
   
   PERFORM commons._raise_inaccessible_or_missing(
       EXISTS(
           SELECT TRUE FROM web.site AS t
           JOIN server_access.user AS s
               USING ("user", service_entity_name)
           WHERE
               t.domain = p_site AND
               t.port = p_site_port AND
               s.owner = v_owner
       )
   );
   
   INSERT INTO web.alias
       (domain, service, subservice, site, site_port, service_entity_name)
   VALUES
       (
           p_domain,
           'web',
           'alias',
           p_site,
           p_site_port,
           (SELECT service_entity_name FROM web.site WHERE domain = p_site AND port = p_site_port)
       );
   
   PERFORM backend._notify_domain('web', 'alias', p_domain);



.. _FUNCTION-web.ins_site:

``web.ins_site``
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Insert site

.. todo:: check owner and contingent

Parameters
 - ``p_domain`` :ref:`dns.t_hostname <DOMAIN-dns.t_hostname>`
   
    
 - ``p_port`` :ref:`commons.t_port <DOMAIN-commons.t_port>`
   
    
 - ``p_https`` :ref:`bool <DOMAIN-bool>`
   
    
 - ``p_user`` :ref:`server_access.t_user <DOMAIN-server_access.t_user>`
   
    
 - ``p_service_entity_name`` :ref:`dns.t_hostname <DOMAIN-dns.t_hostname>`
   
    


Variables defined for body
 - ``v_owner`` :ref:`user.t_user <DOMAIN-user.t_user>`
   
   

Returns
 void


Execute privilege
 - :ref:`userlogin <ROLE-userlogin>`

.. code-block:: plpgsql

   -- begin userlogin prelude
   v_owner := (SELECT t.act_as FROM "user"._get_login() AS t);
   -- end userlogin prelude
   
   
   PERFORM system._contingent_ensure(
       p_owner:=v_owner,
       p_domain:=p_domain,
       p_service:='web',
       p_subservice:='site',
       p_current_quantity_total:=
           (SELECT COUNT(*) FROM web.site WHERE owner=v_owner)::int,
       p_current_quantity_domain:=
           (SELECT COUNT(*) FROM web.site WHERE owner=v_owner AND domain = p_domain)::int
       );
   
   INSERT INTO web.site
       (domain, service, subservice, port, https, "user", service_entity_name, owner)
       VALUES
       (p_domain, 'web', 'site', p_port, p_https, p_user, p_service_entity_name, v_owner);
   
       PERFORM backend._notify_domain('web', 'site', p_domain);



.. _FUNCTION-web.sel_alias:

``web.sel_alias``
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Select alias

Parameters
 *None*


Variables defined for body
 - ``v_owner`` :ref:`user.t_user <DOMAIN-user.t_user>`
   
   

Returns
 TABLE

Returned columns
 - ``domain`` :ref:`dns.t_hostname <DOMAIN-dns.t_hostname>`
    
 - ``site`` :ref:`dns.t_hostname <DOMAIN-dns.t_hostname>`
    
 - ``site_port`` :ref:`commons.t_port <DOMAIN-commons.t_port>`
    
 - ``backend_status`` :ref:`backend.t_status <DOMAIN-backend.t_status>`
    

Execute privilege
 - :ref:`userlogin <ROLE-userlogin>`

.. code-block:: plpgsql

   -- begin userlogin prelude
   v_owner := (SELECT t.act_as FROM "user"._get_login() AS t);
   -- end userlogin prelude
   
   
   RETURN QUERY
       SELECT
           t.domain,
           t.site,
           t.site_port,
           t.backend_status
       FROM web.alias AS t
   
       JOIN web.site AS u
           ON
               u.domain = t.site AND
               u.port = t.site_port
   
       JOIN server_access.user AS s
           ON
               u.user = s.user AND
               s.service_entity_name = t.service_entity_name
   
       WHERE s.owner = v_owner
       ORDER BY t.backend_status, t.domain;



.. _FUNCTION-web.sel_site:

``web.sel_site``
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Owner defined via server_access

Parameters
 *None*


Variables defined for body
 - ``v_owner`` :ref:`user.t_user <DOMAIN-user.t_user>`
   
   

Returns
 TABLE

Returned columns
 - ``service`` :ref:`commons.t_key <DOMAIN-commons.t_key>`
    
 - ``subservice`` :ref:`commons.t_key <DOMAIN-commons.t_key>`
    
 - ``domain`` :ref:`dns.t_hostname <DOMAIN-dns.t_hostname>`
    
 - ``port`` :ref:`commons.t_port <DOMAIN-commons.t_port>`
    
 - ``user`` :ref:`server_access.t_user <DOMAIN-server_access.t_user>`
    
 - ``service_entity_name`` :ref:`dns.t_hostname <DOMAIN-dns.t_hostname>`
    
 - ``https`` :ref:`bool <DOMAIN-bool>`
    
 - ``backend_status`` :ref:`backend.t_status <DOMAIN-backend.t_status>`
    
 - ``option`` :ref:`jsonb <DOMAIN-jsonb>`
    

Execute privilege
 - :ref:`userlogin <ROLE-userlogin>`

.. code-block:: plpgsql

   -- begin userlogin prelude
   v_owner := (SELECT t.act_as FROM "user"._get_login() AS t);
   -- end userlogin prelude
   
   
   RETURN QUERY
       SELECT
           t.service,
           t.subservice,
           t.domain,
           t.port,
           t.user,
           t.service_entity_name,
           t.https,
           t.backend_status,
           t.option
       FROM web.site AS t
       JOIN server_access.user AS s
           USING ("user", service_entity_name)
       WHERE
           s.owner = v_owner
       ORDER BY t.backend_status, t.domain, t.port;



.. _FUNCTION-web.srv_alias:

``web.srv_alias``
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

backend web.alias

Parameters
 - ``p_include_inactive`` :ref:`boolean <DOMAIN-boolean>`
   
    



Returns
 TABLE

Returned columns
 - ``domain`` :ref:`dns.t_hostname <DOMAIN-dns.t_hostname>`
    
 - ``site`` :ref:`dns.t_hostname <DOMAIN-dns.t_hostname>`
    
 - ``site_port`` :ref:`commons.t_port <DOMAIN-commons.t_port>`
    
 - ``backend_status`` :ref:`backend.t_status <DOMAIN-backend.t_status>`
    

Execute privilege
 - :ref:`backend <ROLE-backend>`

.. code-block:: plpgsql

   PERFORM backend._get_login();
   
   
   RETURN QUERY
       WITH
   
       -- DELETE
       d AS (
           DELETE FROM web.alias AS t
           WHERE
               backend._deleted(t.backend_status) AND
               backend._machine_priviledged(t.service, t.domain)
       ),
   
       -- UPDATE
       s AS (
           UPDATE web.alias AS t
               SET backend_status = NULL
           WHERE
               backend._machine_priviledged(t.service, t.domain) AND
               backend._active(t.backend_status)
       )
   
       -- SELECT
       SELECT
           t.domain,
           t.site,
           t.site_port,
           t.backend_status
       FROM web.alias AS t
   
       WHERE
           backend._machine_priviledged(t.service, t.domain) AND
           (backend._active(t.backend_status) OR p_include_inactive);



.. _FUNCTION-web.srv_site:

``web.srv_site``
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

backend web.site

Parameters
 - ``p_include_inactive`` :ref:`boolean <DOMAIN-boolean>`
   
    



Returns
 TABLE

Returned columns
 - ``domain`` :ref:`dns.t_hostname <DOMAIN-dns.t_hostname>`
    
 - ``port`` :ref:`commons.t_port <DOMAIN-commons.t_port>`
    
 - ``user`` :ref:`server_access.t_user <DOMAIN-server_access.t_user>`
    
 - ``service_entity_name`` :ref:`dns.t_hostname <DOMAIN-dns.t_hostname>`
    
 - ``https`` :ref:`bool <DOMAIN-bool>`
    
 - ``subservice`` :ref:`commons.t_key <DOMAIN-commons.t_key>`
    
 - ``option`` :ref:`jsonb <DOMAIN-jsonb>`
    
 - ``backend_status`` :ref:`backend.t_status <DOMAIN-backend.t_status>`
    

Execute privilege
 - :ref:`backend <ROLE-backend>`

.. code-block:: plpgsql

   PERFORM backend._get_login();
   
   
   RETURN QUERY
       WITH
   
       -- DELETE
       d AS (
           DELETE FROM web.site AS t
           WHERE
               backend._deleted(t.backend_status) AND
               backend._machine_priviledged(t.service, t.domain)
       ),
   
       -- UPDATE
       s AS (
           UPDATE web.site AS t
               SET backend_status = NULL
           WHERE
               backend._machine_priviledged(t.service, t.domain) AND
               backend._active(t.backend_status)
       )
   
       -- SELECT
       SELECT
           t.domain,
           t.port,
           t.user,
           t.service_entity_name,
           t.https,
           t.subservice,
           t.option,
           t.backend_status
       FROM web.site AS t
   
       WHERE
           backend._machine_priviledged(t.service, t.domain) AND
           (backend._active(t.backend_status) OR p_include_inactive)
   
       ORDER BY t.domain, t.port;









.. This file was generated via HamSql

