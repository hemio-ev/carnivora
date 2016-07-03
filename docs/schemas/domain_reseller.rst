domain_reseller
======================================================================

Features for Domains Registered via a Reseller

Stores additional details for dns.registered domains. Also supports storing
contact informations (handles).

This module sends the following signals:
 - domain_reseller/handle
 - domain_registered/managed
 - domain_registered/unmanaged

.. contents:: Module Contents
   :local:
   :depth: 2



Tables
------


.. _TABLE-domain_reseller.handle:

``domain_reseller.handle``
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Handles (Domain Contacts)

Domain contacts that can be used as owner, admin-c, tech-c or zone-c.

Primary key
 - alias


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
 - .. _COLUMN-domain_reseller.handle.service_entity_name:
   
   ``service_entity_name`` :ref:`dns.t_domain <DOMAIN-dns.t_domain>`
     Service entity name





 - .. _COLUMN-domain_reseller.handle.service:
   
   ``service`` :ref:`commons.t_key <DOMAIN-commons.t_key>`
     Service (e.g. email, jabber)





 - .. _COLUMN-domain_reseller.handle.subservice:
   
   ``subservice`` :ref:`commons.t_key <DOMAIN-commons.t_key>`
     Subservice (e.g. account, alias)





 - .. _COLUMN-domain_reseller.handle.owner:
   
   ``owner`` :ref:`user.t_user <DOMAIN-user.t_user>`
     for ownage


   References :ref:`user.user.owner <COLUMN-user.user.owner>`



 - .. _COLUMN-domain_reseller.handle.backend_status:
   
   ``backend_status`` *NULL* | :ref:`backend.t_status <DOMAIN-backend.t_status>`
     Status of database entry in backend. NULL: nothing pending,
     'ins': entry not present on backend client, 'upd': update
     pending on backend client, 'del': deletion peding on
     backend client.

   Default
    .. code-block:: sql

     'ins'




 - .. _COLUMN-domain_reseller.handle.alias:
   
   ``alias`` :ref:`varchar <DOMAIN-varchar>`
     Free choosable alias





 - .. _COLUMN-domain_reseller.handle.id:
   
   ``id`` *NULL* | :ref:`varchar <DOMAIN-varchar>`
     Internal id at reseller





 - .. _COLUMN-domain_reseller.handle.fname:
   
   ``fname`` :ref:`varchar <DOMAIN-varchar>`
     First name





 - .. _COLUMN-domain_reseller.handle.lname:
   
   ``lname`` :ref:`varchar <DOMAIN-varchar>`
     Last name





 - .. _COLUMN-domain_reseller.handle.address:
   
   ``address`` :ref:`varchar <DOMAIN-varchar>`
     Address





 - .. _COLUMN-domain_reseller.handle.pcode:
   
   ``pcode`` :ref:`varchar <DOMAIN-varchar>`
     Postcode





 - .. _COLUMN-domain_reseller.handle.city:
   
   ``city`` :ref:`varchar <DOMAIN-varchar>`
     City





 - .. _COLUMN-domain_reseller.handle.country:
   
   ``country`` :ref:`varchar <DOMAIN-varchar>`
     Country





 - .. _COLUMN-domain_reseller.handle.state:
   
   ``state`` :ref:`varchar <DOMAIN-varchar>`
     State





 - .. _COLUMN-domain_reseller.handle.email:
   
   ``email`` :ref:`email.t_address <DOMAIN-email.t_address>`
     Email





 - .. _COLUMN-domain_reseller.handle.phone:
   
   ``phone`` :ref:`varchar <DOMAIN-varchar>`
     Phone





 - .. _COLUMN-domain_reseller.handle.organization:
   
   ``organization`` *NULL* | :ref:`varchar <DOMAIN-varchar>`
     Organization





 - .. _COLUMN-domain_reseller.handle.fax:
   
   ``fax`` *NULL* | :ref:`varchar <DOMAIN-varchar>`
     Fax





 - .. _COLUMN-domain_reseller.handle.mobile_phone:
   
   ``mobile_phone`` *NULL* | :ref:`varchar <DOMAIN-varchar>`
     Mobile phone







