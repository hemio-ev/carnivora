name: srv_alias
description: Lists all email aliases

templates:
 - backend.backend

returns: TABLE
returns_columns:
 -
  name: alias_localpart
  type: email.t_localpart
 -
  name: alias_domain
  type: dns.t_domain
 -
  name: mailbox_localpart
  type: email.t_localpart
 -
  name: mailbox_domain
  type: dns.t_domain

body: |
 RETURN QUERY
    SELECT
        t.localpart, 
        t.domain, 
        t.mailbox_localpart, 
        t.mailbox_domain
    FROM email.alias AS t
        
    WHERE
        backend._machine_priviledged(t.service, t.domain) AND
        backend._active(t.backend_status);
