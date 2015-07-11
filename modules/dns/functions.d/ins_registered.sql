name: ins_registered
description: registeres new domain

templates:
 - user.userlogin

parameters:
 -
  name: p_domain
  type: dns.t_domain
 -
  name: p_subservice
  type: commons.t_key
 -
  name: p_service_entity_name
  type: dns.t_domain
 -
  name: p_public_suffix
  type: varchar

returns: void

body: |
    INSERT INTO dns.registered
    (domain, public_suffix, owner, service, subservice, service_entity_name)
    VALUES
    (p_domain, p_public_suffix, v_owner, 'domain_registered', p_subservice, p_service_entity_name);
