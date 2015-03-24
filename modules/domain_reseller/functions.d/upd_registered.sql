name: upd_registered
description: Update Registered

templates:
 - user.userlogin

returns: void

parameters:
 -
  name: p_domain
  type: dns.t_domain
 -
  name: p_admin_c
  type: varchar

body: |
    UPDATE domain_reseller.registered AS t
        SET
            admin_c = p_admin_c,
            backend_status = 'upd'
    FROM dns.registered AS s
    WHERE
        s.domain = t.domain AND
        s.owner = v_owner AND

        t.domain = p_domain;
