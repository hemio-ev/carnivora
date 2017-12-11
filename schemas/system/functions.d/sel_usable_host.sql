---
name: sel_usable_host
description: Usable hosts

templates:
 - user.userlogin

returns:
 table:
 -
  name: subservice
  type: commons.t_key
 -
  name: service_entity_name
  type: dns.t_hostname

parameters:
 -
  name: p_service
  type: commons.t_key
---

RETURN QUERY
    SELECT t.subservice, t.service_entity_name FROM system._effective_contingent() AS t
        WHERE
            owner = v_owner AND
            t.service = p_service AND
            t.total_contingent > 0
        ORDER BY
            t.service_entity_name
    ;
