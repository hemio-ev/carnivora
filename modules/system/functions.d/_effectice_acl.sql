name: _effective_acl
description: ACL

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
  type: dns.t_domain
 -
  name: owner
  type: user.t_user
 -
  name: domain_contingent
  type: int

body: |
 RETURN QUERY
  SELECT
   DISTINCT ON
   (acl.service, acl.subservice, acl.service_entity_name, usr.owner)
   acl.service,
   acl.subservice,
   acl.service_entity_name,
   usr.owner,
   acl.domain_contingent
  FROM system.subservice_entity_acl AS acl

  CROSS JOIN "user"."user" AS usr

  JOIN system._inherit_acl_donor(usr.owner) AS des
    ON des.donor = acl.owner

  ORDER BY
   acl.service,
   acl.subservice,
   acl.service_entity_name,
   usr.owner,
   des.priority_list DESC;
