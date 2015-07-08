name: ins_service
description: Creates service dns entry

templates:
 - user.userlogin

parameters:
 -
  name: p_registered
  type: dns.t_domain
 -
  name: p_domain
  type: dns.t_domain
 -
  name: p_service_entity_name
  type: dns.t_domain
 -
  name: p_service
  type: commons.t_key

returns: void

body: |
    IF NOT EXISTS(
        SELECT TRUE FROM dns.registered
        WHERE
            domain = p_registered AND
            owner = v_owner
    ) THEN
        PERFORM commons._raise_inaccessible_or_missing();
    END IF;

    UPDATE dns.service
        SET service_entity_name = p_service_entity_name
    WHERE
        registered = p_registered AND
        domain = p_domain AND
        service = p_service;

    IF NOT FOUND THEN
        INSERT INTO dns.service (registered, domain, service_entity_name, service)
             VALUES (p_registered, p_domain, p_service_entity_name, p_service);
    END IF;

    PERFORM backend._notify_domain('dns', p_domain);

