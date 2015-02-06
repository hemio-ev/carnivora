name: ins_alias
description: Create e-mail aliases

returns: boolean

templates:
 - user.userlogin

parameters:
 -
  name: p_alias_local_part
  type: email.t_local_part 
 -
  name: p_alias_domain
  type: dns.t_domain
 -
  name: p_mailbox_local_part
  type: email.t_local_part 
 -
  name: p_mailbox_domain
  type: dns.t_domain

body: |

    IF (SELECT TRUE FROM email.mailbox AS t
        WHERE t.domain=p_mailbox_domain AND t.local_part=p_mailbox_local_part)
    THEN

        INSERT INTO email.alias
            (local_part, domain, mailbox_local_part, mailbox_domain) VALUES
            (p_alias_local_part, p_alias_domain, p_mailbox_local_part, p_mailbox_domain);

        RETURN FALSE;
    ELSE
        RAISE 'The used mailbox is not available'
            USING DETAIL = '$carnivora:email:mailbox_missing$';
    END IF;
