name: del_service
description: deletes all service entries of a specific domain

templates:
 - user.userlogin

parameters:
 -
  name: p_domain
  type: dns.t_domain
 -
  name: p_service
  type: system.t_service

returns: void

body: |
    WITH d AS (
        DELETE FROM dns.service AS t
        WHERE
            domain = p_domain AND
            service = p_service AND
            EXISTS(SELECT TRUE FROM dns.registered AS s WHERE s.owner = v_owner AND s.domain = t.registered)
    )
    UPDATE dns.service AS t
        SET backend_status = 'del'
    WHERE
        domain = p_domain AND
        service = p_service AND
        EXISTS(SELECT TRUE FROM dns.registered AS s WHERE s.owner = v_owner AND s.domain = t.registered);
