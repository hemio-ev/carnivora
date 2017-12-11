---
name: _effective_contingent_hostname
description: contingent

returns:
 table:
 -
  name: service
  type: commons.t_key
 -
  name: subservice
  type: commons.t_key
 -
  name: service_entity_name
  type: dns.t_hostname
 -
  name: domain
  type: dns.t_hostname
 -
  name: owner
  type: user.t_user
 -
  name: domain_contingent
  type: int
---

RETURN QUERY
  SELECT
   DISTINCT ON
   (contingent.service, contingent.subservice, contingent.service_entity_name, contingent.domain, usr.owner)
   contingent.service,
   contingent.subservice,
   contingent.service_entity_name,
   contingent.domain,
   usr.owner,
   contingent.domain_contingent
  FROM system.subservice_entity_domain_contingent AS contingent

  CROSS JOIN "user"."user" AS usr

  JOIN system._inherit_contingent_donor(usr.owner) AS des
    ON des.donor = contingent.owner

  ORDER BY
   contingent.service,
   contingent.subservice,
   contingent.service_entity_name,
   contingent.domain,
   usr.owner,
   des.priority_list DESC;
