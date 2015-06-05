name: sel_activatable_service
description: Preliminary implementation

templates:
 - user.userlogin

returns: TABLE
returns_columns:
 -
  name: service
  type: system.t_service
 -
  name: service_name
  type: dns.t_domain

body: |
    RETURN QUERY
        SELECT
            t.service,
            t.service_name
        FROM system.service AS t
        ORDER BY t.service, t.service_name;
