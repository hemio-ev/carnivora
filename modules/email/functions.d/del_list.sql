name: del_list
description: Delete mailing list

templates:
 - user.userlogin

returns: void

parameters:
 -
  name: p_domain
  type: dns.t_domain
 -
  name: p_localpart
  type: email.t_localpart

body: |
    DELETE FROM email.list
    WHERE
        domain = p_domain AND
        localpart = p_localpart AND
        owner = v_owner;

    IF FOUND THEN
        PERFORM backend._notify('email__list', p_domain);
    ELSE
        PERFORM commons._raise_inaccessible_or_missing();
    END IF;
