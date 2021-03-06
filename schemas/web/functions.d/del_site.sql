---
name: del_site
description: del

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
---

UPDATE web.site AS t
    SET backend_status = 'del'
FROM server_access.user AS s
WHERE
    -- JOIN server_access.user
    s.user = t.user AND
    s.service_entity_name = t.service_entity_name AND

    t.domain = p_domain AND
    t.port = p_port AND
    s.owner = v_owner;

PERFORM backend._conditional_notify(FOUND, 'web', 'site', p_domain);
