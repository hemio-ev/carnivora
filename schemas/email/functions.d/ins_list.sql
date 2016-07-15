---
name: ins_list
description: |
 Creates a mailing list

returns: void

templates:
 - user.userlogin
 - email.insert

parameters:
 -
  name: p_localpart
  type: email.t_localpart
 -
  name: p_domain
  type: dns.t_domain
 -
  name: p_admin
  type: email.t_address

variables:
 -
  name: v_subservice
  type: commons.t_key
  default: "'list'"
---

INSERT INTO email.list
    (service, subservice, localpart, domain, owner, admin, service_entity_name) VALUES
    ('email', 'list', p_localpart, p_domain, v_owner, p_admin,
    (SELECT service_entity_name FROM dns.service WHERE service='email' AND domain = p_domain));

PERFORM backend._notify_domain('email', 'list', p_domain);
