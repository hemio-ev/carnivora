name: sel_alias
description: Select alias

templates:
 - user.userlogin

returns: TABLE
returns_columns:
 -
  name: domain
  type: dns.t_domain
 -
  name: site
  type: dns.t_domain
 -
  name: site_port
  type: commons.t_port
 -
  name: backend_status
  type: backend.t_status

body: |
    RETURN QUERY
        SELECT
            t.domain,
            t.site,
            t.site_port,
            t.backend_status
        FROM web.alias AS t

        JOIN web.site AS u
            ON
                u.domain = t.site AND
                u.port = t.site_port

        JOIN server_access.user AS s
            ON
                u.user = s.user AND
                s.service_name = t.service_name

        WHERE s.owner = v_owner
        ORDER BY t.backend_status, t.domain;
