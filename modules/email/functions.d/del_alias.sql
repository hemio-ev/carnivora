name: del_alias
description: Delete Alias

returns: void

templates:
 - user.userlogin

parameters:
 -
  name: p_localpart
  type: email.t_localpart 
 -
  name: p_domain
  type: dns.t_domain
 -
  name: p_mailbox_localpart
  type: email.t_localpart 
 -
  name: p_mailbox_domain
  type: dns.t_domain

body: |

    IF (
        SELECT TRUE FROM email.alias AS a
        JOIN email.mailbox AS b
            ON
                a.mailbox_localpart = b.localpart AND
                a.mailbox_domain = b.domain
        WHERE
            a.localpart = p_localpart AND
            a.domain = p_domain AND
            b.localpart = p_mailbox_localpart AND
            b.domain = p_mailbox_domain AND
            b.owner = v_owner
    )
    THEN
        UPDATE email.alias
            SET backend_status = 'del'
        WHERE
            localpart = p_localpart AND
            domain = p_domain;

        PERFORM backend._notify('email', p_domain);
    ELSE
        PERFORM commons._raise_inaccessible_or_missing();
    END IF;
