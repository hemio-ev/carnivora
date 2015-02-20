name: ins_list_subscriber
description: |
 Adds a subscriber to a mailing list

templates:
 - user.userlogin

returns: void

parameters:
 -
  name: p_address
  type: email.t_address
 -
  name: p_list_localpart
  type: email.t_localpart
 -
  name: p_list_domain
  type: dns.t_domain

body: |

    IF EXISTS(
        SELECT TRUE FROM email.list
        WHERE
            localpart = p_list_localpart AND
            domain =  p_list_domain AND
            owner = v_owner
    ) THEN
        INSERT INTO email.list_subscriber
            (address, list_localpart, list_domain) VALUES
            (p_address, p_list_localpart, p_list_domain);

        PERFORM backend._notify('email__list', p_list_domain);
    ELSE
        PERFORM commons._raise_inaccessible_or_missing();
    END IF;
