dns
======================================================================

DNS

.. contents:: Module Contents
   :local:
   :depth: 2



Tables
------


.. _TABLE-dns.custom:

``dns.custom``
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Direct name server entries.

Primary key
 - id


.. BEGIN FKs


.. END FKs


Columns
 - .. _COLUMN-dns.custom.type:
   
   ``type`` :ref:`dns.t_type <DOMAIN-dns.t_type>`
     Type (A, AAAA, CNAME, MX, SRV, TXT, ...)





 - .. _COLUMN-dns.custom.rdata:
   
   ``rdata`` :ref:`dns.t_rdata <DOMAIN-dns.t_rdata>`
     fancy rdata storage





 - .. _COLUMN-dns.custom.ttl:
   
   ``ttl`` *NULL* | :ref:`dns.t_ttl <DOMAIN-dns.t_ttl>`
     Time to live, NULL indicates default value





 - .. _COLUMN-dns.custom.backend_status:
   
   ``backend_status`` *NULL* | :ref:`backend.t_status <DOMAIN-backend.t_status>`
     Status of database entry in backend. NULL: nothing pending,
     'ins': entry not present on backend client, 'upd': update
     pending on backend client, 'del': deletion peding on
     backend client.

   Default
    .. code-block:: sql

     'ins'




 - .. _COLUMN-dns.custom.registered:
   
   ``registered`` :ref:`dns.t_domain <DOMAIN-dns.t_domain>`
     Registered domain of which domain is a sub domain


   References :ref:`dns.registered.domain <COLUMN-dns.registered.domain>`



 - .. _COLUMN-dns.custom.domain:
   
   ``domain`` :ref:`dns.t_domain <DOMAIN-dns.t_domain>`
     domain of entry





 - .. _COLUMN-dns.custom.id:
   
   ``id`` :ref:`uuid <DOMAIN-uuid>`
     uuid serial number to identify database elements uniquely
     The default value is generated using uuid_generate_v4().

   Default
    .. code-block:: sql

     uuid_generate_v4()






.. _TABLE-dns.registered:

``dns.registered``
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Domains registered under a public suffix.

Primary key
 - domain


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
 - .. _COLUMN-dns.registered.owner:
   
   ``owner`` :ref:`user.t_user <DOMAIN-user.t_user>`
     for ownage


   References :ref:`user.user.owner <COLUMN-user.user.owner>`



 - .. _COLUMN-dns.registered.backend_status:
   
   ``backend_status`` *NULL* | :ref:`backend.t_status <DOMAIN-backend.t_status>`
     Status of database entry in backend. NULL: nothing pending,
     'ins': entry not present on backend client, 'upd': update
     pending on backend client, 'del': deletion peding on
     backend client.

   Default
    .. code-block:: sql

     'ins'




 - .. _COLUMN-dns.registered.service_entity_name:
   
   ``service_entity_name`` :ref:`dns.t_domain <DOMAIN-dns.t_domain>`
     Service entity name





 - .. _COLUMN-dns.registered.service:
   
   ``service`` :ref:`commons.t_key <DOMAIN-commons.t_key>`
     Service (e.g. email, jabber)





 - .. _COLUMN-dns.registered.subservice:
   
   ``subservice`` :ref:`commons.t_key <DOMAIN-commons.t_key>`
     Subservice (e.g. account, alias)





 - .. _COLUMN-dns.registered.domain:
   
   ``domain`` :ref:`dns.t_domain <DOMAIN-dns.t_domain>`
     Domain





 - .. _COLUMN-dns.registered.public_suffix:
   
   ``public_suffix`` :ref:`varchar <DOMAIN-varchar>`
     Public Suffix







.. _TABLE-dns.service:

``dns.service``
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Name server entries based on system.service (i.e. system.service_dns)

Primary key
 - domain
 - service


.. BEGIN FKs

Foreign keys
 - Reference service entity

   Local Columns
    - service_entity_name
    - service

   Referenced Columns
    - :ref:`system.service_entity.service_entity_name <COLUMN-system.service_entity.service_entity_name>`
    - :ref:`system.service_entity.service <COLUMN-system.service_entity.service>`


