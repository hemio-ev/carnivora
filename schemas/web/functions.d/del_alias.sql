---
name: del_alias
description: del

templates:
 - user.userlogin

returns: void

parameters:
 -
  name: p_domain
  type: dns.t_domain
 -
  name: p_site_port
  type: commons.t_port
---

UPDATE web.alias AS t
    SET backend_status = 'del'
FROM web.site AS s, server_access.user AS u
WHERE
    -- JOIN web.site
    s.domain = t.site AND

    -- JOIN server_access.user
    u.service_entity_name = t.service_entity_name AND
    u.user = s.user AND

    u.owner = v_owner AND
    t.domain = p_domain AND
    t.site_port = p_site_port;

PERFORM backend._conditional_notify(FOUND, 'web', 'alias', p_domain);
