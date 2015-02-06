name: ins_account
description: |
 Creates e-mail account

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
 -
  name: password
  type: varchar

variables:
 -
  name: v_test
  type: int

body: |
 v_test := (SELECT COUNT(*) FROM email._address() AS t WHERE t.owner=v_owner);
 INSERT INTO email.account
    (local_part, domain, owner, password) VALUES
    (p_local_part, p_domain, v_owner, 'pw');
 RETURN 0;

