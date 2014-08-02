name: backend_account
description: List all mail accounts for machine

templates:
 - backend.backend

return: TABLE
return_columns:
 -
  name: id
  type: uuid

body: |
 RETURN QUERY
    SELECT email.account.domain FROM email.account
        JOIN dns.name_host ON dns.name_host.id = email.account.domain
        JOIN system.host_name ON dns.name_host.host_name_entry = system.host_name.id
        JOIN system.host USING (name)
    
        WHERE system.host.machine = v_machine;
