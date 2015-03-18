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
  name: p_user
  type: server_access.t_user
 -
  name: p_service_name
  type: dns.t_domain

body: |

    INSERT INTO web.site
    (domain, "user", service_name)
    VALUES
    (p_domain, p_user, p_service_name);

    PERFORM backend._notify('web', p_domain);
