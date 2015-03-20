name: sel_site
description: |
 Owner defined via server_access

templates:
 - user.userlogin

returns: TABLE
returns_columns:
 -
  name: domain
  type: dns.t_domain
 -
  name: port
  type: commons.t_port
 -
  name: user
  type: server_access.t_user
 -
  name: service_name
  type: dns.t_domain
 -
  name: https
  type: commons.t_key
 -
  name: backend_status
  type: backend.t_status

body: |
    RETURN QUERY
        SELECT
            t.domain,
            t.port,
            t.user,
            t.service_name,
            t.https,
            t.backend_status
        FROM web.site AS t
        JOIN server_access.user AS s
            USING ("user", service_name)
        WHERE
            s.owner = v_owner
        ORDER BY t.backend_status, t.domain;
