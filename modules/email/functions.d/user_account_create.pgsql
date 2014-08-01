name: user_account_create
description: Create e-mail accounts

return: integer

templates:
 - user.userlogin

parameters:
 -
  name: p_local_part
  type: email.local_part 
 -
  name: p_domain
  type: dns.domain_name

variables:
 -
  name: v_id
  type: uuid
  default: commons.uuid()

body: |
 INSERT INTO email.address
    (id, local_part, domain, owner) VALUES
    (v_id, p_local_part, dns.name_host_find(p_domain, 'MX'), v_owner);
 INSERT INTO email.account
    (id, password) VALUES
    (v_id, 'pw');
 RETURN 72;
