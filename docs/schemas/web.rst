======================================================================
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
----------------------------------------------------------------------


.. _TBL-web.alias:

``web.alias``
``````````````````````````````````````````````````````````````````````

Aliases

Primary key:

- domain
- site_port


.. BEGIN FKs

Foreign keys:

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
''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''


.. _COLUMN-web.alias.domain:

- ``domain`` *dns.t_domain*
    Domain name






.. _COLUMN-web.alias.service:

- ``service`` *commons.t_key*
    Service






.. _COLUMN-web.alias.service_entity_name:

- ``service_entity_name`` *dns.t_domain*
    ent. name






.. _COLUMN-web.alias.subservice:

- ``subservice`` *commons.t_key*
    Subservice (e.g. account, alias)






.. _COLUMN-web.alias.backend_status:

- ``backend_status`` *NULL | backend.t_status*
    Status of database entry in backend. NULL: nothing pending,
    'ins': entry not present on backend client, 'upd': update
    pending on backend client, 'del': deletion peding on
    backend client.

  - Default: :python:`'ins'`





.. _COLUMN-web.alias.site:

- ``site`` *dns.t_domain*
    Site






.. _COLUMN-web.alias.site_port:

- ``site_port`` *commons.t_port*
    port

  - Default: :python:`80`






.. _TBL-web.https:

``web.https``
``````````````````````````````````````````````````````````````````````

stores https information

Primary key:

- identifier
- domain
- port


.. BEGIN FKs

Foreign keys:

- site

  Local Columns
   - domain
   - port

  Referenced Columns
   - :ref:`web.site.domain <COLUMN-web.site.domain>`
   - :ref:`web.site.port <COLUMN-web.site.port>`


.. END FKs


Columns
''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''


.. _COLUMN-web.https.backend_status:

- ``backend_status`` *NULL | backend.t_status*
    Status of database entry in backend. NULL: nothing pending,
    'ins': entry not present on backend client, 'upd': update
    pending on backend client, 'del': deletion peding on
    backend client.

  - Default: :python:`'ins'`





.. _COLUMN-web.https.identifier:

- ``identifier`` *commons.t_key*
    PK






.. _COLUMN-web.https.domain:

- ``domain`` *dns.t_domain*
    Domain






.. _COLUMN-web.https.port:

- ``port`` *commons.t_port*
    Port






.. _COLUMN-web.https.x509_request:

- ``x509_request`` *NULL | web.t_cert*
    Certificate request






.. _COLUMN-web.https.x509_certificate:

- ``x509_certificate`` *NULL | web.t_cert*
    Certificate






.. _COLUMN-web.https.authority_key_identifier:

- ``authority_key_identifier`` *NULL | varchar*
    Identifier of the certificate that has signed this cert.
    The Authority Key Identifier allows to build the chain of trust.
    See <http://www.ietf.org/rfc/rfc3280.txt>.
    Hopefully there exists an entry in web.intermediate_cert
    or a root certificate with an equal subjectKeyIdentifier.
    
    Is NULL whenever x509_certificate is NULL.







.. _TBL-web.intermediate_cert:

``web.intermediate_cert``
``````````````````````````````````````````````````````````````````````

Intermediate certificates

Primary key:

- subject_key_identifier


.. BEGIN FKs


.. END FKs


Columns
''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''


.. _COLUMN-web.intermediate_cert.subject_key_identifier:

- ``subject_key_identifier`` *varchar*
    Identifies this certificate






.. _COLUMN-web.intermediate_cert.authority_key_identifier:

- ``authority_key_identifier`` *varchar*
    Subject key identifier of the cert that has signed this cert.
    NULL is not allowed, since self signed cert do not belong into intermediate
    certs.






.. _COLUMN-web.intermediate_cert.x509_certificate:

- ``x509_certificate`` *web.t_cert*
    Intermediate certificate







.. _TBL-web.intermediate_chain:

``web.intermediate_chain``
``````````````````````````````````````````````````````````````````````

xxx

Primary key:

