---
name: fwd_request
description: |
 Insert cert

 .. todo :: Sending signals to the service clients <service>-ssl

 .. todo :: Auth
 
 .. todo :: Fail if no update

templates:
 - backend.backend

returns: void

parameters:
 -
  name: p_id
  type: uuid
 -
  name: p_cert
  type: ssl.t_request
---

UPDATE ssl.cert AS c
 SET cert = p_cert
 FROM 
  ssl.demand AS d,
  system.service_entity_machine AS m 
 WHERE
  c.id = p_id
  AND cert IS NULL
  AND m.machine = v_machine
  -- JOIN ONs
  AND d.id = c.demand_id
  AND m.service = d.ca_type AND m.service_entity_name = d.ca_name
  ;

