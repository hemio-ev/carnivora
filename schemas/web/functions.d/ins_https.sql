---
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
  name: p_port
  type: commons.t_port
 -
  name: p_identifier
  type: commons.t_key
---

INSERT INTO web.https
    (domain, port, identifier)
    VALUES
    (p_domain, p_port, p_identifier);
