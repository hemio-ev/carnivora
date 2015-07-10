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
  name: v_subservice
  type: commons.t_key
  default: "'redirection'"

body: |

    PERFORM email._address_valid(p_localpart, p_domain);

    INSERT INTO email.redirection
        (service, subservice, localpart, domain, destination, owner, service_entity_name) VALUES
        ('email', 'redirection', p_localpart, p_domain, p_destination, v_owner,
        (SELECT service_entity_name FROM dns.service WHERE service='email' AND domain = p_domain));

    PERFORM backend._notify_domain('email', p_domain);
