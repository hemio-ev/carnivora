---
name: upd_account
description: Change jabber account password

templates:
 - user.userlogin

returns: void

parameters:
 -
  name: p_node
  type: email.t_localpart
 -
  name: p_domain
  type: dns.t_domain
 -
  name: p_password
  type: commons.t_password_plaintext
---

UPDATE jabber.account
    SET
        password = commons._hash_password(p_password)
WHERE
    node = p_node AND
    domain = p_domain AND
    owner = v_owner;

PERFORM backend._conditional_notify(FOUND, 'jabber', 'account', p_domain);