.. _TABLE-domain_reseller.registered:

``domain_reseller.registered``
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Addtional informations to those stored in dns.registered

Primary key
 - domain


.. BEGIN FKs


.. END FKs


Columns
 - .. _COLUMN-domain_reseller.registered.domain:
   
   ``domain`` :ref:`dns.t_domain <DOMAIN-dns.t_domain>`
     Domain


   References :ref:`dns.registered.domain <COLUMN-dns.registered.domain>`

   On Delete: CASCADE


 - .. _COLUMN-domain_reseller.registered.registrant:
   
   ``registrant`` :ref:`varchar <DOMAIN-varchar>`
     Registrant (Owner)


   References :ref:`domain_reseller.handle.alias <COLUMN-domain_reseller.handle.alias>`



 - .. _COLUMN-domain_reseller.registered.admin_c:
   
   ``admin_c`` :ref:`varchar <DOMAIN-varchar>`
     Admin-C


   References :ref:`domain_reseller.handle.alias <COLUMN-domain_reseller.handle.alias>`



 - .. _COLUMN-domain_reseller.registered.tech_c:
   
   ``tech_c`` *NULL* | :ref:`varchar <DOMAIN-varchar>`
     Tech-C


   References :ref:`domain_reseller.handle.alias <COLUMN-domain_reseller.handle.alias>`



 - .. _COLUMN-domain_reseller.registered.zone_c:
   
   ``zone_c`` *NULL* | :ref:`varchar <DOMAIN-varchar>`
     Zone-C


   References :ref:`domain_reseller.handle.alias <COLUMN-domain_reseller.handle.alias>`



 - .. _COLUMN-domain_reseller.registered.payable:
   
   ``payable`` *NULL* | :ref:`timestamp <DOMAIN-timestamp>`
     Payable





 - .. _COLUMN-domain_reseller.registered.period:
   
   ``period`` *NULL* | :ref:`integer <DOMAIN-integer>`
     Renewal period (years)





 - .. _COLUMN-domain_reseller.registered.registrar_status:
   
   ``registrar_status`` *NULL* | :ref:`varchar <DOMAIN-varchar>`
     Registrar status





 - .. _COLUMN-domain_reseller.registered.registry_status:
   
   ``registry_status`` *NULL* | :ref:`varchar <DOMAIN-varchar>`
     Registry status





 - .. _COLUMN-domain_reseller.registered.last_status:
   
   ``last_status`` *NULL* | :ref:`varchar <DOMAIN-varchar>`
     Last update status










Functions
---------



.. _FUNCTION-domain_reseller.del_handle:

``domain_reseller.del_handle``
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Deletes handle

Parameters
 - ``p_alias`` :ref:`varchar <DOMAIN-varchar>`
   
    


Variables defined for body
 - ``v_service_entity_name`` :ref:`dns.t_domain <DOMAIN-dns.t_domain>`
   
   
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
       DELETE FROM domain_reseller.handle
       WHERE
           alias = p_alias AND
           owner = v_owner;
   
       -- if not failed yet, emulate rollback of DELETE
       RAISE transaction_rollback;
   EXCEPTION
       WHEN transaction_rollback THEN
           UPDATE domain_reseller.handle
                  SET backend_status = 'del'
           WHERE
               alias = p_alias AND
               owner = v_owner
           RETURNING service_entity_name INTO v_service_entity_name;
   
           PERFORM backend._conditional_notify_service_entity_name(
               FOUND, v_service_entity_name, 'domain_reseller', 'handle'
           );
   
   END;



.. _FUNCTION-domain_reseller.fwd_handle_id:

``domain_reseller.fwd_handle_id``
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Insert handle id

