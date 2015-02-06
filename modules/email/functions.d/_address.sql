name: _address
description: List all addresses

return: TABLE
return_columns:
 -
  name: local_part
  type: email.local_part
 -
  name: domain
  type: dns.domain_name
 -
  name: owner
  type: varchar(50)

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

