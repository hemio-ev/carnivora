name: ins_redirection
description: |
 Creates a redirection

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
  name: p_destination
  type: email.t_address

variables:
 -
  name: v_num_total
  type: int
 -
  name: v_num_domain
  type: int

body: |

    PERFORM email._address_valid(p_localpart, p_domain);

    INSERT INTO email.redirection
        (localpart, domain, destination, owner) VALUES
        (p_localpart, p_domain, p_destination, v_owner);

    PERFORM backend._notify_domain('email', p_domain);

