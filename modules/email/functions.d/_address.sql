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
  type: commons.t_key

body: |
 RETURN QUERY (
  SELECT t.local_part, t.domain, t.owner FROM email.account AS t
  UNION ALL
  SELECT t.local_part, t.domain, t.owner FROM email.redirect AS t
  UNION ALL
  SELECT t.local_part, t.domain, t.owner FROM email.alias AS t
   LEFT JOIN email.address AS a
    ON
     t.account_local_part = a.local_part AND
     t.account_domain = a.domain
 );

