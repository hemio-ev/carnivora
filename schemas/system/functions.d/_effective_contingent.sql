---
name: _effective_contingent
description: contingent

returns: TABLE
returns_columns:
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
  name: owner
  type: user.t_user
 -
  name: domain_contingent
  type: int
 -
  name: total_contingent
  type: int
---

RETURN QUERY
 SELECT
  DISTINCT ON
  (contingent.service, contingent.subservice, contingent.service_entity_name, usr.owner)
  contingent.service,
  contingent.subservice,
  contingent.service_entity_name,
  usr.owner,
  contingent.domain_contingent,
  contingent.total_contingent
 FROM system.subservice_entity_contingent AS contingent

 CROSS JOIN "user"."user" AS usr

 JOIN system._inherit_contingent_donor(usr.owner) AS des
   ON des.donor = contingent.owner

 ORDER BY
  contingent.service,
  contingent.subservice,
  contingent.service_entity_name,
  usr.owner,
  des.priority_list DESC;
