name: backend_account
description: List all mail accounts for machine

templates:
 - backend.backend

return: TABLE
return_columns:
 -
  name: name
  type: dns.domain_name

body: |
 RETURN QUERY
    SELECT email.account.domain FROM email.account
        JOIN dns.name_host ON dns.name_host.name = email.account.domain
        JOIN system.host_name ON system.host_name.name = dns.name_host.host_name
        JOIN system.host ON system.host.name = system.host_name.name
    
        WHERE system.host.machine = v_machine;
