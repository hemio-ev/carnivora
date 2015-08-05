name: del_account
description: Delete jabber account

templates:
 - user.userlogin

returns: void

parameters:
 -
  name: p_node
  type: email.t_localpart
 -
  name: p_domain
  type: dns.t_domain

body: |
    UPDATE jabber.account
    SET backend_status = 'del'
    WHERE
        node = p_node AND
        domain = p_domain AND
        owner = v_owner;

    PERFORM backend._conditional_notify(FOUND, 'jabber', p_domain);
