name: upd_list
description: Change list admin

templates:
 - user.userlogin

returns: void

parameters:
 -
  name: p_localpart
  type: email.t_localpart
 -
  name: p_domain
  type: dns.t_domain
 -
  name: p_admin
  type: email.t_address

body: |
    UPDATE email.list
        SET
            admin = p_admin,
            backend_status = 'upd'
    WHERE
        localpart = p_localpart AND
        domain = p_domain AND
        owner = v_owner AND
        backend._active(backend_status);

    IF FOUND THEN
        PERFORM backend._notify('email__list', p_domain);
    ELSE
        PERFORM commons._raise_inaccessible_or_missing();
    END IF;
