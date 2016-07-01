web
======================================================================

Websites

This module sends the following signals:
 - web/alias
 - web/site

.. contents:: Module Contents
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
   
   ``domain`` :ref:`dns.t_domain <DOMAIN-dns.t_domain>`
     Domain name





 - .. _COLUMN-web.alias.service:
   
   ``service`` :ref:`commons.t_key <DOMAIN-commons.t_key>`
     Service





 - .. _COLUMN-web.alias.service_entity_name:
   
   ``service_entity_name`` :ref:`dns.t_domain <DOMAIN-dns.t_domain>`
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
   
   ``site`` :ref:`dns.t_domain <DOMAIN-dns.t_domain>`
     Site





 - .. _COLUMN-web.alias.site_port:
   
   ``site_port`` :ref:`commons.t_port <DOMAIN-commons.t_port>`
     port

   Default
    .. code-block:: sql

     80






.. _TABLE-web.https:

``web.https``
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

stores https information

Primary key
 - identifier
 - domain
 - port


.. BEGIN FKs

Foreign keys
 - site

   Local Columns
    - domain
    - port

   Referenced Columns
    - :ref:`web.site.domain <COLUMN-web.site.domain>`
    - :ref:`web.site.port <COLUMN-web.site.port>`


.. END FKs


Columns
 - .. _COLUMN-web.https.backend_status:
   
   ``backend_status`` *NULL* | :ref:`backend.t_status <DOMAIN-backend.t_status>`
     Status of database entry in backend. NULL: nothing pending,
     'ins': entry not present on backend client, 'upd': update
     pending on backend client, 'del': deletion peding on
     backend client.

   Default
    .. code-block:: sql

     'ins'




 - .. _COLUMN-web.https.identifier:
   
   ``identifier`` :ref:`commons.t_key <DOMAIN-commons.t_key>`
     PK





 - .. _COLUMN-web.https.domain:
   
   ``domain`` :ref:`dns.t_domain <DOMAIN-dns.t_domain>`
     Domain





 - .. _COLUMN-web.https.port:
   
   ``port`` :ref:`commons.t_port <DOMAIN-commons.t_port>`
     Port





 - .. _COLUMN-web.https.x509_request:
   
   ``x509_request`` *NULL* | :ref:`web.t_cert <DOMAIN-web.t_cert>`
     Certificate request





 - .. _COLUMN-web.https.x509_certificate:
   
   ``x509_certificate`` *NULL* | :ref:`web.t_cert <DOMAIN-web.t_cert>`
     Certificate





 - .. _COLUMN-web.https.authority_key_identifier:
   
   ``authority_key_identifier`` *NULL* | :ref:`varchar <DOMAIN-varchar>`
     Identifier of the certificate that has signed this cert.
     The Authority Key Identifier allows to build the chain of trust.
     See <http://www.ietf.org/rfc/rfc3280.txt>.
     Hopefully there exists an entry in web.intermediate_cert
     or a root certificate with an equal subjectKeyIdentifier.
     
     Is NULL whenever x509_certificate is NULL.







.. _TABLE-web.intermediate_cert:

``web.intermediate_cert``
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Intermediate certificates

Primary key
 - subject_key_identifier


.. BEGIN FKs


.. END FKs


Columns
 - .. _COLUMN-web.intermediate_cert.subject_key_identifier:
   
   ``subject_key_identifier`` :ref:`varchar <DOMAIN-varchar>`
     Identifies this certificate





 - .. _COLUMN-web.intermediate_cert.authority_key_identifier:
   
   ``authority_key_identifier`` :ref:`varchar <DOMAIN-varchar>`
     Subject key identifier of the cert that has signed this cert.
     NULL is not allowed, since self signed cert do not belong into intermediate
     certs.





 - .. _COLUMN-web.intermediate_cert.x509_certificate:
   
   ``x509_certificate`` :ref:`web.t_cert <DOMAIN-web.t_cert>`
     Intermediate certificate







.. _TABLE-web.intermediate_chain:

``web.intermediate_chain``
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

xxx

Primary key
 - domain
 - port
 - identifier
 - subject_key_identifier


.. BEGIN FKs

Foreign keys
 - https cert

   Local Columns
    - domain
    - port
    - identifier

   Referenced Columns
    - :ref:`web.https.domain <COLUMN-web.https.domain>`
    - :ref:`web.https.port <COLUMN-web.https.port>`
    - :ref:`web.https.identifier <COLUMN-web.https.identifier>`


.. END FKs


