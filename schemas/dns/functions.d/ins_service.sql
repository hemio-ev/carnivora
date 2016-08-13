---
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

variables:
 -
  name: v_nameserver
  type: dns.t_domain
 -
  name: v_managed
  type: commons.t_key
---

SELECT service_entity_name, subservice INTO v_nameserver, v_managed FROM dns.registered
    WHERE
        domain = p_registered AND
        owner = v_owner;

IF v_nameserver IS NULL THEN
    PERFORM commons._raise_inaccessible_or_missing();
END IF;

INSERT INTO dns.service (registered, domain, service_entity_name, service)
    VALUES (p_registered, p_domain, p_service_entity_name, p_service);

PERFORM backend._notify_service_entity_name(v_nameserver, 'dns', v_managed);
