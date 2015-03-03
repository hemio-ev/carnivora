name: _contingent_domain
description: |
 Contingent

returns: integer

parameters:
 -
  name: p_owner
  type: user.t_user
 -
  name: p_service
  type: system.t_service
 -
  name: p_service_name
  type: dns.t_domain
 -
  name: p_domain
  type: dns.t_domain

variables:
 -
  name: v_user
  type: integer
 -
  name: v_default
  type: integer

body: |
    v_user := (
        SELECT t.quantity
        FROM system.contingent_domain AS t
        WHERE
            t.owner = p_owner AND
            t.service = p_service AND
            t.service_name = p_service_name AND
            t.domain = p_domain
    );

    v_default := (
        SELECT t.quantity
        FROM system.contingent_default_domain AS t
        WHERE
            t.service = p_service AND
            t.service_name = p_service_name AND
            t.domain = p_domain
    );

    RETURN COALESCE(v_user, v_default);
