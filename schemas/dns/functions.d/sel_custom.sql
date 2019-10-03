---
name: sel_custom
description: sel custom

templates:
 - user.userlogin

returns: TABLE
returns_columns:
 -
  name: id
  type: uuid
 -
  name: registered
  type: dns.t_hostname
 -
  name: domain
  type: dns.t_domain
 -
  name: type
  type: dns.t_type
 -
  name: rdata
  type: dns.t_rdata
 -
  name: ttl
  type: dns.t_ttl
 -
  name: backend_status
  type: backend.t_status
---

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
