name: ins_alias
description: Create e-mail aliases

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

    PERFORM email._address_valid(p_localpart, p_domain);
    LOCK TABLE email.mailbox;

    PERFORM commons._raise_inaccessible_or_missing(
    EXISTS(
        SELECT TRUE FROM email.mailbox
        WHERE
            domain=p_mailbox_domain AND
            localpart=p_mailbox_localpart AND
            owner=v_owner AND
            backend._active(backend_status)
     ));

    INSERT INTO email.alias
        (localpart, domain, mailbox_localpart, mailbox_domain)
    VALUES
        (p_localpart, p_domain, p_mailbox_localpart, p_mailbox_domain);

    PERFORM backend._notify_domain('email', p_domain);
