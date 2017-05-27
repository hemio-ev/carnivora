---
name: _machine_priviledged_entity
description: |
 Checks if a currently connected machine is priviledged to obtain data for
 a certain service for a certain servicee name.

 .. warning:: 
  The parameter ``p_service_entity_name`` must be the name of a service entity. 
  It must not be confused with a domain.

returns: boolean

templates:
 - backend.backend_login

parameters:
 -
  name: p_service
  type: commons.t_key
 -
  name: p_service_entity_name
  type: dns.t_hostname
---

RETURN COALESCE(
    (
    SELECT TRUE FROM system.service_entity_machine AS t
        WHERE
            t.service = p_service AND
            t.service_entity_name = p_service_entity_name AND
            t.machine_name = v_machine
    )
, FALSE);

