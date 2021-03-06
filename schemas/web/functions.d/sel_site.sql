---
name: sel_site
description: |
 Owner defined via server_access

templates:
 - user.userlogin

returns: TABLE
returns_columns:
 -
  name: service
  type: commons.t_key
 -
  name: subservice
  type: commons.t_key
 -
  name: domain
  type: dns.t_hostname
 -
  name: port
  type: commons.t_port
 -
  name: user
  type: server_access.t_user
 -
  name: service_entity_name
  type: dns.t_hostname
 -
  name: https
  type: bool
 -
  name: backend_status
  type: backend.t_status
 -
  name: option
  type: jsonb
---

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
