======================================================================
dns
======================================================================

DNS

.. contents:: Module Contents
   :local:
   :depth: 2


Tables
----------------------------------------------------------------------


.. _TBL-dns.custom:

``dns.custom``
``````````````````````````````````````````````````````````````````````

Direct name server entries.

Primary key:

- id


.. BEGIN FKs


.. END FKs


Columns
''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''


.. _COLUMN-dns.custom.type:

- ``type`` *dns.t_type*
    Type (A, AAAA, CNAME, MX, SRV, TXT, ...)






.. _COLUMN-dns.custom.rdata:

- ``rdata`` *dns.t_rdata*
    fancy rdata storage






.. _COLUMN-dns.custom.ttl:

- ``ttl`` *NULL* | *dns.t_ttl*
    Time to live, NULL indicates default value






.. _COLUMN-dns.custom.backend_status:

- ``backend_status`` *NULL* | *backend.t_status*
    Status of database entry in backend. NULL: nothing pending,
    'ins': entry not present on backend client, 'upd': update
    pending on backend client, 'del': deletion peding on
    backend client.

  - Default: :python:`'ins'`





.. _COLUMN-dns.custom.registered:

- ``registered`` *dns.t_domain*
    Registered domain of which domain is a sub domain


  - References: :ref:`dns.registered.domain <COLUMN-dns.registered.domain>`




.. _COLUMN-dns.custom.domain:

- ``domain`` *dns.t_domain*
    domain of entry






.. _COLUMN-dns.custom.id:

- ``id`` *uuid*
    uuid serial number to identify database elements uniquely
    The default value is generated using uuid_generate_v4().

  - Default: :python:`uuid_generate_v4()`






.. _TBL-dns.registered:

``dns.registered``
``````````````````````````````````````````````````````````````````````

Domains registered under a public suffix.

Primary key:

- domain


.. BEGIN FKs

Foreign keys:

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
''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''


.. _COLUMN-dns.registered.owner:

- ``owner`` *user.t_user*
    for ownage


  - References: :ref:`user.user.owner <COLUMN-user.user.owner>`




.. _COLUMN-dns.registered.backend_status:

- ``backend_status`` *NULL* | *backend.t_status*
    Status of database entry in backend. NULL: nothing pending,
    'ins': entry not present on backend client, 'upd': update
    pending on backend client, 'del': deletion peding on
    backend client.

  - Default: :python:`'ins'`





.. _COLUMN-dns.registered.service_entity_name:

- ``service_entity_name`` *dns.t_domain*
    Service entity name






.. _COLUMN-dns.registered.service:

- ``service`` *commons.t_key*
    Service (e.g. email, jabber)






.. _COLUMN-dns.registered.subservice:

- ``subservice`` *commons.t_key*
    Subservice (e.g. account, alias)






.. _COLUMN-dns.registered.domain:

- ``domain`` *dns.t_domain*
    Domain






.. _COLUMN-dns.registered.public_suffix:

- ``public_suffix`` *varchar*
    Public Suffix







.. _TBL-dns.service:

``dns.service``
``````````````````````````````````````````````````````````````````````

Name server entries based on system.service (i.e. system.service_dns)

Primary key:

- domain
- service


.. BEGIN FKs

Foreign keys:

- Reference service entity

  Local Columns
   - service_entity_name
   - service

  Referenced Columns
   - :ref:`system.service_entity.service_entity_name <COLUMN-system.service_entity.service_entity_name>`
   - :ref:`system.service_entity.service <COLUMN-system.service_entity.service>`


.. END FKs


Columns
''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''


.. _COLUMN-dns.service.service_entity_name:

- ``service_entity_name`` *dns.t_domain*
    Service entity name






.. _COLUMN-dns.service.service:

- ``service`` *commons.t_key*
    Service (e.g. email, jabber)






.. _COLUMN-dns.service.backend_status:

