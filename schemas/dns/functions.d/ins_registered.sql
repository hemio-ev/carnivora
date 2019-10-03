---
name: ins_registered
description: registeres new domain

templates:
 - user.userlogin

parameters:
 -
  name: p_domain
  type: dns.t_hostname
 -
  name: p_subservice
  type: commons.t_key
 -
  name: p_service_entity_name
  type: dns.t_hostname
 -
  name: p_public_suffix
  type: varchar

returns: void
---

INSERT INTO dns.registered
(domain, public_suffix, owner, service, subservice, service_entity_name)
VALUES
(p_domain, p_public_suffix, v_owner, 'domain_registered', p_subservice, p_service_entity_name);

PERFORM backend._notify_service_entity_name(p_service_entity_name, 'domain_registered', p_subservice);
