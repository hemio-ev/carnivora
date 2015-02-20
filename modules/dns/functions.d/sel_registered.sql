name: sel_registered
description: List registered domains

templates:
 - user.userlogin

returns: TABLE
returns_columns:
 -
  name: domain
  type: dns.t_domain
 -
  name: public_suffix
  type: varchar

body: |
    RETURN QUERY
        SELECT t.domain, t.public_suffix
        FROM dns.registered AS t
        WHERE
            t.owner = v_owner;
