name: del_list_subscriber
description: del

templates:
 - user.userlogin

returns: void

parameters:
 -
  name: p_list_localpart
  type: email.t_localpart
 -
  name: p_list_domain
  type: dns.t_domain
 -
  name: p_address
  type: email.t_address

body: |
    UPDATE email.list_subscriber
        SET backend_status = 'del'
        WHERE
            list_localpart = p_list_localpart AND
            list_domain = p_list_domain AND
            address = p_address;

