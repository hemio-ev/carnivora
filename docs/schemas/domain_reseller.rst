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









