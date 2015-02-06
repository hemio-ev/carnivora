name: _address
description: List all addresses

returns: TABLE
returns_columns:
 -
  name: local_part
  type: email.t_local_part
 -
  name: domain
  type: dns.t_domain
 -
  name: owner
  type: user.t_user

body: |
 RETURN QUERY (
  SELECT t.local_part, t.domain, t.owner FROM email.mailbox AS t
  UNION ALL
  SELECT t.local_part, t.domain, t.owner FROM email.redirect AS t
  UNION ALL
  SELECT t.local_part, t.domain, s.owner FROM email.alias AS t
   LEFT JOIN email.mailbox AS s
    ON
     t.mailbox_local_part = s.local_part AND
     t.mailbox_domain = s.domain
 );

