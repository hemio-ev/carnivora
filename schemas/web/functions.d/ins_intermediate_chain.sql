name: ins_intermediate_chain
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
 -
  name: p_order
  type: integer
 -
  name: p_subject_key_identifier
  type: varchar

body: |
    INSERT INTO web.intermediate_chain
    (domain, port, identifier, "order", subject_key_identifier)
    VALUES
    (p_domain, p_port, p_identifier, p_order, p_subject_key_identifier);
