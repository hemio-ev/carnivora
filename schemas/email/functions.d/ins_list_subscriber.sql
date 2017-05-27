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
  name: p_list_hostname
  type: dns.t_hostname
---

PERFORM commons._raise_inaccessible_or_missing(
    EXISTS(
        SELECT TRUE FROM email.list
        WHERE
            localpart = p_list_localpart AND
            domain =  p_list_hostname AND
            owner = v_owner
    )
);

INSERT INTO email.list_subscriber
    (address, list_localpart, list_hostname)
VALUES
    (p_address, p_list_localpart, p_list_hostname);

PERFORM backend._notify_domain('email', 'list', p_list_hostname);