.. END FKs


Columns
 - .. _COLUMN-dns.service.service_entity_name:
   
   ``service_entity_name`` :ref:`dns.t_domain <DOMAIN-dns.t_domain>`
     Service entity name





 - .. _COLUMN-dns.service.service:
   
   ``service`` :ref:`commons.t_key <DOMAIN-commons.t_key>`
     Service (e.g. email, jabber)





 - .. _COLUMN-dns.service.backend_status:
   
   ``backend_status`` *NULL* | :ref:`backend.t_status <DOMAIN-backend.t_status>`
     Status of database entry in backend. NULL: nothing pending,
     'ins': entry not present on backend client, 'upd': update
     pending on backend client, 'del': deletion peding on
     backend client.

   Default
    .. code-block:: sql

     'ins'




 - .. _COLUMN-dns.service.registered:
   
   ``registered`` :ref:`dns.t_domain <DOMAIN-dns.t_domain>`
     Registered domain of which domain is a sub domain


   References :ref:`dns.registered.domain <COLUMN-dns.registered.domain>`



 - .. _COLUMN-dns.service.domain:
   
   ``domain`` :ref:`dns.t_domain <DOMAIN-dns.t_domain>`
     domain for which the entries should be created










Functions
---------



.. _FUNCTION-dns._domain_order:

``dns._domain_order``
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

ORDER

Parameters
 - ``p_domain`` :ref:`dns.t_domain <DOMAIN-dns.t_domain>`
   
    



Returns
 varchar[]


Execute privilege
 - :ref:`userlogin <ROLE-userlogin>`
 - :ref:`backend <ROLE-backend>`

.. code-block:: plpgsql

   



.. _FUNCTION-dns._rdata_txtdata_valid:

``dns._rdata_txtdata_valid``
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Rdata txt-data valid

Parameters
 - ``p_txtdata`` :ref:`varchar[] <DOMAIN-varchar[]>`
   
    



Returns
 bool



.. code-block:: plpgsql

   
   RETURN ((
      SELECT DISTINCT TRUE
          FROM UNNEST(p_txtdata) AS s
          WHERE octet_length(s) > 255
   ) IS NULL);



.. _FUNCTION-dns.del_custom:

``dns.del_custom``
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Delete Custom

Parameters
 - ``p_id`` :ref:`uuid <DOMAIN-uuid>`
   
    


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



.. _FUNCTION-dns.del_registered:

``dns.del_registered``
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Delete registered domain

Parameters
 - ``p_domain`` :ref:`dns.t_domain <DOMAIN-dns.t_domain>`
   
    


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



.. _FUNCTION-dns.del_service:

``dns.del_service``
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

deletes all service entries of a specific domain

Parameters
 - ``p_domain`` :ref:`dns.t_domain <DOMAIN-dns.t_domain>`
   
    
 - ``p_service`` :ref:`commons.t_key <DOMAIN-commons.t_key>`
   
    


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



.. _FUNCTION-dns.fwd_registered_status:

``dns.fwd_registered_status``
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Update status

Parameters
 - ``p_domain`` :ref:`dns.t_domain <DOMAIN-dns.t_domain>`
   
    
 - ``p_backend_status`` :ref:`backend.t_status <DOMAIN-backend.t_status>`
   
    
 - ``p_include_inactive`` :ref:`boolean <DOMAIN-boolean>`
   
    


Variables defined for body
 - ``v_machine`` :ref:`dns.t_domain <DOMAIN-dns.t_domain>`
   
   

Returns
 void


Execute privilege
 - :ref:`backend <ROLE-backend>`

.. code-block:: plpgsql

   v_machine := (SELECT "machine" FROM "backend"._get_login());



.. _FUNCTION-dns.ins_custom:

``dns.ins_custom``
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Ins Custom

