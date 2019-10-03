---
name: del_alias
description: Delete Alias

returns: void

templates:
 - user.userlogin

parameters:
 -
  name: p_localpart
  type: email.t_localpart
 -
  name: p_domain
  type: dns.t_hostname
 -
  name: p_mailbox_localpart
  type: email.t_localpart
 -
  name: p_mailbox_domain
  type: dns.t_hostname
---

UPDATE email.alias AS t
    SET backend_status = 'del'
FROM email.mailbox AS s
WHERE
    -- JOIN
    t.mailbox_localpart = s.localpart AND
    t.mailbox_domain = s.domain AND

    t.localpart = p_localpart AND
    t.domain = p_domain AND
    s.localpart = p_mailbox_localpart AND
    s.domain = p_mailbox_domain AND

    s.owner = v_owner;

PERFORM backend._conditional_notify(FOUND, 'email', 'alias', p_domain);
