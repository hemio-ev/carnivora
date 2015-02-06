name: ins_mailbox
description: |
 Creates an email box

returns: integer

templates:
 - user.userlogin

parameters:
 -
  name: p_local_part
  type: email.t_local_part 
 -
  name: p_domain
  type: dns.t_domain
 -
  name: password
  type: varchar(255)

variables:
 -
  name: v_test
  type: int

body: |
 v_test := (SELECT COUNT(*) FROM email._address() AS t WHERE t.owner=v_owner);
 INSERT INTO email.mailbox
    (local_part, domain, owner, password) VALUES
    (p_local_part, p_domain, v_owner, 'pw');
 RETURN 0;

