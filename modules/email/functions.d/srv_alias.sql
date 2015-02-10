name: srv_alias
description: List all mail aliases for machine

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

        JOIN dns.service USING (domain, service)
        JOIN system.service_machine USING (service, service_name)
        
    WHERE
        system.service_machine.machine_name = v_machine
        AND
        backend._active(t.backend_status);