Columns
 - .. _COLUMN-web.intermediate_chain.domain:
   
   ``domain`` :ref:`dns.t_domain <DOMAIN-dns.t_domain>`
     Domain





 - .. _COLUMN-web.intermediate_chain.port:
   
   ``port`` :ref:`commons.t_port <DOMAIN-commons.t_port>`
     Port





 - .. _COLUMN-web.intermediate_chain.identifier:
   
   ``identifier`` :ref:`commons.t_key <DOMAIN-commons.t_key>`
     Identifier





 - .. _COLUMN-web.intermediate_chain.order:
   
   ``order`` :ref:`integer <DOMAIN-integer>`
     Ordering from leaf to root





 - .. _COLUMN-web.intermediate_chain.subject_key_identifier:
   
   ``subject_key_identifier`` :ref:`varchar <DOMAIN-varchar>`
     SubjectKeyIdentifier


   References :ref:`web.intermediate_cert.subject_key_identifier <COLUMN-web.intermediate_cert.subject_key_identifier>`





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

 - https

   Local Columns
    - domain
    - port
    - https

   Referenced Columns
    - :ref:`web.https.domain <COLUMN-web.https.domain>`
    - :ref:`web.https.port <COLUMN-web.https.port>`
    - :ref:`web.https.identifier <COLUMN-web.https.identifier>`

 - server_access

   Local Columns
    - user
    - service_entity_name

   Referenced Columns
    - :ref:`server_access.user.user <COLUMN-server_access.user.user>`
    - :ref:`server_access.user.service_entity_name <COLUMN-server_access.user.service_entity_name>`


.. END FKs


Columns
 - .. _COLUMN-web.site.domain:
   
   ``domain`` :ref:`dns.t_domain <DOMAIN-dns.t_domain>`
     Domain name





 - .. _COLUMN-web.site.service:
   
   ``service`` :ref:`commons.t_key <DOMAIN-commons.t_key>`
     Service





 - .. _COLUMN-web.site.service_entity_name:
   
   ``service_entity_name`` :ref:`dns.t_domain <DOMAIN-dns.t_domain>`
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




 - .. _COLUMN-web.site.port:
   
   ``port`` :ref:`commons.t_port <DOMAIN-commons.t_port>`
     Port





 - .. _COLUMN-web.site.user:
   
   ``user`` :ref:`server_access.t_user <DOMAIN-server_access.t_user>`
     Server account under which the htdocs reside





 - .. _COLUMN-web.site.https:
   
   ``https`` *NULL* | :ref:`commons.t_key <DOMAIN-commons.t_key>`
     If null, HTTPS is deactivated










Functions
---------



.. _FUNCTION-web.del_alias:

``web.del_alias``
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

del

Parameters
 - ``p_domain`` :ref:`dns.t_domain <DOMAIN-dns.t_domain>`
   
    
 - ``p_site_port`` :ref:`commons.t_port <DOMAIN-commons.t_port>`
   
    


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



.. _FUNCTION-web.del_intermediate_chain:

``web.del_intermediate_chain``
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

sdf

Parameters
 - ``p_domain`` :ref:`dns.t_domain <DOMAIN-dns.t_domain>`
   
    
 - ``p_port`` :ref:`commons.t_port <DOMAIN-commons.t_port>`
   
    
 - ``p_identifier`` :ref:`commons.t_key <DOMAIN-commons.t_key>`
   
    


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



.. _FUNCTION-web.del_site:

``web.del_site``
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

del

Parameters
 - ``p_domain`` :ref:`dns.t_domain <DOMAIN-dns.t_domain>`
   
    
 - ``p_port`` :ref:`commons.t_port <DOMAIN-commons.t_port>`
   
    


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



.. _FUNCTION-web.fwd_x509_request:

``web.fwd_x509_request``
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

x509 request

Parameters
 - ``p_domain`` :ref:`dns.t_domain <DOMAIN-dns.t_domain>`
   
    
 - ``p_port`` :ref:`commons.t_port <DOMAIN-commons.t_port>`
   
    
 - ``p_identifier`` :ref:`commons.t_key <DOMAIN-commons.t_key>`
   
    
 - ``p_x509_request`` :ref:`web.t_cert <DOMAIN-web.t_cert>`
   
    
 - ``p_include_inactive`` :ref:`boolean <DOMAIN-boolean>`
   
    


Variables defined for body
 - ``v_machine`` :ref:`dns.t_domain <DOMAIN-dns.t_domain>`
   
   

Returns
 void


Execute privilege
 - :ref:`backend <ROLE-backend>`

.. code-block:: plpgsql

   v_machine := (SELECT "machine" FROM "backend"._get_login());



.. _FUNCTION-web.ins_alias:

