---
name: sel_service
description: Select service based dns entries

templates:
 - user.userlogin

returns: TABLE
returns_columns:
 -
  name: registered
  type: dns.t_domain
 -
  name: domain
  type: dns.t_domain
 -
  name: service
  type: commons.t_key
 -
  name: service_entity_name
  type: dns.t_domain
 -
  name: backend_status
  type: backend.t_status
---

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
