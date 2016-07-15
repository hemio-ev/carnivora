---
name: del_intermediate_chain
description: sdf

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

DELETE FROM web.intermediate_chain
    WHERE
        domain = p_domain AND
        port = p_port AND
        identifier = p_identifier;