``web.ins_alias``
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Insert alias

Parameters
 - ``p_domain`` :ref:`dns.t_domain <DOMAIN-dns.t_domain>`
   
    
 - ``p_site`` :ref:`dns.t_domain <DOMAIN-dns.t_domain>`
   
    
 - ``p_site_port`` :ref:`commons.t_port <DOMAIN-commons.t_port>`
   
    


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



.. _FUNCTION-web.ins_https:

``web.ins_https``
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Ins HTTPS

Parameters
 - ``p_domain`` :ref:`dns.t_domain <DOMAIN-dns.t_domain>`
   
    
 - ``p_port`` :ref:`commons.t_port <DOMAIN-commons.t_port>`
   
    
 - ``p_identifier`` :ref:`commons.t_key <DOMAIN-commons.t_key>`
   
    


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



.. _FUNCTION-web.ins_intermediate_cert:

``web.ins_intermediate_cert``
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Xxx

Parameters
 - ``p_subject_key_identifier`` :ref:`varchar <DOMAIN-varchar>`
   
    
 - ``p_authority_key_identifier`` :ref:`varchar <DOMAIN-varchar>`
   
    
 - ``p_x509_certificate`` :ref:`web.t_cert <DOMAIN-web.t_cert>`
   
    


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



.. _FUNCTION-web.ins_intermediate_chain:

``web.ins_intermediate_chain``
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

sdf

Parameters
 - ``p_domain`` :ref:`dns.t_domain <DOMAIN-dns.t_domain>`
   
    
 - ``p_port`` :ref:`commons.t_port <DOMAIN-commons.t_port>`
   
    
 - ``p_identifier`` :ref:`commons.t_key <DOMAIN-commons.t_key>`
   
    
 - ``p_order`` :ref:`integer <DOMAIN-integer>`
   
    
 - ``p_subject_key_identifier`` :ref:`varchar <DOMAIN-varchar>`
   
    


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



.. _FUNCTION-web.ins_site:

``web.ins_site``
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Insert site

.. todo:: check owner and contingent

Parameters
 - ``p_domain`` :ref:`dns.t_domain <DOMAIN-dns.t_domain>`
   
    
 - ``p_port`` :ref:`commons.t_port <DOMAIN-commons.t_port>`
   
    
 - ``p_user`` :ref:`server_access.t_user <DOMAIN-server_access.t_user>`
   
    
 - ``p_service_entity_name`` :ref:`dns.t_domain <DOMAIN-dns.t_domain>`
   
    


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



.. _FUNCTION-web.sel_alias:

``web.sel_alias``
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Select alias

Parameters
 *None*


Variables defined for body
 - ``v_owner`` :ref:`user.t_user <DOMAIN-user.t_user>`
   
   
 - ``v_login`` :ref:`user.t_user <DOMAIN-user.t_user>`
   
   

Returns
 TABLE

Returned columns
 - ``domain`` :ref:`dns.t_domain <DOMAIN-dns.t_domain>`
    
 - ``site`` :ref:`dns.t_domain <DOMAIN-dns.t_domain>`
    
 - ``site_port`` :ref:`commons.t_port <DOMAIN-commons.t_port>`
    
 - ``backend_status`` :ref:`backend.t_status <DOMAIN-backend.t_status>`
    

Execute privilege
 - :ref:`userlogin <ROLE-userlogin>`

.. code-block:: plpgsql

   -- begin userlogin prelude
   v_login := (SELECT t.owner FROM "user"._get_login() AS t);
   v_owner := (SELECT t.act_as FROM "user"._get_login() AS t);
   -- end userlogin prelude



.. _FUNCTION-web.sel_https:

``web.sel_https``
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

sel https

Parameters
 *None*


Variables defined for body
 - ``v_owner`` :ref:`user.t_user <DOMAIN-user.t_user>`
   
   
 - ``v_login`` :ref:`user.t_user <DOMAIN-user.t_user>`
   
   

Returns
 TABLE

Returned columns
 - ``identifier`` :ref:`commons.t_key <DOMAIN-commons.t_key>`
    
 - ``domain`` :ref:`dns.t_domain <DOMAIN-dns.t_domain>`
    
 - ``port`` :ref:`commons.t_port <DOMAIN-commons.t_port>`
    
 - ``x509_request`` :ref:`web.t_cert <DOMAIN-web.t_cert>`
    
 - ``x509_certificate`` :ref:`web.t_cert <DOMAIN-web.t_cert>`
    
 - ``authority_key_identifier`` :ref:`varchar <DOMAIN-varchar>`
    
 - ``backend_status`` :ref:`backend.t_status <DOMAIN-backend.t_status>`
    

