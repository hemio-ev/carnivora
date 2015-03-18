name: ins_mailbox
description: |
 Creates an email box

returns: void

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
  name: p_password
  type: commons.t_password_plaintext

variables:
 -
  name: v_num_total
  type: int
 -
  name: v_num_domain
  type: int

body: |

    PERFORM email._address_valid(p_localpart, p_domain);

    INSERT INTO email.mailbox
        (localpart, domain, owner, password) VALUES
        (p_localpart, p_domain, v_owner, commons._hash_password(p_password));

    PERFORM backend._notify_domain('email', p_domain);
