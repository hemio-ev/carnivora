name: _contingent_quantity
description: |
 Contingent

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

body: |
    RETURN (
        SELECT
            t.quantity
        FROM "user"."contingent_service" AS t
        
        INNER JOIN dns.service AS s
            ON s.domain = p_domain AND s.service = p_service AND s.owner = p_user
        
        WHERE
            t.service = p_service
            AND
            (t.user_name = p_user OR t.user_name IS NULL)
        
        ORDER BY t.user_name IS NULL DESC
        
        FETCH FIRST 1 ROW ONLY
    );
