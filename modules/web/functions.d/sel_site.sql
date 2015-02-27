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
  name: user
  type: server_access.t_user
 -
  name: service_name
  type: dns.t_domain
 -
  name: https
  type: commons.t_key

body: |
    RETURN QUERY
        SELECT
            t.domain,
            t.user,
            t.service_name,
            t.https
        FROM web.site AS t
        JOIN server_access.user AS s
            USING ("user", service_name)
        WHERE
            s.owner = v_owner;
