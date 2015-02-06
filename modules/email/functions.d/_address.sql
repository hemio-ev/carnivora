name: _address
description: List all addresses

returns: TABLE
returns_columns:
 -
  name: localpart
  type: email.t_localpart
 -
  name: domain
  type: dns.t_domain
 -
  name: owner
  type: user.t_user

body: |
 RETURN QUERY (
  SELECT t.localpart, t.domain, t.owner FROM email.mailbox AS t
  UNION ALL
  SELECT t.localpart, t.domain, t.owner FROM email.redirect AS t
  UNION ALL
  SELECT t.localpart, t.domain, s.owner FROM email.alias AS t
   LEFT JOIN email.mailbox AS s
    ON
     t.mailbox_localpart = s.localpart AND
     t.mailbox_domain = s.domain
 );

