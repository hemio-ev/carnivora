---
name: sel_reseller
description: Selects available resellers

templates:
 - user.userlogin

returns: TABLE
returns_columns:
 -
  name: subservice
  type: commons.t_key
 -
  name: service_entity_name
  type: dns.t_hostname
---

RETURN QUERY
SELECT
    COALESCE(t.subservice, s.subservice) AS subservice,
    COALESCE(t.service_entity_name, s.service_entity_name) AS service_entity_name
FROM system._effective_contingent() AS t
FULL OUTER JOIN system._effective_contingent_hostname() AS s
USING (service, subservice, service_entity_name, owner)
WHERE
    COALESCE(t.service, s.service) = 'domain_reseller' AND
    COALESCE(t.owner, s.owner) = v_owner

    ORDER BY subservice, service_entity_name
;
