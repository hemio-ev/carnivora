name: ins_site
description: |
 Insert site
 TODO: check owner and contingent

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

body: |

    INSERT INTO web.site
    (domain, service, subservice, port, "user", service_entity_name)
    VALUES
    (p_domain, 'web', 'site', p_port, p_user, p_service_entity_name);

    PERFORM backend._notify_domain('web', p_domain);
