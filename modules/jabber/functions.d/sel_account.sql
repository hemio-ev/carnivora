name: sel_account
description: Select jabber accounts

templates:
 - user.userlogin

returns: TABLE
returns_columns:
 -
  name: node
  type: email.t_localpart
 -
  name: domain
  type: dns.t_domain
 -
  name: backend_status
  type: backend.t_status

body: |
    RETURN QUERY
        SELECT
            t.node, 
            t.domain, 
            t.backend_status
        FROM jabber.account AS t
        WHERE
            t.owner = v_owner;
