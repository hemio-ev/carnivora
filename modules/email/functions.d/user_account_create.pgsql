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

body: |
 INSERT INTO email.account
    (local_part, domain, owner, password) VALUES
    (p_local_part, p_domain, v_owner, 'pw');
 RETURN 72;