Parameters
 - ``p_alias`` :ref:`varchar <DOMAIN-varchar>`
   
    
 - ``p_id`` :ref:`varchar <DOMAIN-varchar>`
   
    
 - ``p_include_inactive`` :ref:`boolean <DOMAIN-boolean>`
   
    


Variables defined for body
 - ``v_machine`` :ref:`dns.t_domain <DOMAIN-dns.t_domain>`
   
   

Returns
 void


Execute privilege
 - :ref:`backend <ROLE-backend>`

.. code-block:: plpgsql

   v_machine := (SELECT "machine" FROM "backend"._get_login());
   
   
   UPDATE domain_reseller.handle
   SET id = p_id
   WHERE alias = p_alias;



.. _FUNCTION-domain_reseller.fwd_registered_status:

``domain_reseller.fwd_registered_status``
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Update status

Parameters
 - ``p_domain`` :ref:`dns.t_domain <DOMAIN-dns.t_domain>`
   
    
 - ``p_payable`` :ref:`timestamp <DOMAIN-timestamp>`
   
    
 - ``p_period`` :ref:`integer <DOMAIN-integer>`
   
    
 - ``p_registrar_status`` :ref:`varchar <DOMAIN-varchar>`
   
    
 - ``p_registry_status`` :ref:`varchar <DOMAIN-varchar>`
   
    
 - ``p_last_status`` :ref:`varchar <DOMAIN-varchar>`
   
    
 - ``p_include_inactive`` :ref:`boolean <DOMAIN-boolean>`
   
    


Variables defined for body
 - ``v_machine`` :ref:`dns.t_domain <DOMAIN-dns.t_domain>`
   
   

Returns
 void


Execute privilege
 - :ref:`backend <ROLE-backend>`

.. code-block:: plpgsql

   v_machine := (SELECT "machine" FROM "backend"._get_login());
   
   
   UPDATE domain_reseller.registered
   SET
       payable = p_payable,
       period = p_period,
       registrar_status = p_registrar_status,
       registry_status = p_registry_status,
       last_status = p_last_status
   WHERE domain = p_domain;



.. _FUNCTION-domain_reseller.ins_handle:

``domain_reseller.ins_handle``
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Inserts handle

Parameters
 - ``p_alias`` :ref:`varchar <DOMAIN-varchar>`
   
    
 - ``p_service_entity_name`` :ref:`dns.t_domain <DOMAIN-dns.t_domain>`
   
    
 - ``p_fname`` :ref:`varchar <DOMAIN-varchar>`
   
    
 - ``p_lname`` :ref:`varchar <DOMAIN-varchar>`
   
    
 - ``p_address`` :ref:`varchar <DOMAIN-varchar>`
   
    
 - ``p_pcode`` :ref:`varchar <DOMAIN-varchar>`
   
    
 - ``p_city`` :ref:`varchar <DOMAIN-varchar>`
   
    
 - ``p_country`` :ref:`varchar <DOMAIN-varchar>`
   
    
 - ``p_state`` :ref:`varchar <DOMAIN-varchar>`
   
    
 - ``p_email`` :ref:`email.t_address <DOMAIN-email.t_address>`
   
    
 - ``p_phone`` :ref:`varchar <DOMAIN-varchar>`
   
    
 - ``p_organization`` :ref:`varchar <DOMAIN-varchar>`
   
    
 - ``p_fax`` :ref:`varchar <DOMAIN-varchar>`
   
    
 - ``p_mobile_phone`` :ref:`varchar <DOMAIN-varchar>`
   
    


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
   
   
   INSERT INTO domain_reseller.handle
   (
     service_entity_name,
     service,
     subservice,
     owner,
     alias,
     fname,
     lname,
     address,
     pcode,
     city,
     country,
     state,
     email,
     phone,
     organization,
     fax,
     mobile_phone
   )
   VALUES
   (
     p_service_entity_name,
     'domain_reseller',
     'handle',
     v_owner,
     p_alias,
     p_fname,
     p_lname,
     p_address,
     p_pcode,
     p_city,
     p_country,
     p_state,
     p_email,
     p_phone,
     p_organization,
     p_fax,
     p_mobile_phone
   );
   
   PERFORM backend._notify_service_entity_name(p_service_entity_name, 'domain_reseller', 'handle');



