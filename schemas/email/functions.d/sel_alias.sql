---
name: sel_alias
description: Select aliases

templates:
 - user.userlogin

returns:
 table:
 -
  name: localpart
  type: email.t_localpart
 -
  name: domain
  type: dns.t_hostname
 -
  name: mailbox_localpart
  type: email.t_localpart
 -
  name: mailbox_domain
  type: dns.t_hostname
 -
  name: backend_status
  type: backend.t_status
---

RETURN QUERY
SELECT
    t.localpart,
    t.domain,
    t.mailbox_localpart,
    t.mailbox_domain,
    t.backend_status
FROM email.alias AS t
    
INNER JOIN email.mailbox AS s
    ON
        t.mailbox_localpart = s.localpart AND
        t.mailbox_domain = s.domain
WHERE s.owner = v_owner

ORDER BY t.backend_status, t.localpart, t.domain;