- ``backend_status`` *NULL* | *backend.t_status*
    Status of database entry in backend. NULL: nothing pending,
    'ins': entry not present on backend client, 'upd': update
    pending on backend client, 'del': deletion peding on
    backend client.

  - Default: :python:`'ins'`





.. _COLUMN-dns.service.registered:

- ``registered`` *dns.t_domain*
    Registered domain of which domain is a sub domain


  - References: :ref:`dns.registered.domain <COLUMN-dns.registered.domain>`




.. _COLUMN-dns.service.domain:

- ``domain`` *dns.t_domain*
    domain for which the entries should be created









Functions
---------


``dns._domain_order``
``````````````````````````````````````````````````````````````````````

ORDER

.. code-block:: plpgsql

   RETURN commons._reverse_array(regexp_split_to_array(p_domain, E'\\.'));


``dns._rdata_txtdata_valid``
``````````````````````````````````````````````````````````````````````

Rdata txt-data valid

.. code-block:: plpgsql

   RETURN ((
      SELECT DISTINCT TRUE
          FROM UNNEST(p_txtdata) AS s
          WHERE octet_length(s) > 255
   ) IS NULL);


``dns.del_custom``
``````````````````````````````````````````````````````````````````````

Delete Custom

.. code-block:: plpgsql

   -- begin userlogin prelude
   v_login := (SELECT t.owner FROM "user"._get_login() AS t);
   v_owner := (SELECT t.act_as FROM "user"._get_login() AS t);
   -- end userlogin prelude
   
   
   UPDATE dns.custom AS t
          SET backend_status = 'del'
   FROM dns.registered AS s
   WHERE
       s.domain = t.registered AND
   
       t.id = p_id AND
       s.owner = v_owner
   
   RETURNING s.service_entity_name, s.subservice
   INTO v_nameserver, v_managed;
   
   PERFORM backend._conditional_notify_service_entity_name(
       FOUND, v_nameserver, 'dns', v_managed
   );


``dns.del_registered``
``````````````````````````````````````````````````````````````````````

Delete registered domain

.. code-block:: plpgsql

   -- begin userlogin prelude
   v_login := (SELECT t.owner FROM "user"._get_login() AS t);
   v_owner := (SELECT t.act_as FROM "user"._get_login() AS t);
   -- end userlogin prelude
   
   UPDATE dns.registered
   SET backend_status = 'del'
   WHERE domain = p_domain
    AND owner = v_owner
   RETURNING service_entity_name, subservice
      INTO v_nameserver, v_managed;
   
   PERFORM backend._conditional_notify_service_entity_name(
      FOUND, v_nameserver, 'domain_registered', v_managed
   );


``dns.del_service``
``````````````````````````````````````````````````````````````````````

deletes all service entries of a specific domain

.. code-block:: plpgsql

   -- begin userlogin prelude
   v_login := (SELECT t.owner FROM "user"._get_login() AS t);
   v_owner := (SELECT t.act_as FROM "user"._get_login() AS t);
   -- end userlogin prelude
   
   
   BEGIN
       -- perform DELETE to trigger potential foreign key errors
       DELETE FROM dns.service AS t
       USING dns.registered AS s
       WHERE
           s.domain = t.registered AND
   
           t.domain = p_domain AND
           t.service = p_service AND
           s.owner = v_owner;
   
       -- if not failed yet, emulate rollback of DELETE
       RAISE transaction_rollback;
   EXCEPTION
       WHEN transaction_rollback THEN
           UPDATE dns.service AS t
                  SET backend_status = 'del'
           FROM dns.registered AS s
           WHERE
               s.domain = t.registered AND
   
               t.domain = p_domain AND
               t.service = p_service AND
               s.owner = v_owner
           RETURNING s.service_entity_name, s.subservice
           INTO v_nameserver, v_managed;
   
           PERFORM backend._conditional_notify_service_entity_name(
               FOUND, v_nameserver, 'dns', v_managed
           );
   
   END;


``dns.fwd_registered_status``
``````````````````````````````````````````````````````````````````````

Update status

