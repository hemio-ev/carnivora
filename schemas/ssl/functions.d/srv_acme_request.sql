---
name: srv_acme_request
description: |
 Open certificate requests

templates:
 - backend.backend

returns:
 table:
 -
  name: id
  type: uuid
 -
  name: request
  type: ssl.t_request
 -
  name: ca_name
  type: dns.t_hostname
---

RETURN QUERY
  SELECT c.id, c.request, d.ca_name
  FROM ssl.cert AS c
  JOIN ssl.demand AS d ON d.id = c.demand_id
  JOIN system.service_entity_machine AS m
   ON m.service = d.ca_type AND m.service_entity_name = d.ca_name
  WHERE
    c.cert IS NULL AND c.request IS NOT NULL
    AND d.ca_type = 'ssl' AND d.ca_system = 'acme'
    AND m.machine_name = v_machine
;

