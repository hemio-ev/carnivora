templates:
 - user.userlogin

name: sel_available_service
description: |
 List all domains that have a service entry in dns with their service.
 This is particularly usefull since these domains are ready for use with
 this service. Usually this means that accounts etc. can be created for this
 domain.

 TODO: Their is no owner of dns entries and therefore no access check at all!

returns: TABLE
returns_columns:
 -
  name: domain
  type: dns.t_domain
 -
  name: service
  type: system.t_service

body: |
    RETURN QUERY
        SELECT t.domain, t.service FROM dns.service AS t
    WHERE
        "user"._contingent_remaining(
            p_domain := t.domain,
            p_service := t.service,
            p_user := t.owner,
            p_current_quantity_total := 0,
            p_current_quantity_domain := 0
        ) > 0;
