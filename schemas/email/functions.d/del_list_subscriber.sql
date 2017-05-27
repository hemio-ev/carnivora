---
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
  name: p_list_hostname
  type: dns.t_hostname
 -
  name: p_address
  type: email.t_address
---

UPDATE email.list_subscriber AS t
    SET backend_status = 'del'

    FROM email.list AS s
    WHERE
        s.localpart = t.list_localpart AND
        s.domain = t.list_hostname AND
        s.owner = v_owner AND

        t.list_localpart = p_list_localpart AND
        t.list_hostname = p_list_hostname AND
        t.address = p_address;

PERFORM backend._conditional_notify(FOUND, 'email', 'list', p_list_hostname);