- domain
- port
- identifier
- subject_key_identifier


.. BEGIN FKs

Foreign keys:

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
''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''


.. _COLUMN-web.intermediate_chain.domain:

- ``domain`` *dns.t_domain*
    Domain






.. _COLUMN-web.intermediate_chain.port:

- ``port`` *commons.t_port*
    Port






.. _COLUMN-web.intermediate_chain.identifier:

- ``identifier`` *commons.t_key*
    Identifier






.. _COLUMN-web.intermediate_chain.order:

- ``order`` *integer*
    Ordering from leaf to root






.. _COLUMN-web.intermediate_chain.subject_key_identifier:

- ``subject_key_identifier`` *varchar*
    SubjectKeyIdentifier


  - References: :ref:`web.intermediate_cert.subject_key_identifier <COLUMN-web.intermediate_cert.subject_key_identifier>`





.. _TBL-web.site:

``web.site``
``````````````````````````````````````````````````````````````````````

Website

Primary key:

- domain
- port


.. BEGIN FKs

Foreign keys:

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
''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''


.. _COLUMN-web.site.domain:

- ``domain`` *dns.t_domain*
    Domain name






.. _COLUMN-web.site.service:

- ``service`` *commons.t_key*
    Service






.. _COLUMN-web.site.service_entity_name:

- ``service_entity_name`` *dns.t_domain*
    ent. name






.. _COLUMN-web.site.subservice:

- ``subservice`` *commons.t_key*
    Subservice (e.g. account, alias)






.. _COLUMN-web.site.backend_status:

- ``backend_status`` *NULL | backend.t_status*
    Status of database entry in backend. NULL: nothing pending,
    'ins': entry not present on backend client, 'upd': update
    pending on backend client, 'del': deletion peding on
    backend client.

  - Default: :python:`'ins'`





.. _COLUMN-web.site.option:

- ``option`` *jsonb*
    Free options in JSON format

  - Default: :python:`'{}'`





.. _COLUMN-web.site.port:

- ``port`` *commons.t_port*
    Port






.. _COLUMN-web.site.user:

- ``user`` *server_access.t_user*
    Server account under which the htdocs reside






.. _COLUMN-web.site.https:

- ``https`` *NULL | commons.t_key*
    If null, HTTPS is deactivated









Functions
---------


``web.del_alias``
``````````````````````````````````````````````````````````````````````

del


``web.del_intermediate_chain``
``````````````````````````````````````````````````````````````````````

sdf


``web.del_site``
``````````````````````````````````````````````````````````````````````

del


``web.fwd_x509_request``
``````````````````````````````````````````````````````````````````````

x509 request


``web.ins_alias``
``````````````````````````````````````````````````````````````````````

Insert alias


``web.ins_https``
``````````````````````````````````````````````````````````````````````

Ins HTTPS


``web.ins_intermediate_cert``
``````````````````````````````````````````````````````````````````````

Xxx


``web.ins_intermediate_chain``
``````````````````````````````````````````````````````````````````````

sdf


``web.ins_site``
``````````````````````````````````````````````````````````````````````

Insert site
TODO: check owner and contingent


``web.sel_alias``
``````````````````````````````````````````````````````````````````````

Select alias


``web.sel_https``
``````````````````````````````````````````````````````````````````````

sel https


``web.sel_intermediate_cert``
``````````````````````````````````````````````````````````````````````

int


``web.sel_intermediate_chain``
``````````````````````````````````````````````````````````````````````

sel


``web.sel_site``
``````````````````````````````````````````````````````````````````````

Owner defined via server_access


``web.srv_alias``
``````````````````````````````````````````````````````````````````````

backend web.alias


``web.srv_https``
``````````````````````````````````````````````````````````````````````

Certs


``web.srv_site``
``````````````````````````````````````````````````````````````````````

backend web.site


``web.upd_https``
``````````````````````````````````````````````````````````````````````

upd https


``web.upd_site``
``````````````````````````````````````````````````````````````````````

set https identif.



