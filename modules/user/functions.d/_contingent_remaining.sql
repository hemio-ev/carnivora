name: _contingent_remaining
description: |
 Remaining

returns: integer

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
  name: v_quantity_total
  type: integer
 -
  name: v_quantity_domain
  type: integer

body: |

 v_quantity_total := (SELECT "user"._contingent_quantity(
   p_user, 
   p_service,
   p_domain));

 v_quantity_domain := (SELECT "user"._contingent_quantity_domain(
   p_user := p_user,
   p_service := p_service,
   p_domain := p_domain));

 RETURN LEAST(
   v_quantity_total - p_current_quantity_total,
   v_quantity_domain - p_current_quantity_domain
 );
