name: _machine_priviledged
description: |
 Checks if a currently connected machine is priviledged to obtain data for
 a certain service for a certain domain name.

 WARNING: The parameter p_domain must be a domain, which means an entry in
 the column dns.service.domain. It must not be confused with a service_entity_name.

returns: boolean

templates:
 - backend.backend

parameters:
 -
  name: p_service
  type: system.t_service
 -
  name: p_domain
  type: dns.t_domain

body: |
    RETURN COALESCE(
        (
        SELECT TRUE FROM system.service_machine AS t
            JOIN dns.service AS s
            ON
                s.service = p_service AND
                s.domain = p_domain

            WHERE
                t.service = p_service AND
                t.service_entity_name = s.service_entity_name AND
                t.machine_name = v_machine
        )
    , FALSE);
