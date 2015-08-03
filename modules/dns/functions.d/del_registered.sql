name: del_registered
description: |
 Delete registered domain

templates:
 - user.userlogin

returns: void

parameters:
 -
  name: p_domain
  type: dns.t_domain

body: |
 UPDATE dns.registered
 SET backend_status = 'del'
 WHERE domain = p_domain
  AND owner = v_owner;

 PERFORM backend._conditional_notify(FOUND, 'dns', p_domain);
