name: ins_alias
description: Create e-mail aliases

returns: boolean

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
        SELECT TRUE FROM email.mailbox AS t
        WHERE
            t.domain=p_mailbox_domain AND
            t.localpart=p_mailbox_localpart AND
            t.owner=v_owner AND
            backend._active(t.backend_status)
    )
    THEN

        INSERT INTO email.alias
            (localpart, domain, mailbox_localpart, mailbox_domain) VALUES
            (p_localpart, p_domain, p_mailbox_localpart, p_mailbox_domain);

        RETURN FALSE;
    ELSE
        PERFORM commons._raise_inaccessible_or_missing();
    END IF;
