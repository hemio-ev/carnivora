---
name: sel_list_subscriber
description: a

templates:
 - user.userlogin

returns: TABLE
returns_columns:
 -
  name: address
  type: email.t_address
 -
  name: list_localpart
  type: email.t_localpart
 -
  name: list_domain
  type: dns.t_domain
 -
  name: backend_status
  type: backend.t_status
---

RETURN QUERY
    SELECT
        t.address,
        t.list_localpart,
        t.list_domain,
        t.backend_status
    FROM email.list_subscriber AS t
    JOIN email.list AS s
    ON
        t.list_localpart = s.localpart AND
        t.list_domain = s.domain
    WHERE
        s.owner = v_owner
    ORDER BY t.list_localpart, t.list_domain, t.address;


