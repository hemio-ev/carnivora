---
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
---

PERFORM commons._raise_inaccessible_or_missing(
    EXISTS(
        SELECT TRUE FROM email.list
        WHERE
            localpart = p_list_localpart AND
            domain =  p_list_domain AND
            owner = v_owner
    )
);

INSERT INTO email.list_subscriber
    (address, list_localpart, list_domain)
VALUES
    (p_address, p_list_localpart, p_list_domain);

PERFORM backend._notify_domain('email', 'list', p_list_domain);
