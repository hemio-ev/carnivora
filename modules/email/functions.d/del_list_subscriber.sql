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
    UPDATE email.list_subscriber AS t
        SET backend_status = 'del'

        FROM email.list AS s
        WHERE
            s.localpart = t.list_localpart AND
            s.domain = t.list_domain AND
            s.owner = v_owner AND

            t.list_localpart = p_list_localpart AND
            t.list_domain = p_list_domain AND
            t.address = p_address;

    IF FOUND THEN
        PERFORM backend._notify('email__list', p_list_domain);
    ELSE
        PERFORM commons._raise_inaccessible_or_missing();
    END IF;