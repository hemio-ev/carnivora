name: srv_mailbox
description: Lists all mailboxes

templates:
 - backend.backend

returns: TABLE
returns_columns:
 -
  name: localpart
  type: email.t_localpart
 -
  name: domain
  type: dns.t_domain
 -
  name: password
  type: commons.t_password
 -
  name: quota
  type: integer

body: |
 RETURN QUERY
    SELECT t.localpart, t.domain, t.password, t.quota FROM email.mailbox AS t
        
        WHERE
            backend._machine_priviledged(t.service, t.domain) AND
            backend._active(t.backend_status);
