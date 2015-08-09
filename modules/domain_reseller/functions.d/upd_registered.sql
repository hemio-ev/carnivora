name: upd_registered
description: Update Registered

templates:
 - user.userlogin

returns: void

variables:
 -
  name: v_nameserver
  type: dns.t_domain
 -
  name: v_managed
  type: commons.t_key

parameters:
 -
  name: p_domain
  type: dns.t_domain
 -
  name: p_admin_c
  type: varchar

body: |
    UPDATE domain_reseller.registered AS t
        SET
            admin_c = p_admin_c
    FROM dns.registered AS s
    WHERE
        s.domain = t.domain AND
        s.owner = v_owner AND

        t.domain = p_domain;

    UPDATE dns.registered AS t
        SET backend_status = 'upd'
    WHERE
        t.owner = v_owner AND
        t.domain = p_domain AND
        -- don't change domains that are in some transition status
        (t.backend_status = 'upd' OR t.backend_status IS NULL)
    RETURNING t.service_entity_name, t.subservice
            INTO v_nameserver, v_managed;

    PERFORM backend._conditional_notify_service_entity_name(
        FOUND, v_nameserver, 'domain_registered', v_managed
    );

