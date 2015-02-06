name: _contingent_exceeded
description: |
 Trhows exceptions if the contingent is exceeded in some way.

returns: boolean

parameters:
 -
  name: p_user
  type: user.t_user
 -
  name: p_service
  type: system.t_service
 -
  name: p_domain
  type: dns.t_domain
 -
  name: p_current_quantity_total
  type: integer
 -
  name: p_current_quantity_domain
  type: integer

variables:
 -
  name: v_remaining
  type: integer

body: |

    v_remaining := COALESCE(
        "user"._contingent_remaining(
        p_user := p_user,
        p_service := p_service,
        p_domain := p_domain,
        p_current_quantity_total := p_current_quantity_total,
        p_current_quantity_domain := p_current_quantity_domain
        ),
        0
    );

    IF v_remaining <= 0
    THEN
        RAISE 'Contingent exceeded'
            USING DETAIL = '$carnivora:user:contingent_exceeded$';
    END IF;

    RETURN FALSE;
