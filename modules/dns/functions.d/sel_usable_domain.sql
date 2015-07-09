name: sel_usable_domain
description: Usable domains

templates:
 - user.userlogin

returns: TABLE
returns_columns:
 -
  name: domain
  type: dns.t_domain
 -
  name: service_entity_name
  type: dns.t_domain
 -
  name: ur
  type: user.t_user

parameters:
 -
  name: p_service
  type: commons.t_key
 -
  name: p_subservice
  type: commons.t_key
 -
  name: p_user
  type: user.t_user

body: |
    RETURN QUERY
    SELECT t.domain, t.service_entity_name, acl_d.owner FROM dns.service AS t
        JOIN dns.registered AS d
            ON d.domain = t.registered
        LEFT JOIN system._effective_acl_domain() AS acl_d
            ON
                acl_d.domain = t.domain AND
                acl_d.service = t.service AND
                acl_d.subservice = p_subservice AND
                acl_d.service_entity_name = t.service_entity_name AND
                acl_d.owner = p_user

        LEFT JOIN system._effective_acl() AS acl
            ON
                acl.service = t.service AND
                acl.subservice = p_subservice AND
                acl.owner = p_user AND
                d.owner = p_user

        WHERE
            t.service = p_service AND
            COALESCE(acl_d.domain_contingent, acl.domain_contingent, 0) > 0
    ;
