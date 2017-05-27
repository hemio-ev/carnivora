---
name: ins_mailbox
description: |
 Creates an email box

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
  type: dns.t_hostname
 -
  name: p_password
  type: commons.t_password_plaintext

variables:
 -
  name: v_subservice
  type: commons.t_key
  default: "'mailbox'"
---

PERFORM email._address_valid(p_localpart, p_domain);

INSERT INTO email.mailbox
    (service, subservice, localpart, domain, owner, password, service_entity_name) VALUES
    ('email', 'mailbox', p_localpart, p_domain, v_owner, commons._hash_password(p_password),
    (SELECT service_entity_name FROM dns.service WHERE service='email' AND domain = p_domain)
    );

PERFORM backend._notify_domain('email', 'mailbox', p_domain);
