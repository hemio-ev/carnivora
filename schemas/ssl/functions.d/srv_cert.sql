---
name: srv_cert
description: |
 Certs

templates:
 - backend.backend

returns: TABLE
returns_columns:
 -
  name: id
  type: uuid
 -
  name: cert
  type: ssl.t_cert
 -
  name: service
  type: commons.t_key
 -
  name: service_entity_name
  type: dns.t_domain
---

RETURN QUERY
 SELECT c.id, c.cert, a.service, a.service_entity_name FROM ssl.cert AS c
 JOIN ssl.active AS a
 ON a.currently = c.id OR a.subsequently = c.id
 WHERE c.machine_name = v_machine;
