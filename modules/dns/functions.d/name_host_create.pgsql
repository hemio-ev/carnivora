name: name_host_create
description: Creates a resource record where the rdata is defined via system.host_name

templates:
 - user.userlogin

parameters:
 -
  name: p_name
  type: dns.domain_name
 -
  name: p_type
  type: dns.type
 -
  name: p_host_name
  type: dns.domain_name

return: integer

variables:
 -
  name: v_host_name_id
  type: uuid
 -
  name: v_name_id
  type: uuid

body: |
 INSERT INTO dns.name (name, type) VALUES (p_name, p_type);
 v_name_id := (SELECT id FROM dns.name WHERE name=p_name AND type=p_type);
 v_host_name_id := (SELECT id FROM system.host_name WHERE name=p_host_name AND type=p_type);
 INSERT INTO dns.name_host (id, host_name_entry) VALUES (v_name_id, v_host_name_id);
 RETURN 73;

