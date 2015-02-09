name: del_mailbox
description: Delete mailbox

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
        SELECT TRUE FROM email.mailbox AS t
        WHERE
            t.localpart = p_localpart AND
            t.domain = p_domain AND
            t.owner = v_owner
    )
    THEN
        UPDATE email.mailbox AS t
            SET
                backend_status = 'del'
            WHERE
                t.localpart = p_localpart AND
                t.domain = p_domain;
    ELSE
        PERFORM commons._raise_inaccessible_or_missing();
    END IF;
