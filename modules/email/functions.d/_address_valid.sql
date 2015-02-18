name: _address_valid
description: x

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
        SELECT TRUE FROM email._address()
        WHERE
            localpart = p_localpart AND
            domain = p_domain
    ) THEN
        RAISE 'Email address already exists.'
            USING DETAIL = '$carnivora:email:address_already_exists';
    END IF;
        