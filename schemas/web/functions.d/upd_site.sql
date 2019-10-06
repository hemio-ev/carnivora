---
name: upd_site
description: set https identif.

templates:
 - user.userlogin

returns: void

parameters:
 -
  name: p_domain
  type: dns.t_hostname
 -
  name: p_port
  type: commons.t_port
 -
  name: p_identifier
  type: commons.t_key
---

UPDATE web.site AS s
    SET https = p_identifier
WHERE
    s.owner = v_owner AND
    s.domain = p_domain AND
    s.port = p_port;

PERFORM backend._conditional_notify(FOUND, 'web', 'site', p_domain);
