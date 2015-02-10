name: srv_mailbox
description: List all mail mailboxs for machine

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
        JOIN dns.service USING (domain, service)
        JOIN system.service_machine AS sys USING (service, service_name)
        
        WHERE
            sys.machine_name = v_machine AND
            backend._active(t.backend_status);
