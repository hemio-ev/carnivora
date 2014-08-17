name: frontend_name_host_create
description: Creates a resource record where the rdata is defined via a system.host_name entry

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
 INSERT INTO dns.name_host (name, type, host_name)
     VALUES (p_name, p_type, p_host_name);
 RETURN 0;

