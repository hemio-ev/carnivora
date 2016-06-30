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
 -
  name: subservice
  type: commons.t_key

body: |
 RETURN QUERY (
  SELECT t.localpart, t.domain, t.owner, t.subservice FROM email.mailbox AS t
  UNION ALL
  SELECT t.localpart, t.domain, t.owner, t.subservice FROM email.redirection AS t
  UNION ALL
  SELECT t.localpart, t.domain, s.owner, t.subservice FROM email.alias AS t
   LEFT JOIN email.mailbox AS s
    ON
     t.mailbox_localpart = s.localpart AND
     t.mailbox_domain = s.domain
  UNION ALL
  SELECT t.localpart, t.domain, t.owner, t.subservice FROM email.list AS t
 );
