name: del_redirection
description: Delete redirection

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

body: |

    IF (
        SELECT TRUE FROM email.redirection
        WHERE
            localpart = p_localpart AND
            domain = p_domain AND
            owner = v_owner
    )
    THEN
        UPDATE email.redirection
            SET
                backend_status = 'del'
            WHERE
                localpart = p_localpart AND
                domain = p_domain;

        PERFORM backend._notify('email', p_domain);
    ELSE
        PERFORM commons._raise_inaccessible_or_missing();
    END IF;
