---
name: sel_activatable_service
description: |
 Activatable services

templates:
 - user.userlogin

returns: TABLE
returns_columns:
 -
  name: service
  type: commons.t_key
 -
  name: service_entity_name
  type: dns.t_domain
---

RETURN QUERY
SELECT
    COALESCE(t.service, s.service) AS service,
    COALESCE(t.service_entity_name, s.service_entity_name) AS service_entity_name
FROM system._effective_contingent() AS t
FULL OUTER JOIN system._effective_contingent_domain() AS s
USING (service, subservice, service_entity_name, owner)
WHERE
    COALESCE(t.subservice, s.subservice) = 'dns_activatable' AND
    COALESCE(t.owner, s.owner) = v_owner

  ORDER BY service, service_entity_name
;
