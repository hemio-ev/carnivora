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
  name: p_mailbox_local_part
  type: email.t_local_part 
 -
  name: p_mailbox_domain
  type: dns.t_domain

body: |
 INSERT INTO email.alias
    (local_part, domain, mailbox_local_part, mailbox_domain, owner) VALUES
    (p_alias_local_part, p_alias_domain, p_mailbox_local_part, p_mailbox_domain, v_owner);
 RETURN 0;
