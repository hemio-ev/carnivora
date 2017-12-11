---
templates:
 - user.userlogin

name: sel_redirection
description: Lists all redirections


returns:
 table:
 -
  name: domain
  type: dns.t_hostname
 -
  name: localpart
  type: email.t_localpart
 -
  name: destination
  type: email.t_address
 -
  name: backend_status
  type: backend.t_status
---

RETURN QUERY
 SELECT
  t.domain, 
  t.localpart, 
  t.destination,
  t.backend_status
 FROM
  email.redirection AS t
 WHERE
  t.owner = v_owner
 ORDER BY t.backend_status, t.localpart, t.domain;
