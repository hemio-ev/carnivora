---
name: ins_registered
description: Inserts details for registered domain

templates:
 - user.userlogin

returns: void

parameters:
 -
  name: p_domain
  type: dns.t_domain
 -
  name: p_registrant
  type: varchar
 -
  name: p_admin_c
  type: varchar
---

INSERT INTO domain_reseller.registered
    (domain, registrant, admin_c)
VALUES
    (p_domain, p_registrant, p_admin_c);