Execute privilege
 - :ref:`userlogin <ROLE-userlogin>`

.. code-block:: plpgsql

   -- begin userlogin prelude
   v_login := (SELECT t.owner FROM "user"._get_login() AS t);
   v_owner := (SELECT t.act_as FROM "user"._get_login() AS t);
   -- end userlogin prelude



.. _FUNCTION-web.sel_intermediate_cert:

``web.sel_intermediate_cert``
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

int

Parameters
 - ``p_subject_key_identifier`` :ref:`varchar <DOMAIN-varchar>`
   
    


Variables defined for body
 - ``v_owner`` :ref:`user.t_user <DOMAIN-user.t_user>`
   
   
 - ``v_login`` :ref:`user.t_user <DOMAIN-user.t_user>`
   
   

Returns
 TABLE

Returned columns
 - ``subject_key_identifier`` :ref:`varchar <DOMAIN-varchar>`
    
 - ``authority_key_identifier`` :ref:`varchar <DOMAIN-varchar>`
    
 - ``x509_certificate`` :ref:`web.t_cert <DOMAIN-web.t_cert>`
    

Execute privilege
 - :ref:`userlogin <ROLE-userlogin>`

.. code-block:: plpgsql

   -- begin userlogin prelude
   v_login := (SELECT t.owner FROM "user"._get_login() AS t);
   v_owner := (SELECT t.act_as FROM "user"._get_login() AS t);
   -- end userlogin prelude



.. _FUNCTION-web.sel_intermediate_chain:

``web.sel_intermediate_chain``
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

sel

Parameters
 *None*


Variables defined for body
 - ``v_owner`` :ref:`user.t_user <DOMAIN-user.t_user>`
   
   
 - ``v_login`` :ref:`user.t_user <DOMAIN-user.t_user>`
   
   

Returns
 TABLE

Returned columns
 - ``domain`` :ref:`dns.t_domain <DOMAIN-dns.t_domain>`
    
 - ``port`` :ref:`commons.t_port <DOMAIN-commons.t_port>`
    
 - ``identifier`` :ref:`commons.t_key <DOMAIN-commons.t_key>`
    
 - ``subject_key_identifier`` :ref:`varchar <DOMAIN-varchar>`
    
 - ``x509_certificate`` :ref:`web.t_cert <DOMAIN-web.t_cert>`
    
 - ``order`` :ref:`integer <DOMAIN-integer>`
    

Execute privilege
 - :ref:`userlogin <ROLE-userlogin>`

.. code-block:: plpgsql

   -- begin userlogin prelude
   v_login := (SELECT t.owner FROM "user"._get_login() AS t);
   v_owner := (SELECT t.act_as FROM "user"._get_login() AS t);
   -- end userlogin prelude



.. _FUNCTION-web.sel_site:

``web.sel_site``
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Owner defined via server_access

Parameters
 *None*


Variables defined for body
 - ``v_owner`` :ref:`user.t_user <DOMAIN-user.t_user>`
   
   
 - ``v_login`` :ref:`user.t_user <DOMAIN-user.t_user>`
   
   

Returns
 TABLE

Returned columns
 - ``service`` :ref:`commons.t_key <DOMAIN-commons.t_key>`
    
 - ``subservice`` :ref:`commons.t_key <DOMAIN-commons.t_key>`
    
 - ``domain`` :ref:`dns.t_domain <DOMAIN-dns.t_domain>`
    
 - ``port`` :ref:`commons.t_port <DOMAIN-commons.t_port>`
    
 - ``user`` :ref:`server_access.t_user <DOMAIN-server_access.t_user>`
    
 - ``service_entity_name`` :ref:`dns.t_domain <DOMAIN-dns.t_domain>`
    
 - ``https`` :ref:`commons.t_key <DOMAIN-commons.t_key>`
    
 - ``backend_status`` :ref:`backend.t_status <DOMAIN-backend.t_status>`
    
 - ``option`` :ref:`jsonb <DOMAIN-jsonb>`
    

Execute privilege
 - :ref:`userlogin <ROLE-userlogin>`

.. code-block:: plpgsql

   -- begin userlogin prelude
   v_login := (SELECT t.owner FROM "user"._get_login() AS t);
   v_owner := (SELECT t.act_as FROM "user"._get_login() AS t);
   -- end userlogin prelude



.. _FUNCTION-web.srv_alias:

``web.srv_alias``
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

backend web.alias

Parameters
 - ``p_include_inactive`` :ref:`boolean <DOMAIN-boolean>`
   
    


