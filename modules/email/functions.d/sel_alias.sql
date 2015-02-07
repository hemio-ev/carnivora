name: sel_alias
description: Select aliases

templates:
 - user.userlogin

returns: TABLE
returns_columns:
 -
  name: localpart
  type: email.t_localpart
 -
  name: domain
  type: dns.t_domain
 -
  name: mailbox_localpart
  type: email.t_localpart
 -
  name: mailbox_domain
  type: dns.t_domain

body: |
    RETURN QUERY
    SELECT t.localpart, t.domain, t.mailbox_localpart, t.mailbox_domain FROM email.alias AS t
        INNER JOIN email.mailbox AS s
            ON
                t.mailbox_localpart = s.localpart
                AND
                t.mailbox_domain = s.domain
        WHERE s.owner = v_owner;
