name: srv_registered
description: |
 Serve registerd domain details

templates:
 - backend.backend

returns: TABLE
returns_columns:
 -
  name: domain
  type: dns.t_domain
 -
  name: registrant
  type: varchar
 -
  name: registrant_id
  type: varchar
 -
  name: admin_c
  type: varchar
 -
  name: admin_c_id
  type: varchar
 -
  name: tech_c
  type: varchar
 -
  name: tech_c_id
  type: varchar
 -
  name: zone_c
  type: varchar
 -
  name: zone_c_id
  type: varchar
 -
  name: backend_status
  type: backend.t_status

body: |
    RETURN QUERY
    SELECT
        t.domain,
        t.registrant,
        (SELECT id FROM domain_reseller.handle WHERE alias = t.registrant),
        t.admin_c,
        (SELECT id FROM domain_reseller.handle WHERE alias = t.admin_c),
        t.tech_c,
        (SELECT id FROM domain_reseller.handle WHERE alias = t.tech_c),
        t.zone_c,
        (SELECT id FROM domain_reseller.handle WHERE alias = t.zone_c),
        s.backend_status
     FROM domain_reseller.registered AS t
    JOIN dns.registered AS s USING (domain)
    WHERE
    backend._machine_priviledged_service(s.service, s.service_entity_name) AND
    (backend._active(s.backend_status) OR p_include_inactive);
