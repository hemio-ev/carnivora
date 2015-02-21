name: ins_registered
description: registeres new domain

templates:
 - user.userlogin

parameters:
 -
  name: p_domain
  type: dns.t_domain
 -
  name: p_public_suffix
  type: varchar

returns: void

body: |
    INSERT INTO dns.registered
    (domain, public_suffix, owner)
    VALUES
    (p_domain, p_public_suffix, v_owner);