Parameters
 - ``p_registered`` :ref:`dns.t_domain <DOMAIN-dns.t_domain>`
   
    
 - ``p_domain`` :ref:`dns.t_domain <DOMAIN-dns.t_domain>`
   
    
 - ``p_type`` :ref:`dns.t_type <DOMAIN-dns.t_type>`
   
    
 - ``p_rdata`` :ref:`dns.t_rdata <DOMAIN-dns.t_rdata>`
   
    
 - ``p_ttl`` :ref:`integer <DOMAIN-integer>`
   
    


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



.. _FUNCTION-dns.ins_registered:

``dns.ins_registered``
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

registeres new domain

Parameters
 - ``p_domain`` :ref:`dns.t_domain <DOMAIN-dns.t_domain>`
   
    
 - ``p_subservice`` :ref:`commons.t_key <DOMAIN-commons.t_key>`
   
    
 - ``p_service_entity_name`` :ref:`dns.t_domain <DOMAIN-dns.t_domain>`
   
    
 - ``p_public_suffix`` :ref:`varchar <DOMAIN-varchar>`
   
    


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



.. _FUNCTION-dns.ins_service:

``dns.ins_service``
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Creates service dns entry

Parameters
 - ``p_registered`` :ref:`dns.t_domain <DOMAIN-dns.t_domain>`
   
    
 - ``p_domain`` :ref:`dns.t_domain <DOMAIN-dns.t_domain>`
   
    
 - ``p_service_entity_name`` :ref:`dns.t_domain <DOMAIN-dns.t_domain>`
   
    
 - ``p_service`` :ref:`commons.t_key <DOMAIN-commons.t_key>`
   
    


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



.. _FUNCTION-dns.sel_activatable_service:

``dns.sel_activatable_service``
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Activatable services

Parameters
 *None*


Variables defined for body
 - ``v_owner`` :ref:`user.t_user <DOMAIN-user.t_user>`
   
   
 - ``v_login`` :ref:`user.t_user <DOMAIN-user.t_user>`
   
   

Returns
 TABLE

Returned columns
 - ``service`` :ref:`commons.t_key <DOMAIN-commons.t_key>`
    
 - ``service_entity_name`` :ref:`dns.t_domain <DOMAIN-dns.t_domain>`
    

Execute privilege
 - :ref:`userlogin <ROLE-userlogin>`

.. code-block:: plpgsql

   -- begin userlogin prelude
   v_login := (SELECT t.owner FROM "user"._get_login() AS t);
   v_owner := (SELECT t.act_as FROM "user"._get_login() AS t);
   -- end userlogin prelude



.. _FUNCTION-dns.sel_available_service:

``dns.sel_available_service``
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

List all domains that have a service entry in dns with their service.
This is particularly usefull since these domains are ready for use with
this service. Usually this means that accounts etc. can be created for this
domain.

Parameters
 *None*


Variables defined for body
 - ``v_owner`` :ref:`user.t_user <DOMAIN-user.t_user>`
   
   
 - ``v_login`` :ref:`user.t_user <DOMAIN-user.t_user>`
   
   

Returns
 TABLE

Returned columns
 - ``domain`` :ref:`dns.t_domain <DOMAIN-dns.t_domain>`
    
 - ``service`` :ref:`commons.t_key <DOMAIN-commons.t_key>`
    

Execute privilege
 - :ref:`userlogin <ROLE-userlogin>`

.. code-block:: plpgsql

   -- begin userlogin prelude
   v_login := (SELECT t.owner FROM "user"._get_login() AS t);
   v_owner := (SELECT t.act_as FROM "user"._get_login() AS t);
   -- end userlogin prelude



.. _FUNCTION-dns.sel_custom:

``dns.sel_custom``
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

sel custom

Parameters
 *None*


Variables defined for body
 - ``v_owner`` :ref:`user.t_user <DOMAIN-user.t_user>`
   
   
 - ``v_login`` :ref:`user.t_user <DOMAIN-user.t_user>`
   
   

Returns
 TABLE