.. code-block:: plpgsql

   v_machine := (SELECT "machine" FROM "backend"._get_login());
   
   
   UPDATE dns.registered
   SET
       backend_status = p_backend_status
   WHERE domain = p_domain;


``dns.ins_custom``
``````````````````````````````````````````````````````````````````````

Ins Custom

.. code-block:: plpgsql

   -- begin userlogin prelude
   v_login := (SELECT t.owner FROM "user"._get_login() AS t);
   v_owner := (SELECT t.act_as FROM "user"._get_login() AS t);
   -- end userlogin prelude
   
   SELECT service_entity_name, subservice INTO v_nameserver, v_managed FROM dns.registered
   WHERE
       domain = p_registered AND
       owner = v_owner;
   
   IF v_nameserver IS NULL THEN
       PERFORM commons._raise_inaccessible_or_missing();
   END IF;
   
   IF v_nameserver IS NULL THEN
       PERFORM commons._raise_inaccessible_or_missing();
   END IF;
   
   INSERT INTO dns.custom
   (registered, domain, type, rdata, ttl)
   VALUES
   (p_registered, p_domain, p_type, p_rdata, p_ttl);
   
   PERFORM backend._notify_service_entity_name(v_nameserver, 'dns', v_managed);


``dns.ins_registered``
``````````````````````````````````````````````````````````````````````

registeres new domain

.. code-block:: plpgsql

   -- begin userlogin prelude
   v_login := (SELECT t.owner FROM "user"._get_login() AS t);
   v_owner := (SELECT t.act_as FROM "user"._get_login() AS t);
   -- end userlogin prelude
   
   INSERT INTO dns.registered
   (domain, public_suffix, owner, service, subservice, service_entity_name)
   VALUES
   (p_domain, p_public_suffix, v_owner, 'domain_registered', p_subservice, p_service_entity_name);
   
   PERFORM backend._notify_service_entity_name(p_service_entity_name, 'domain_registered', p_subservice);


``dns.ins_service``
``````````````````````````````````````````````````````````````````````

Creates service dns entry

.. code-block:: plpgsql

   -- begin userlogin prelude
   v_login := (SELECT t.owner FROM "user"._get_login() AS t);
   v_owner := (SELECT t.act_as FROM "user"._get_login() AS t);
   -- end userlogin prelude
   
   
   SELECT service_entity_name, subservice INTO v_nameserver, v_managed FROM dns.registered
       WHERE
           domain = p_registered AND
           owner = v_owner;
   
   IF v_nameserver IS NULL THEN
       PERFORM commons._raise_inaccessible_or_missing();
   END IF;
   
   UPDATE dns.service
       SET service_entity_name = p_service_entity_name
   WHERE
       registered = p_registered AND
       domain = p_domain AND
       service = p_service;
   
   IF NOT FOUND THEN
       INSERT INTO dns.service (registered, domain, service_entity_name, service)
            VALUES (p_registered, p_domain, p_service_entity_name, p_service);
   END IF;
   
   PERFORM backend._notify_service_entity_name(v_nameserver, 'dns', v_managed);


``dns.sel_activatable_service``
``````````````````````````````````````````````````````````````````````

Activatable services

.. code-block:: plpgsql

   -- begin userlogin prelude
   v_login := (SELECT t.owner FROM "user"._get_login() AS t);
   v_owner := (SELECT t.act_as FROM "user"._get_login() AS t);
   -- end userlogin prelude
   
   RETURN QUERY
   SELECT
       COALESCE(t.service, s.service) AS service,
       COALESCE(t.service_entity_name, s.service_entity_name) AS service_entity_name
   FROM system._effective_contingent() AS t
   FULL OUTER JOIN system._effective_contingent_domain() AS s
   USING (service, subservice, service_entity_name, owner)
   WHERE
       COALESCE(t.subservice, s.subservice) = 'dns_activatable' AND
       COALESCE(t.owner, s.owner) = v_owner
   ;


