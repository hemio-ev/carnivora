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

- ``backend_status`` *NULL* | *backend.t_status*
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

- ``backend_status`` *NULL* | *backend.t_status*
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

- ``x509_request`` *NULL* | *web.t_cert*
    Certificate request






.. _COLUMN-web.https.x509_certificate:

- ``x509_certificate`` *NULL* | *web.t_cert*
    Certificate






.. _COLUMN-web.https.authority_key_identifier:

- ``authority_key_identifier`` *NULL* | *varchar*
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

- ``backend_status`` *NULL* | *backend.t_status*
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

- ``https`` *NULL* | *commons.t_key*
    If null, HTTPS is deactivated









Functions
---------


``web.del_alias``
``````````````````````````````````````````````````````````````````````

del

.. code-block:: plpgsql

   -- begin userlogin prelude
   v_login := (SELECT t.owner FROM "user"._get_login() AS t);
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


``web.del_intermediate_chain``
``````````````````````````````````````````````````````````````````````

sdf

.. code-block:: plpgsql

   -- begin userlogin prelude
   v_login := (SELECT t.owner FROM "user"._get_login() AS t);
   v_owner := (SELECT t.act_as FROM "user"._get_login() AS t);
   -- end userlogin prelude
   
   DELETE FROM web.intermediate_chain
   WHERE
       domain = p_domain AND
       port = p_port AND
       identifier = p_identifier;


``web.del_site``
``````````````````````````````````````````````````````````````````````

del

.. code-block:: plpgsql

   -- begin userlogin prelude
   v_login := (SELECT t.owner FROM "user"._get_login() AS t);
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


``web.fwd_x509_request``
``````````````````````````````````````````````````````````````````````

x509 request

.. code-block:: plpgsql

   v_machine := (SELECT "machine" FROM "backend"._get_login());
   
   UPDATE web.https
       SET x509_request = p_x509_request
   WHERE
       domain = p_domain AND
       port = p_port AND
       identifier = p_identifier;


``web.ins_alias``
``````````````````````````````````````````````````````````````````````

Insert alias

.. code-block:: plpgsql

   -- begin userlogin prelude
   v_login := (SELECT t.owner FROM "user"._get_login() AS t);
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


``web.ins_https``
``````````````````````````````````````````````````````````````````````

Ins HTTPS

.. code-block:: plpgsql

   -- begin userlogin prelude
   v_login := (SELECT t.owner FROM "user"._get_login() AS t);
   v_owner := (SELECT t.act_as FROM "user"._get_login() AS t);
   -- end userlogin prelude
   
   INSERT INTO web.https
   (domain, port, identifier)
   VALUES
   (p_domain, p_port, p_identifier);


``web.ins_intermediate_cert``
``````````````````````````````````````````````````````````````````````

Xxx

.. code-block:: plpgsql

   -- begin userlogin prelude
   v_login := (SELECT t.owner FROM "user"._get_login() AS t);
   v_owner := (SELECT t.act_as FROM "user"._get_login() AS t);
   -- end userlogin prelude
   
   INSERT INTO web.intermediate_cert
       (subject_key_identifier, authority_key_identifier, x509_certificate)
       VALUES
       (p_subject_key_identifier, p_authority_key_identifier, p_x509_certificate);


``web.ins_intermediate_chain``
``````````````````````````````````````````````````````````````````````

sdf

.. code-block:: plpgsql

   -- begin userlogin prelude
   v_login := (SELECT t.owner FROM "user"._get_login() AS t);
   v_owner := (SELECT t.act_as FROM "user"._get_login() AS t);
   -- end userlogin prelude
   
   INSERT INTO web.intermediate_chain
   (domain, port, identifier, "order", subject_key_identifier)
   VALUES
   (p_domain, p_port, p_identifier, p_order, p_subject_key_identifier);


``web.ins_site``
``````````````````````````````````````````````````````````````````````

Insert site
TODO: check owner and contingent

.. code-block:: plpgsql

   -- begin userlogin prelude
   v_login := (SELECT t.owner FROM "user"._get_login() AS t);
   v_owner := (SELECT t.act_as FROM "user"._get_login() AS t);
   -- end userlogin prelude
   
   
   INSERT INTO web.site
   (domain, service, subservice, port, "user", service_entity_name)
   VALUES
   (p_domain, 'web', 'site', p_port, p_user, p_service_entity_name);
   
   PERFORM backend._notify_domain('web', 'site', p_domain);


``web.sel_alias``
``````````````````````````````````````````````````````````````````````

Select alias

.. code-block:: plpgsql

   -- begin userlogin prelude
   v_login := (SELECT t.owner FROM "user"._get_login() AS t);
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


``web.sel_https``
``````````````````````````````````````````````````````````````````````

sel https

