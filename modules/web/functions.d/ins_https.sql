name: ins_https
description: |
 Ins HTTPS

templates:
 - user.userlogin

returns: void

parameters:
 -
  name: p_domain
  type: dns.t_domain
 -
  name: p_identifier
  type: commons.t_key

body: |
    INSERT INTO web.https
    (domain, identifier)
    VALUES
    (p_domain, p_identifier);