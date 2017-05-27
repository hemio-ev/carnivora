---
name: ins_account
description: Insert jabber account

templates:
 - user.userlogin

returns: void

parameters:
 -
  name: p_node
  type: email.t_localpart
 -
  name: p_domain
  type: dns.t_hostname
 -
  name: p_password
  type: commons.t_password_plaintext

variables:
 -
  name: v_num_total
  type: integer
 -
  name: v_num_domain
  type: integer
---

v_num_total := (SELECT COUNT(*) FROM jabber.account AS t WHERE t.owner=v_owner);
v_num_domain := (SELECT COUNT(*) FROM jabber.account AS t WHERE t.owner=v_owner AND t.domain = p_domain);

PERFORM system._contingent_ensure(
    p_owner:=v_owner,
    p_domain:=p_domain,
    p_service:='jabber',
    p_subservice:='account',
    p_current_quantity_total:=v_num_total,
    p_current_quantity_domain:=v_num_domain);

INSERT INTO jabber.account
    (service, subservice, node, domain, owner, password, service_entity_name) VALUES
    ('jabber', 'account', p_node, p_domain, v_owner, commons._hash_password(p_password),
    (SELECT service_entity_name FROM dns.service WHERE service='jabber' AND domain = p_domain));

PERFORM backend._notify_domain('jabber', 'account', p_domain);