Variables defined for body
 - ``v_machine`` :ref:`dns.t_domain <DOMAIN-dns.t_domain>`
   
   

Returns
 TABLE

Returned columns
 - ``domain`` :ref:`dns.t_domain <DOMAIN-dns.t_domain>`
    
 - ``site`` :ref:`dns.t_domain <DOMAIN-dns.t_domain>`
    
 - ``site_port`` :ref:`commons.t_port <DOMAIN-commons.t_port>`
    
 - ``backend_status`` :ref:`backend.t_status <DOMAIN-backend.t_status>`
    

Execute privilege
 - :ref:`backend <ROLE-backend>`

.. code-block:: plpgsql

   v_machine := (SELECT "machine" FROM "backend"._get_login());



.. _FUNCTION-web.srv_https:

``web.srv_https``
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Certs

Parameters
 - ``p_include_inactive`` :ref:`boolean <DOMAIN-boolean>`
   
    


Variables defined for body
 - ``v_machine`` :ref:`dns.t_domain <DOMAIN-dns.t_domain>`
   
   

Returns
 TABLE

Returned columns
 - ``identifier`` :ref:`commons.t_key <DOMAIN-commons.t_key>`
    
 - ``domain`` :ref:`dns.t_domain <DOMAIN-dns.t_domain>`
    
 - ``port`` :ref:`commons.t_port <DOMAIN-commons.t_port>`
    
 - ``x509_request`` :ref:`web.t_cert <DOMAIN-web.t_cert>`
    
 - ``x509_certificate`` :ref:`web.t_cert <DOMAIN-web.t_cert>`
    
 - ``x509_chain`` :ref:`varchar[] <DOMAIN-varchar[]>`
    
 - ``backend_status`` :ref:`backend.t_status <DOMAIN-backend.t_status>`
    

Execute privilege
 - :ref:`backend <ROLE-backend>`

.. code-block:: plpgsql

   v_machine := (SELECT "machine" FROM "backend"._get_login());



.. _FUNCTION-web.srv_site:

``web.srv_site``
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

backend web.site

Parameters
 - ``p_include_inactive`` :ref:`boolean <DOMAIN-boolean>`
   
    


Variables defined for body
 - ``v_machine`` :ref:`dns.t_domain <DOMAIN-dns.t_domain>`
   
   

Returns
 TABLE

Returned columns
 - ``domain`` :ref:`dns.t_domain <DOMAIN-dns.t_domain>`
    
 - ``port`` :ref:`commons.t_port <DOMAIN-commons.t_port>`
    
 - ``user`` :ref:`server_access.t_user <DOMAIN-server_access.t_user>`
    
 - ``service_entity_name`` :ref:`dns.t_domain <DOMAIN-dns.t_domain>`
    
 - ``https`` :ref:`commons.t_key <DOMAIN-commons.t_key>`
    
 - ``subservice`` :ref:`commons.t_key <DOMAIN-commons.t_key>`
    
 - ``option`` :ref:`jsonb <DOMAIN-jsonb>`
    
 - ``backend_status`` :ref:`backend.t_status <DOMAIN-backend.t_status>`
    

Execute privilege
 - :ref:`backend <ROLE-backend>`

.. code-block:: plpgsql

   v_machine := (SELECT "machine" FROM "backend"._get_login());



.. _FUNCTION-web.upd_https:

``web.upd_https``
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

upd https

Parameters
 - ``p_domain`` :ref:`dns.t_domain <DOMAIN-dns.t_domain>`
   
    
 - ``p_port`` :ref:`commons.t_port <DOMAIN-commons.t_port>`
   
    
 - ``p_identifier`` :ref:`commons.t_key <DOMAIN-commons.t_key>`
   
    
 - ``p_x509_certificate`` :ref:`web.t_cert <DOMAIN-web.t_cert>`
   
    
 - ``p_authority_key_identifier`` :ref:`varchar <DOMAIN-varchar>`
   
    


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



.. _FUNCTION-web.upd_site:

``web.upd_site``
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

set https identif.

Parameters
 - ``p_domain`` :ref:`dns.t_domain <DOMAIN-dns.t_domain>`
   
    
 - ``p_port`` :ref:`commons.t_port <DOMAIN-commons.t_port>`
   
    
 - ``p_identifier`` :ref:`commons.t_key <DOMAIN-commons.t_key>`
   
    


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





Domains
-------



.. _DOMAIN-web.t_cert:

``web.t_cert``
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

PEM cert

Checks
 - ``base64``
    no newlines in db

   .. code-block:: sql

    VALUE ~ '^[a-zA-Z\d/+]+[=]{0,2}$'







