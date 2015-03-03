name: del_site
description: del

templates:
 - user.userlogin

returns: void

parameters:
 -
  name: p_domain
  type: dns.t_domain

body: |
    UPDATE web.site AS t
        SET backend_status = 'del'
    FROM server_access.user AS s
    WHERE
        -- JOIN server_access.user
        s.user = t.user AND
        s.service_name = t.service_name AND

        t.domain = p_domain AND
        s.owner = v_owner;

    PERFORM backend._conditional_notify(FOUND, 'web', p_domain);
