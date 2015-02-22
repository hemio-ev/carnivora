name: sel_user
description: sel user

templates:
 - user.userlogin

returns: TABLE
returns_columns:
 -
  name: user
  type: varchar
 -
  name: password_login
  type: boolean
 -
  name: service
  type: system.t_service
 -
  name: service_name
  type: dns.t_domain
 -
  name: backend_status
  type: backend.t_status

body: |
    RETURN QUERY
        SELECT
            t.user,
            t.password IS NOT NULL,
            t.service,
            t.service_name,
            t.backend_status
        FROM
            server_access.user AS t
        WHERE
            owner = v_owner;