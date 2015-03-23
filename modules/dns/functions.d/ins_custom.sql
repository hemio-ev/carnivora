name: ins_custom
description: Ins Custom

templates:
 - user.userlogin

returns: void

parameters:
 -
  name: p_registered
  type: dns.t_domain
 -
  name: p_domain
  type: dns.t_domain
 -
  name: p_type
  type: dns.t_type
 -
  name: p_rdata
  type: dns.t_rdata
 -
  name: p_ttl
  type: integer

body: |

    INSERT INTO dns.custom
    (registered, domain, type, rdata, ttl)
    VALUES
    (p_registered, p_domain, p_type, p_rdata, p_ttl);
