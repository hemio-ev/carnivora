---
name: del_mailbox
description: Delete mailbox

templates:
 - user.userlogin

returns: void

parameters:
 -
  name: p_localpart
  type: email.t_localpart
 -
  name: p_domain
  type: dns.t_hostname
---

UPDATE email.mailbox
        SET backend_status = 'del'
    WHERE
        localpart = p_localpart AND
        domain = p_domain AND
        owner = v_owner;

PERFORM backend._conditional_notify(FOUND, 'email', 'mailbox', p_domain);