``dns.sel_available_service``
``````````````````````````````````````````````````````````````````````

List all domains that have a service entry in dns with their service.
This is particularly usefull since these domains are ready for use with
this service. Usually this means that accounts etc. can be created for this
domain.

.. code-block:: plpgsql

   -- begin userlogin prelude
   v_login := (SELECT t.owner FROM "user"._get_login() AS t);
   v_owner := (SELECT t.act_as FROM "user"._get_login() AS t);
   -- end userlogin prelude
   
   RETURN QUERY
       SELECT t.domain, t.service FROM dns.service AS t
       JOIN dns.registered AS s
           ON s.domain = t.registered
       WHERE
           (
               s.owner = v_owner AND
   
                   system._contingent_total(
                       p_owner := s.owner,
                       p_service := t.service,
                       p_service_entity_name := t.service_entity_name
               ) IS NOT NULL
           ) OR
           system._contingent_domain(
                       p_owner := s.owner,
                       p_service := t.service,
                       p_service_entity_name := t.service_entity_name,
                       p_domain := t.domain
               ) IS NOT NULL
       ORDER BY t.service
   ;


``dns.sel_custom``
``````````````````````````````````````````````````````````````````````

sel custom

.. code-block:: plpgsql

   -- begin userlogin prelude
   v_login := (SELECT t.owner FROM "user"._get_login() AS t);
   v_owner := (SELECT t.act_as FROM "user"._get_login() AS t);
   -- end userlogin prelude
   
   RETURN QUERY
       SELECT
           t.id,
           t.registered,
           t.domain,
           t.type,
           t.rdata,
           t.ttl,
           t.backend_status
       FROM dns.custom AS t
       JOIN dns.registered AS s
           ON s.domain = t.registered
       WHERE
           s.owner = v_owner
       ORDER BY backend_status, registered, dns._domain_order(t.domain);


``dns.sel_nameserver``
``````````````````````````````````````````````````````````````````````

Select available nameservers

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
       COALESCE(t.service, s.service) = 'domain_registered' AND
       COALESCE(t.owner, s.owner) = v_owner
   ;


``dns.sel_registered``
``````````````````````````````````````````````````````````````````````

List registered domains

.. code-block:: plpgsql

   -- begin userlogin prelude
   v_login := (SELECT t.owner FROM "user"._get_login() AS t);
   v_owner := (SELECT t.act_as FROM "user"._get_login() AS t);
   -- end userlogin prelude
   
   RETURN QUERY
       SELECT t.domain, t.public_suffix, t.backend_status, t.subservice, t.service_entity_name
       FROM dns.registered AS t
       WHERE
           t.owner = v_owner
       ORDER BY backend_status, domain;


``dns.sel_service``
``````````````````````````````````````````````````````````````````````

Select service based dns entries

.. code-block:: plpgsql

   -- begin userlogin prelude
   v_login := (SELECT t.owner FROM "user"._get_login() AS t);
   v_owner := (SELECT t.act_as FROM "user"._get_login() AS t);
   -- end userlogin prelude
   
   RETURN QUERY
       SELECT
           t.registered,
           t.domain,
           t.service,
           t.service_entity_name,
           t.backend_status
       FROM dns.service AS t
       JOIN dns.registered AS s
           ON s.domain = t.registered
       WHERE
           s.owner = v_owner
       ORDER BY backend_status, registered, dns._domain_order(t.domain), service, service_entity_name;


``dns.sel_usable_domain``
``````````````````````````````````````````````````````````````````````

Usable domains

