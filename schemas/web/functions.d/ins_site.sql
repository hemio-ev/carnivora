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
  type: dns.t_hostname
 -
  name: p_port
  type: commons.t_port
 -
  name: p_user
  type: server_access.t_user
 -
  name: p_service_entity_name
  type: dns.t_hostname
---

PERFORM system._contingent_ensure(
    p_owner:=v_owner,
    p_domain:=p_domain,
    p_service:='web',
    p_subservice:='site',
    p_current_quantity_total:=
        (SELECT COUNT(*) FROM web.site WHERE owner=v_owner)::int,
    p_current_quantity_domain:=
        (SELECT COUNT(*) FROM web.site WHERE owner=v_owner AND domain = p_domain)::int
    );

INSERT INTO web.site
    (domain, service, subservice, port, "user", service_entity_name, owner)
    VALUES
    (p_domain, 'web', 'site', p_port, p_user, p_service_entity_name, v_owner);

    PERFORM backend._notify_domain('web', 'site', p_domain);