Returned columns
 - ``id`` :ref:`uuid <DOMAIN-uuid>`
    
 - ``registered`` :ref:`dns.t_domain <DOMAIN-dns.t_domain>`
    
 - ``domain`` :ref:`dns.t_domain <DOMAIN-dns.t_domain>`
    
 - ``type`` :ref:`dns.t_type <DOMAIN-dns.t_type>`
    
 - ``rdata`` :ref:`dns.t_rdata <DOMAIN-dns.t_rdata>`
    
 - ``ttl`` :ref:`dns.t_ttl <DOMAIN-dns.t_ttl>`
    
 - ``backend_status`` :ref:`backend.t_status <DOMAIN-backend.t_status>`
    

Execute privilege
 - :ref:`userlogin <ROLE-userlogin>`

.. code-block:: plpgsql

   -- begin userlogin prelude
   v_login := (SELECT t.owner FROM "user"._get_login() AS t);
   v_owner := (SELECT t.act_as FROM "user"._get_login() AS t);
   -- end userlogin prelude



.. _FUNCTION-dns.sel_nameserver:

``dns.sel_nameserver``
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Select available nameservers

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



.. _FUNCTION-dns.sel_registered:

``dns.sel_registered``
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

List registered domains

Parameters
 *None*


Variables defined for body
 - ``v_owner`` :ref:`user.t_user <DOMAIN-user.t_user>`
   
   
 - ``v_login`` :ref:`user.t_user <DOMAIN-user.t_user>`
   
   

Returns
 TABLE

Returned columns
 - ``domain`` :ref:`dns.t_domain <DOMAIN-dns.t_domain>`
    
 - ``public_suffix`` :ref:`varchar <DOMAIN-varchar>`
    
 - ``backend_status`` :ref:`backend.t_status <DOMAIN-backend.t_status>`
    
 - ``subservice`` :ref:`commons.t_key <DOMAIN-commons.t_key>`
    
 - ``service_entity_name`` :ref:`dns.t_domain <DOMAIN-dns.t_domain>`
    

Execute privilege
 - :ref:`userlogin <ROLE-userlogin>`

.. code-block:: plpgsql

   -- begin userlogin prelude
   v_login := (SELECT t.owner FROM "user"._get_login() AS t);
   v_owner := (SELECT t.act_as FROM "user"._get_login() AS t);
   -- end userlogin prelude



.. _FUNCTION-dns.sel_service:

``dns.sel_service``
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Select service based dns entries

Parameters
 *None*


Variables defined for body
 - ``v_owner`` :ref:`user.t_user <DOMAIN-user.t_user>`
   
   
 - ``v_login`` :ref:`user.t_user <DOMAIN-user.t_user>`
   
   

Returns
 TABLE

Returned columns
 - ``registered`` :ref:`dns.t_domain <DOMAIN-dns.t_domain>`
    
 - ``domain`` :ref:`dns.t_domain <DOMAIN-dns.t_domain>`
    
 - ``service`` :ref:`commons.t_key <DOMAIN-commons.t_key>`
    
 - ``service_entity_name`` :ref:`dns.t_domain <DOMAIN-dns.t_domain>`
    
 - ``backend_status`` :ref:`backend.t_status <DOMAIN-backend.t_status>`
    

Execute privilege
 - :ref:`userlogin <ROLE-userlogin>`

.. code-block:: plpgsql

   -- begin userlogin prelude
   v_login := (SELECT t.owner FROM "user"._get_login() AS t);
   v_owner := (SELECT t.act_as FROM "user"._get_login() AS t);
   -- end userlogin prelude



.. _FUNCTION-dns.sel_usable_domain:

``dns.sel_usable_domain``
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Usable domains

Parameters
 - ``p_service`` :ref:`commons.t_key <DOMAIN-commons.t_key>`
   
    
 - ``p_subservice`` :ref:`commons.t_key <DOMAIN-commons.t_key>`
   
    


Variables defined for body
 - ``v_owner`` :ref:`user.t_user <DOMAIN-user.t_user>`
   
   
 - ``v_login`` :ref:`user.t_user <DOMAIN-user.t_user>`
   
   