.. _FUNCTION-domain_reseller.ins_registered:

``domain_reseller.ins_registered``
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Inserts details for registered domain

Parameters
 - ``p_domain`` :ref:`dns.t_domain <DOMAIN-dns.t_domain>`
   
    
 - ``p_registrant`` :ref:`varchar <DOMAIN-varchar>`
   
    
 - ``p_admin_c`` :ref:`varchar <DOMAIN-varchar>`
   
    


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
   
   
   INSERT INTO domain_reseller.registered
       (domain, registrant, admin_c)
   VALUES
       (p_domain, p_registrant, p_admin_c);



.. _FUNCTION-domain_reseller.sel_handle:

``domain_reseller.sel_handle``
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Selects handles

Parameters
 - ``p_hide_foreign`` :ref:`bool <DOMAIN-bool>`
   
    


Variables defined for body
 - ``v_owner`` :ref:`user.t_user <DOMAIN-user.t_user>`
   
   
 - ``v_login`` :ref:`user.t_user <DOMAIN-user.t_user>`
   
   

Returns
 SETOF domain_reseller."handle"


Execute privilege
 - :ref:`userlogin <ROLE-userlogin>`

.. code-block:: plpgsql

   -- begin userlogin prelude
   v_login := (SELECT t.owner FROM "user"._get_login() AS t);
   v_owner := (SELECT t.act_as FROM "user"._get_login() AS t);
   -- end userlogin prelude
   
   
   RETURN QUERY
       SELECT * FROM domain_reseller.handle
   WHERE
       owner=v_owner OR (owner=v_login AND NOT p_hide_foreign)
   ORDER BY backend_status, fname, lname, alias;



.. _FUNCTION-domain_reseller.sel_registered:

``domain_reseller.sel_registered``
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Selects details for registered domains

Parameters
 *None*


Variables defined for body
 - ``v_owner`` :ref:`user.t_user <DOMAIN-user.t_user>`
   
   
 - ``v_login`` :ref:`user.t_user <DOMAIN-user.t_user>`
   
   

Returns
 TABLE

Returned columns
 - ``domain`` :ref:`dns.t_domain <DOMAIN-dns.t_domain>`
    
 - ``registrant`` :ref:`varchar <DOMAIN-varchar>`
    
 - ``admin_c`` :ref:`varchar <DOMAIN-varchar>`
    
 - ``tech_c`` :ref:`varchar <DOMAIN-varchar>`
    
 - ``zone_c`` :ref:`varchar <DOMAIN-varchar>`
    
 - ``payable`` :ref:`timestamp <DOMAIN-timestamp>`
    
 - ``period`` :ref:`integer <DOMAIN-integer>`
    
 - ``registrar_status`` :ref:`varchar <DOMAIN-varchar>`
    
 - ``registry_status`` :ref:`varchar <DOMAIN-varchar>`
    
 - ``last_status`` :ref:`varchar <DOMAIN-varchar>`
    
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
           t.domain,
           t.registrant,
           t.admin_c,
           t.tech_c,
           t.zone_c,
           t.payable,
           t.period,
           t.registrar_status,
           t.registry_status,
           t.last_status,
           s.backend_status
       FROM domain_reseller.registered AS t
       JOIN dns.registered AS s
           USING (domain)
       WHERE
           s.owner = v_owner;



.. _FUNCTION-domain_reseller.sel_reseller:

``domain_reseller.sel_reseller``
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Selects available resellers

Parameters
 *None*


Variables defined for body
 - ``v_owner`` :ref:`user.t_user <DOMAIN-user.t_user>`
   
   
 - ``v_login`` :ref:`user.t_user <DOMAIN-user.t_user>`
   
   

Returns
 TABLE

