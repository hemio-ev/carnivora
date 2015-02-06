name: srv_mailbox
description: List all mail mailboxs for machine

templates:
 - backend.backend

returns: TABLE
returns_columns:
 -
  name: local_part
  type: email.t_local_part
 -
  name: domain
  type: dns.t_domain

body: |
 RETURN QUERY
    SELECT t.local_part, t.domain FROM email.mailbox AS t
        JOIN dns.service USING (domain, service)
        JOIN system.service_machine USING (service, service_name)
        
        WHERE system.service_machine.machine_name = v_machine;

