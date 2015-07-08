name: sel_activatable_service
description: Preliminary implementation

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

body: |
    RETURN QUERY
        SELECT
            t.service,
            t.service_entity_name
        FROM system.service AS t
        ORDER BY t.service, t.service_entity_name;
