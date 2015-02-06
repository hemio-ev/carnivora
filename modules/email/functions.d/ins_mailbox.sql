name: ins_mailbox
description: |
 Creates an email box

returns: integer

templates:
 - user.userlogin
 - email.insert

parameters:
 -
  name: p_localpart
  type: email.t_localpart 
 -
  name: p_domain
  type: dns.t_domain
 -
  name: password
  type: varchar(255)

variables:
 -
  name: v_num_total
  type: int
 -
  name: v_num_domain
  type: int

body: |

 INSERT INTO email.mailbox
    (localpart, domain, owner, password) VALUES
    (p_localpart, p_domain, v_owner, 'pw');
 RETURN 0;

