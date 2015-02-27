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
  name: p_identifier
  type: commons.t_key

body: |
    DELETE FROM web.intermediate_chain
    WHERE
        domain = p_domain AND
        identifier = p_identifier;
