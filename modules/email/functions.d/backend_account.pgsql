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
    SELECT email.account.id FROM email.account
        JOIN email.address USING (id)
        JOIN dns.name_host ON dns.name_host.id = email.address.domain
        JOIN system.host_name ON dns.name_host.host_name_entry = system.host_name.id
        JOIN system.host USING (name)
    
        WHERE system.host.machine = v_machine;
