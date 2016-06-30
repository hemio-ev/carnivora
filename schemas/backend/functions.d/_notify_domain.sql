---
name: _notify_domain
description: |
 Informs all machines about changes.

 WARNING: The parameter p_domain must be a domain, which means an entry in
 the column dns.service.domain. It must not be confused with a service_entity_name.

parameters:
 -
  name: p_service
  type: commons.t_key
 -
  name: p_subservice
  type: commons.t_key
 -
  name: p_domain
  type: dns.t_domain

returns: void
---

PERFORM
    backend._notify(machine_name, s.service_entity_name, p_service, p_subservice)

FROM system.service_entity_machine AS t
    JOIN dns.service AS s
    ON
        s.service = p_service AND
        s.domain = p_domain

    WHERE
        t.service = p_service AND
        t.service_entity_name = s.service_entity_name
;
