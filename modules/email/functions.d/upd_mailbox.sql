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
        SELECT TRUE FROM email.mailbox AS t
        WHERE
            t.localpart = p_localpart AND
            t.domain = p_domain AND
            t.owner = v_owner AND
            backend._active(t.backend_status)
    )
    THEN
        UPDATE email.mailbox AS t
            SET
                password = commons._hash_password(p_password),
                backend_status = 'upd'
            WHERE
                t.localpart = p_localpart AND
                t.domain = p_domain;
    ELSE
        PERFORM commons._raise_inaccessible_or_missing();
    END IF;