Returns
 TABLE

Returned columns
 - ``domain`` :ref:`dns.t_domain <DOMAIN-dns.t_domain>`
    
 - ``service_entity_name`` :ref:`dns.t_domain <DOMAIN-dns.t_domain>`
    

Execute privilege
 - :ref:`userlogin <ROLE-userlogin>`

.. code-block:: plpgsql

   -- begin userlogin prelude
   v_login := (SELECT t.owner FROM "user"._get_login() AS t);
   v_owner := (SELECT t.act_as FROM "user"._get_login() AS t);
   -- end userlogin prelude



.. _FUNCTION-dns.srv_record:

``dns.srv_record``
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Servers both record types combined: Raw entries and the ones assembled
from records templates for services (system.service_entity_dns).

Parameters
 - ``p_include_inactive`` :ref:`boolean <DOMAIN-boolean>`
   
    


Variables defined for body
 - ``v_machine`` :ref:`dns.t_domain <DOMAIN-dns.t_domain>`
   
   

Returns
 TABLE

Returned columns
 - ``registered`` :ref:`dns.t_domain <DOMAIN-dns.t_domain>`
    
 - ``domain`` :ref:`dns.t_domain <DOMAIN-dns.t_domain>`
    
 - ``type`` :ref:`dns.t_type <DOMAIN-dns.t_type>`
    
 - ``rdata`` :ref:`dns.t_rdata <DOMAIN-dns.t_rdata>`
    
 - ``ttl`` :ref:`dns.t_ttl <DOMAIN-dns.t_ttl>`
    
 - ``backend_status`` :ref:`backend.t_status <DOMAIN-backend.t_status>`
    

Execute privilege
 - :ref:`backend <ROLE-backend>`

.. code-block:: plpgsql

   v_machine := (SELECT "machine" FROM "backend"._get_login());



.. _FUNCTION-dns.upd_custom:

``dns.upd_custom``
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Ins Custom

Parameters
 - ``p_id`` :ref:`uuid <DOMAIN-uuid>`
   
    
 - ``p_rdata`` :ref:`dns.t_rdata <DOMAIN-dns.t_rdata>`
   
    
 - ``p_ttl`` :ref:`integer <DOMAIN-integer>`
   
    


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





Domains
-------



.. _DOMAIN-dns.t_domain:

``dns.t_domain``
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Fully qualified domain name (without trailing dot)

Checks
 - ``domain valid regex``
    check domain validity

   .. code-block:: sql

    VALUE ~ '^[a-z\d][a-z\d-]{0,62}(\.[a-z\d][a-z\d-]{0,62})+$' AND
    octet_length(VALUE) <= 253




.. _DOMAIN-dns.t_domain_rdata:

``dns.t_domain_rdata``
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Fully qualified or relative domain name. Trailing dot marks a FQDN.

Checks
 - ``invalid rdata domain``
    check

   .. code-block:: sql

    (VALUE ~ '^([a-z\d][a-z\d-]{0,62}\.)+$' OR
     VALUE ~ '^([a-z\d][a-z\d-]{0,62}\.)*[a-z\d][a-z\d-]{1,63}$') AND
    octet_length(VALUE) <= 253




.. _DOMAIN-dns.t_type:

``dns.t_type``
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Resource record type

Checks
 - ``Invalid or unsupported resource type``
    Resource type (A, AAAA, CNAME, MX, SRV, TXT, ...)

   .. code-block:: sql

    VALUE IN (
     'A',
     'AAAA',
     'CNAME',
     'MX',
     'NS',
     'SRV',
     'SSHFP',
     'TXT'
    )




.. _DOMAIN-dns.t_rdata:

``dns.t_rdata``
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Resource record data (Rdata)




.. _DOMAIN-dns.t_ttl:

``dns.t_ttl``
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

time to live

Checks
 - ``ttl range``
    Ensure that TTL is at least one minute and put maximum to 48h

   .. code-block:: sql

    VALUE >= 60 AND VALUE <= 172800