Returned columns
 - ``subservice`` :ref:`commons.t_key <DOMAIN-commons.t_key>`
    
 - ``service_entity_name`` :ref:`dns.t_domain <DOMAIN-dns.t_domain>`
    

Execute privilege
 - :ref:`userlogin <ROLE-userlogin>`

.. code-block:: plpgsql

   -- begin userlogin prelude
   v_login := (SELECT t.owner FROM "user"._get_login() AS t);
   v_owner := (SELECT t.act_as FROM "user"._get_login() AS t);
   -- end userlogin prelude
   
   RETURN QUERY
   SELECT
       COALESCE(t.subservice, s.subservice) AS subservice,
       COALESCE(t.service_entity_name, s.service_entity_name) AS service_entity_name
   FROM system._effective_contingent() AS t
   FULL OUTER JOIN system._effective_contingent_domain() AS s
   USING (service, subservice, service_entity_name, owner)
   WHERE
       COALESCE(t.service, s.service) = 'domain_reseller' AND
       COALESCE(t.owner, s.owner) = v_owner
   ;



.. _FUNCTION-domain_reseller.srv_handle:

``domain_reseller.srv_handle``
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Serves handles

Parameters
 - ``p_include_inactive`` :ref:`boolean <DOMAIN-boolean>`
   
    


Variables defined for body
 - ``v_machine`` :ref:`dns.t_domain <DOMAIN-dns.t_domain>`
   
   

Returns
 SETOF domain_reseller."handle"


Execute privilege
 - :ref:`backend <ROLE-backend>`

.. code-block:: plpgsql

   v_machine := (SELECT "machine" FROM "backend"._get_login());
   
   RETURN QUERY
       WITH
   
       -- DELETE
       d AS (
           DELETE FROM domain_reseller.handle AS t
           WHERE
               backend._machine_priviledged_service(t.service, t.service_entity_name) AND
               backend._deleted(t.backend_status)
       ),
   
       -- UPDATE
       s AS (
           UPDATE domain_reseller.handle AS t
               SET backend_status = NULL
           WHERE
               backend._machine_priviledged_service(t.service, t.service_entity_name) AND
               backend._active(t.backend_status)
       )
   
       SELECT * FROM domain_reseller.handle AS t
       WHERE
           backend._machine_priviledged_service(t.service, t.service_entity_name) AND
           (backend._active(t.backend_status) OR p_include_inactive);



.. _FUNCTION-domain_reseller.srv_registered:

``domain_reseller.srv_registered``
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Serves details for registered domains

Parameters
 - ``p_include_inactive`` :ref:`boolean <DOMAIN-boolean>`
   
    


Variables defined for body
 - ``v_machine`` :ref:`dns.t_domain <DOMAIN-dns.t_domain>`
   
   

Returns
 TABLE

Returned columns
 - ``domain`` :ref:`dns.t_domain <DOMAIN-dns.t_domain>`
    
 - ``registrant`` :ref:`varchar <DOMAIN-varchar>`
    
 - ``registrant_id`` :ref:`varchar <DOMAIN-varchar>`
    
 - ``admin_c`` :ref:`varchar <DOMAIN-varchar>`
    
 - ``admin_c_id`` :ref:`varchar <DOMAIN-varchar>`
    
 - ``tech_c`` :ref:`varchar <DOMAIN-varchar>`
    
 - ``tech_c_id`` :ref:`varchar <DOMAIN-varchar>`
    
 - ``zone_c`` :ref:`varchar <DOMAIN-varchar>`
    
 - ``zone_c_id`` :ref:`varchar <DOMAIN-varchar>`
    
 - ``backend_status`` :ref:`backend.t_status <DOMAIN-backend.t_status>`
    

Execute privilege
 - :ref:`backend <ROLE-backend>`

