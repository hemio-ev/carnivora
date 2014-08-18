name: frontend_service_create
description: Creates a collection of resource record where the entries are defined via a system.service_dns entries

templates:
 - user.userlogin

parameters:
 -
  name: p_domain
  type: dns.domain_name
 -
  name: p_service_name
  type: dns.domain_name
 -
  name: p_service
  type: dns.type

return: integer

variables:
 -
  name: v_host_name_id
  type: uuid
 -
  name: v_name_id
  type: uuid

body: |
 INSERT INTO dns.service (domain, service_name, service)
     VALUES (p_domain, p_service_name, p_service);
 RETURN 0;

