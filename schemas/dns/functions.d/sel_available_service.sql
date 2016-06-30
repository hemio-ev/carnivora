---
templates:
 - user.userlogin

name: sel_available_service
description: |
 List all domains that have a service entry in dns with their service.
 This is particularly usefull since these domains are ready for use with
 this service. Usually this means that accounts etc. can be created for this
 domain.

returns: TABLE
returns_columns:
 -
  name: domain
  type: dns.t_domain
 -
  name: service
  type: commons.t_key
---

RETURN QUERY
    SELECT t.domain, t.service FROM dns.service AS t
    JOIN dns.registered AS s
        ON s.domain = t.registered
    WHERE
        (
            s.owner = v_owner AND

                system._contingent_total(
                    p_owner := s.owner,
                    p_service := t.service,
                    p_service_entity_name := t.service_entity_name
            ) IS NOT NULL
        ) OR
        system._contingent_domain(
                    p_owner := s.owner,
                    p_service := t.service,
                    p_service_entity_name := t.service_entity_name,
                    p_domain := t.domain
            ) IS NOT NULL
    ORDER BY t.service
;
