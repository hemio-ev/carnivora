---
name: fwd_request
description: |
 X.509 certifiacte signing request

 .. todo :: Sending signals to the carnivora-acme clients
 
 .. todo :: Error on not updating anything

templates:
 - backend.backend

returns: void

parameters:
 -
  name: p_id
  type: uuid
 -
  name: p_request
  type: ssl.t_request
---

UPDATE ssl.cert SET request = p_request
 WHERE machine_name = v_machine AND id = p_id AND request IS NULL;