.. code-block:: plpgsql

   -- begin userlogin prelude
   v_login := (SELECT t.owner FROM "user"._get_login() AS t);
   v_owner := (SELECT t.act_as FROM "user"._get_login() AS t);
   -- end userlogin prelude
   
   RETURN QUERY
   SELECT t.domain, t.service_entity_name FROM dns.service AS t
       JOIN dns.registered AS d
           ON d.domain = t.registered
       LEFT JOIN system._effective_contingent_domain() AS contingent_d
           ON
               contingent_d.domain = t.domain AND
               contingent_d.service = t.service AND
               contingent_d.subservice = p_subservice AND
               contingent_d.service_entity_name = t.service_entity_name AND
               contingent_d.owner = v_owner
   
       LEFT JOIN system._effective_contingent() AS contingent
           ON
               contingent.service = t.service AND
               contingent.subservice = p_subservice AND
               contingent.owner = v_owner AND
               d.owner = v_owner
   
       WHERE
           t.service = p_service AND
           COALESCE(contingent_d.domain_contingent, contingent.domain_contingent, 0) > 0
       ORDER BY
           t.domain
   ;


``dns.srv_record``
``````````````````````````````````````````````````````````````````````

Servers both record types combined: Raw entries and the ones assembled
from records templates for services (system.service_entity_dns).

.. code-block:: plpgsql

   v_machine := (SELECT "machine" FROM "backend"._get_login());
   
   
   RETURN QUERY
       WITH
   
       -- DELETE
       d_s AS (
           DELETE FROM dns.service AS t
           USING dns.registered AS s
           WHERE
               s.domain = t.registered AND
               backend._deleted(t.backend_status) AND
               backend._machine_priviledged_service('dns', s.service_entity_name)
       ),
   
       d_c AS (
           DELETE FROM dns.custom AS t
           USING dns.registered AS s
           WHERE
               s.domain = t.registered AND
               backend._deleted(t.backend_status) AND
               backend._machine_priviledged_service('dns', s.service_entity_name)
       ),
   
       -- UPDATE
       u_s AS (
           UPDATE dns.service AS t
               SET backend_status = NULL
           FROM dns.registered AS s
           WHERE
               s.domain = t.registered AND
               backend._machine_priviledged_service('dns', s.service_entity_name) AND
               backend._active(t.backend_status)
       ),
   
       u_c AS (
           UPDATE dns.custom AS t
               SET backend_status = NULL
           FROM dns.registered AS s
           WHERE
               s.domain = t.registered AND
               backend._machine_priviledged_service('dns', s.service_entity_name) AND
               backend._active(t.backend_status)
       )
   
       SELECT
           t.registered,
           COALESCE(s.domain_prefix || t.domain, t.domain)::dns.t_domain,
           s.type,
           s.rdata,
           s.ttl,
           t.backend_status
       FROM dns.service AS t
       JOIN system.service_entity_dns AS s
           USING (service, service_entity_name)
       JOIN dns.registered AS u
           ON t.registered = u.domain
       WHERE
           u.subservice = 'managed' AND
           backend._machine_priviledged_service('dns', u.service_entity_name) AND
           (backend._active(t.backend_status) OR p_include_inactive)
   
       UNION ALL
   
       SELECT
           t.registered,
           t.domain,
           t.type,
           t.rdata,
           t.ttl,
           t.backend_status
       FROM dns.custom AS t
       JOIN dns.registered AS u
           ON t.registered = u.domain
       WHERE
           u.subservice = 'managed' AND
           backend._machine_priviledged_service('dns', u.service_entity_name) AND
           (backend._active(t.backend_status) OR p_include_inactive)
       ;


``dns.upd_custom``
``````````````````````````````````````````````````````````````````````

Ins Custom

.. code-block:: plpgsql

   -- begin userlogin prelude
   v_login := (SELECT t.owner FROM "user"._get_login() AS t);
   v_owner := (SELECT t.act_as FROM "user"._get_login() AS t);
   -- end userlogin prelude
   
   
   UPDATE dns.custom AS t
       SET rdata = p_rdata, ttl = p_ttl
   FROM dns.registered AS s
   
   WHERE
       s.domain = t.registered AND
   
       t.id = p_id AND
       s.owner = v_owner
   RETURNING s.service_entity_name, s.subservice INTO v_nameserver, v_managed;
   
   PERFORM backend._notify_service_entity_name(v_nameserver, 'dns', v_managed);



