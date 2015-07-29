name: sel_list
description: List all lists

templates:
 - user.userlogin

returns: TABLE
returns_columns:
 -
  name: domain
  type: dns.t_domain
 -
  name: localpart
  type: email.t_localpart
 -
  name: owner
  type: user.t_user
 -
  name: admin
  type: email.t_address
 -
  name: backend_status
  type: backend.t_status
 -
  name: num_subscribers
  type: bigint

body: |
    RETURN QUERY
        SELECT
            t.domain,
            t.localpart,
            t.owner,
            t.admin,
            t.backend_status,
            (SELECT COUNT(*) FROM email.list_subscriber AS s
            WHERE s.list_localpart=t.localpart AND s.list_domain=t.domain)
        FROM
            email.list AS t
        WHERE
            t.owner = v_owner;