.. code-block:: plpgsql

   -- begin userlogin prelude
   v_login := (SELECT t.owner FROM "user"._get_login() AS t);
   v_owner := (SELECT t.act_as FROM "user"._get_login() AS t);
   -- end userlogin prelude
   
   RETURN QUERY
       SELECT
           t.identifier,
           t.domain,
           t.port,
           t.x509_request,
           t.x509_certificate,
           t.authority_key_identifier,
           t.backend_status
       FROM web.https AS t
       ORDER BY t.backend_status, t.identifier;


``web.sel_intermediate_cert``
``````````````````````````````````````````````````````````````````````

int

.. code-block:: plpgsql

   -- begin userlogin prelude
   v_login := (SELECT t.owner FROM "user"._get_login() AS t);
   v_owner := (SELECT t.act_as FROM "user"._get_login() AS t);
   -- end userlogin prelude
   
   RETURN QUERY
       SELECT
           t.subject_key_identifier,
           t.authority_key_identifier,
           t.x509_certificate
       FROM web.intermediate_cert AS t
       WHERE
           t.subject_key_identifier = p_subject_key_identifier;


``web.sel_intermediate_chain``
``````````````````````````````````````````````````````````````````````

sel

.. code-block:: plpgsql

   -- begin userlogin prelude
   v_login := (SELECT t.owner FROM "user"._get_login() AS t);
   v_owner := (SELECT t.act_as FROM "user"._get_login() AS t);
   -- end userlogin prelude
   
   RETURN QUERY
       SELECT
           t.domain,
           t.port,
           t.identifier,
           t.subject_key_identifier,
           s.x509_certificate,
           t.order
       FROM web.intermediate_chain AS t
       JOIN web.intermediate_cert AS s
           USING (subject_key_identifier)
       ORDER BY t.order;


``web.sel_site``
``````````````````````````````````````````````````````````````````````

Owner defined via server_access

.. code-block:: plpgsql

   -- begin userlogin prelude
   v_login := (SELECT t.owner FROM "user"._get_login() AS t);
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


``web.srv_alias``
``````````````````````````````````````````````````````````````````````

backend web.alias

.. code-block:: plpgsql

   v_machine := (SELECT "machine" FROM "backend"._get_login());
   
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


``web.srv_https``
``````````````````````````````````````````````````````````````````````

Certs

.. code-block:: plpgsql

   v_machine := (SELECT "machine" FROM "backend"._get_login());
   
   
   RETURN QUERY
       WITH
   
       -- NO DELETE OPTION
   
       -- UPDATE
       s AS (
           UPDATE web.https AS t
               SET backend_status = NULL
           WHERE
               backend._machine_priviledged('web', t.domain) AND
               backend._active(t.backend_status)
       )
   
       -- SELECT
       SELECT
           t.identifier,
           t.domain,
           t.port,
           t.x509_request,
           t.x509_certificate,
           ARRAY(
               SELECT s.x509_certificate::varchar
               FROM web.intermediate_chain AS u
               JOIN web.intermediate_cert AS s
                   USING (subject_key_identifier)
               WHERE
                   u.domain = t.domain AND
                   u.port = t.port AND
                   u.identifier = t.identifier
               ORDER by "order"
           ),
           t.backend_status
       FROM web.https AS t
   
       WHERE
           backend._machine_priviledged('web', t.domain) AND
           (backend._active(t.backend_status) OR p_include_inactive);


``web.srv_site``
``````````````````````````````````````````````````````````````````````

backend web.site

.. code-block:: plpgsql

   v_machine := (SELECT "machine" FROM "backend"._get_login());
   
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
           (backend._active(t.backend_status) OR p_include_inactive);


``web.upd_https``
``````````````````````````````````````````````````````````````````````

upd https

.. code-block:: plpgsql

   -- begin userlogin prelude
   v_login := (SELECT t.owner FROM "user"._get_login() AS t);
   v_owner := (SELECT t.act_as FROM "user"._get_login() AS t);
   -- end userlogin prelude
   
   UPDATE web.https
       SET
           x509_certificate = p_x509_certificate,
           authority_key_identifier = p_authority_key_identifier
   WHERE
       domain = p_domain AND
       port = p_port AND
       identifier = p_identifier;
   
   PERFORM backend._conditional_notify(FOUND, 'web', 'site', p_domain);


``web.upd_site``
``````````````````````````````````````````````````````````````````````

set https identif.

.. code-block:: plpgsql

   -- begin userlogin prelude
   v_login := (SELECT t.owner FROM "user"._get_login() AS t);
   v_owner := (SELECT t.act_as FROM "user"._get_login() AS t);
   -- end userlogin prelude
   
   
   UPDATE web.site AS t
       SET https = p_identifier
   FROM server_access.user AS s, dns.service AS u
   WHERE
       s.user = t.user AND
       s.service_entity_name = u.service_entity_name AND
   
       -- dns.service JOIN
       t.domain = u.domain AND
       t.service = u.service AND
   
       s.owner = v_owner AND
       t.domain = p_domain AND
       t.port = p_port;
   
   PERFORM backend._conditional_notify(FOUND, 'web', 'site', p_domain);



