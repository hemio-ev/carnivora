name: ins_list_subscriber
description: b

returns: void

parameters:
 -
  name: p_address
  type: email.t_address
 -
  name: p_list_localpart
  type: email.t_localpart
 -
  name: p_list_domain
  type: dns.t_domain

body: |
    INSERT INTO email.list_subscriber
        (address, list_localpart, list_domain) VALUES
        (p_address, p_list_localpart, p_list_domain);