name: _contingent_quantity_domain
description: |
 Contingent

returns: integer

parameters:
 -
  name: p_user
  type: commons.t_key
 -
  name: p_service
  type: commons.t_key
 -
  name: p_domain
  type: dns.t_domain

body: |
 RETURN (
  SELECT
    t.quantity
   FROM "user"."contingent_service_domain" AS t
   WHERE
    t.service = p_service
    AND
    (t.user_name = p_user OR t.user_name IS NULL)
    AND
    t.domain = p_domain
   ORDER BY t.user_name IS NULL DESC
   FETCH FIRST 1 ROW ONLY
 );

