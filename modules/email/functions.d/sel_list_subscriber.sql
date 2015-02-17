name: sel_list_subscriber
description: a

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

body: |
    RETURN QUERY
        SELECT
            t.address,
            t.list_localpart,
            t.list_domain,
            t.backend_status
        FROM email.list_subscriber AS t
        ;

