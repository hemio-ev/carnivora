---
name: sel_user
description: sel user

templates:
 - user.userlogin

returns:
 table:
 -
  name: user
  type: server_access.t_user
 -
  name: password_login
  type: boolean
 -
  name: service
  type: commons.t_key
 -
  name: subservice
  type: commons.t_key
 -
  name: service_entity_name
  type: dns.t_hostname
 -
  name: backend_status
  type: backend.t_status
---

RETURN QUERY
    SELECT
        t.user,
        t.password IS NOT NULL,
        t.service,
        t.subservice,
        t.service_entity_name,
        t.backend_status
    FROM
        server_access.user AS t
    WHERE
        owner = v_owner
    ORDER BY backend_status, "user"
;
