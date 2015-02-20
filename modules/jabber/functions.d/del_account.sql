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
    DELETE FROM jabber.account
    WHERE
        node = p_node AND
        domain = p_domain AND
        owner = v_owner;

    IF FOUND THEN
        PERFORM backend._notify('jabber', p_domain);
    ELSE
        PERFORM commons._raise_inaccessible_or_missing();
    END IF;