.. code-block:: plpgsql

   v_machine := (SELECT "machine" FROM "backend"._get_login());
   
   RETURN QUERY
   SELECT
       t.domain,
       t.registrant,
       (SELECT id FROM domain_reseller.handle WHERE alias = t.registrant),
       t.admin_c,
       (SELECT id FROM domain_reseller.handle WHERE alias = t.admin_c),
       t.tech_c,
       (SELECT id FROM domain_reseller.handle WHERE alias = t.tech_c),
       t.zone_c,
       (SELECT id FROM domain_reseller.handle WHERE alias = t.zone_c),
       s.backend_status
    FROM domain_reseller.registered AS t
   JOIN dns.registered AS s USING (domain)
   WHERE
   backend._machine_priviledged_service(s.service, s.service_entity_name) AND
   (backend._active(s.backend_status) OR p_include_inactive);



.. _FUNCTION-domain_reseller.upd_handle:

``domain_reseller.upd_handle``
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Updates handle

Parameters
 - ``p_alias`` :ref:`varchar <DOMAIN-varchar>`
   
    
 - ``p_address`` :ref:`varchar <DOMAIN-varchar>`
   
    
 - ``p_pcode`` :ref:`varchar <DOMAIN-varchar>`
   
    
 - ``p_city`` :ref:`varchar <DOMAIN-varchar>`
   
    
 - ``p_country`` :ref:`varchar <DOMAIN-varchar>`
   
    
 - ``p_state`` :ref:`varchar <DOMAIN-varchar>`
   
    
 - ``p_email`` :ref:`email.t_address <DOMAIN-email.t_address>`
   
    
 - ``p_phone`` :ref:`varchar <DOMAIN-varchar>`
   
    
 - ``p_organization`` :ref:`varchar <DOMAIN-varchar>`
   
    
 - ``p_fax`` :ref:`varchar <DOMAIN-varchar>`
   
    
 - ``p_mobile_phone`` :ref:`varchar <DOMAIN-varchar>`
   
    


Variables defined for body
 - ``v_service_entity_name`` :ref:`dns.t_domain <DOMAIN-dns.t_domain>`
   
   
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
   
   
   UPDATE domain_reseller.handle
       SET
           backend_status = 'upd',
           address = p_address,
           pcode = p_pcode,
           city = p_city,
           country = p_country,
           state = p_state,
           email = p_email,
           phone = p_phone,
           organization = p_organization,
           fax = p_fax,
           mobile_phone = p_mobile_phone
   
   WHERE
       alias = p_alias AND
       owner = v_owner
   RETURNING service_entity_name INTO v_service_entity_name;
   
   PERFORM backend._conditional_notify_service_entity_name(
       FOUND, v_service_entity_name, 'domain_reseller', 'handle'
   );



.. _FUNCTION-domain_reseller.upd_registered:

``domain_reseller.upd_registered``
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Updates details for registered domain

Parameters
 - ``p_domain`` :ref:`dns.t_domain <DOMAIN-dns.t_domain>`
   
    
 - ``p_admin_c`` :ref:`varchar <DOMAIN-varchar>`
   
    


Variables defined for body
 - ``v_nameserver`` :ref:`dns.t_domain <DOMAIN-dns.t_domain>`
   
   
 - ``v_managed`` :ref:`commons.t_key <DOMAIN-commons.t_key>`
   
   
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
   
   UPDATE domain_reseller.registered AS t
       SET
           admin_c = p_admin_c
   FROM dns.registered AS s
   WHERE
       s.domain = t.domain AND
       s.owner = v_owner AND
   
       t.domain = p_domain;
   
   UPDATE dns.registered AS t
       SET backend_status = 'upd'
   WHERE
       t.owner = v_owner AND
       t.domain = p_domain AND
       -- don't change domains that are in some transition status
       (t.backend_status = 'upd' OR t.backend_status IS NULL)
   RETURNING t.service_entity_name, t.subservice
           INTO v_nameserver, v_managed;
   
   PERFORM backend._conditional_notify_service_entity_name(
       FOUND, v_nameserver, 'domain_registered', v_managed
   );









