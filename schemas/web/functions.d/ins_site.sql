---
name: ins_site
description: |
 Insert site

 .. todo:: check owner and contingent

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
  name: p_user
  type: server_access.t_user
 -
  name: p_service_entity_name
  type: dns.t_domain
---

INSERT INTO web.site
    (domain, service, subservice, port, service_entity_name, storage_user, storage_service, storage_service_entity_name)
    SELECT p_domain, 'web', 'site', p_port, p_service_entity_name, p_user, s.storage_service, s.storage_service_entity_name
     FROM web.storage AS s
      WHERE s.service = 'web'
      AND s.service_entity_name = p_service_entity_name
      AND s.port = p_port
;

PERFORM backend._conditional_notify(FOUND, 'web', 'site', p_domain);
