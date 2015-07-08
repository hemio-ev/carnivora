name: _notify_service_entity_name
description: |
 Informs all machines about changes.

 WARNING: The parameter p_service_entity_name must be a servcie name. It must not be
 confused with a domain.

parameters:
 -
  name: p_service
  type: commons.t_key
 -
  name: p_service_entity_name
  type: dns.t_domain

returns: void

body: |
    PERFORM
        backend._notify(machine_name, p_service, p_service_entity_name)

    FROM system.service_entity_machine AS t
        WHERE
            t.service = p_service AND
            t.service_entity_name = p_service_entity_name
    ;
