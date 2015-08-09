name: del_registered
description: |
 Delete registered domain

templates:
 - user.userlogin

returns: void

parameters:
 -
  name: p_domain
  type: dns.t_domain

variables:
 -
  name: v_nameserver
  type: dns.t_domain
 -
  name: v_managed
  type: commons.t_key

body: |
 UPDATE dns.registered
 SET backend_status = 'del'
 WHERE domain = p_domain
  AND owner = v_owner
 RETURNING service_entity_name, subservice
    INTO v_nameserver, v_managed;

 PERFORM backend._conditional_notify_service_entity_name(
    FOUND, v_nameserver, 'domain_registered', v_managed
 );