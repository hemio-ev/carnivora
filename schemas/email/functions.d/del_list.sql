---
name: del_list
description: Delete mailing list

templates:
 - user.userlogin

returns: void

parameters:
 -
  name: p_domain
  type: dns.t_hostname
 -
  name: p_localpart
  type: email.t_localpart
---

DELETE FROM email.list
WHERE
    domain = p_domain AND
    localpart = p_localpart AND
    owner = v_owner;

PERFORM backend._conditional_notify(FOUND, 'email', 'list', p_domain);

