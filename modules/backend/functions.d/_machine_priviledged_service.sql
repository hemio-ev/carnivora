name: _machine_priviledged_service
description: |
 Checks if a currently connected machine is priviledged to obtain data for
 a certain service for a certain servicee name.

 WARNING: The parameter p_server_name must be a service name. It must not be
 confused with a domain.

returns: boolean

templates:
 - backend.backend

parameters:
 -
  name: p_service
  type: system.t_service
 -
  name: p_service_entity_name
  type: dns.t_domain

body: |
    RETURN COALESCE(
        (
        SELECT TRUE FROM system.service_machine AS t
            WHERE
                t.service = p_service AND
                t.service_entity_name = p_service_entity_name AND
                t.machine_name = v_machine
        )
    , FALSE);

