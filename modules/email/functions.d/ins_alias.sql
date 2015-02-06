name: ins_alias
description: Create e-mail aliases

returns: integer

templates:
 - user.userlogin

parameters:
 -
  name: p_alias_local_part
  type: email.t_local_part 
 -
  name: p_alias_domain
  type: dns.t_domain
 -
  name: p_account_local_part
  type: email.t_local_part 
 -
  name: p_account_domain
  type: dns.t_domain

body: |
 INSERT INTO email.alias
    (local_part, domain, account_local_part, account_domain, owner) VALUES
    (p_alias_local_part, p_alias_domain, p_account_local_part, p_account_domain, v_owner);
 RETURN 0;
