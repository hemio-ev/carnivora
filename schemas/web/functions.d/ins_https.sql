---
name: ins_https
description: |
 Create new HTTPS certificate
 
 .. todo::
  Fix missing owner verification (not critical)

templates:
 - user.userlogin

returns: void

parameters:
 -
  name: p_domain
  type: dns.t_hostname
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

PERFORM backend._notify_domain('web', 'site', p_domain);
