---
name: sel_usable_domain
description: Usable domains

templates:
 - user.userlogin

returns: TABLE
returns_columns:
 -
  name: domain
  type: dns.t_hostname
 -
  name: service_entity_name
  type: dns.t_hostname

parameters:
 -
  name: p_service
  type: commons.t_key
 -
  name: p_subservice
  type: commons.t_key
---

RETURN QUERY
SELECT t.domain, t.service_entity_name FROM dns.service AS t
    JOIN dns.registered AS d
        ON d.domain = t.registered
    LEFT JOIN system._effective_contingent_domain() AS contingent_d
        ON
            contingent_d.domain = t.domain AND
            contingent_d.service = t.service AND
            contingent_d.subservice = p_subservice AND
            contingent_d.service_entity_name = t.service_entity_name AND
            contingent_d.owner = v_owner

    LEFT JOIN system._effective_contingent() AS contingent
        ON
            contingent.service = t.service AND
            contingent.subservice = p_subservice AND
            contingent.owner = v_owner AND
            d.owner = v_owner

    WHERE
        t.service = p_service AND
        COALESCE(contingent_d.domain_contingent, contingent.domain_contingent, 0) > 0
    ORDER BY
        t.domain
;
