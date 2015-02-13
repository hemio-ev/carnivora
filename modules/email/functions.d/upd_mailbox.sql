name: upd_mailbox
description: Change mailbox password

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
  name: p_password
  type: commons.t_password_plaintext

body: |
    IF (
        SELECT TRUE FROM email.mailbox
        WHERE
            localpart = p_localpart AND
            domain = p_domain AND
            owner = v_owner AND
            backend._active(backend_status)
    )
    THEN
        UPDATE email.mailbox
            SET
                password = commons._hash_password(p_password),
                backend_status = 'upd'
            WHERE
                localpart = p_localpart AND
                domain = p_domain;

        PERFORM backend._notify('email', p_domain);
    ELSE
        PERFORM commons._raise_inaccessible_or_missing();
    END IF;
