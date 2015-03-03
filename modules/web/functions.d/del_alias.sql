name: del_alias
description: del

templates:
 - user.userlogin

returns: void

parameters:
 -
  name: p_domain
  type: dns.t_domain

body: |

    DELETE FROM web.alias AS t
    USING web.site AS s, server_access.user AS u
    WHERE
        -- JOIN web.site
        s.domain = t.site AND

        -- JOIN server_access.user
        u.service_name = t.service_name AND
        u.user = s.user AND

        u.owner = v_owner AND
        t.domain = p_domain;
