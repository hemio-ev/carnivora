---
name: sel_registered
description: Selects details for registered domains

templates:
 - user.userlogin

returns: TABLE
returns_columns:
 -
  name: domain
  type: dns.t_domain
 -
  name: registrant
  type: varchar
 -
  name: admin_c
  type: varchar
 -
  name: tech_c
  type: varchar
 -
  name: zone_c
  type: varchar
 -
  name: payable
  type: timestamp
 -
  name: period
  type: integer
 -
  name: registrar_status
  type: varchar
 -
  name: registry_status
  type: varchar
 -
  name: last_status
  type: varchar
 -
  name: backend_status
  type: backend.t_status
---

RETURN QUERY
    SELECT
        t.domain,
        t.registrant,
        t.admin_c,
        t.tech_c,
        t.zone_c,
        t.payable,
        t.period,
        t.registrar_status,
        t.registry_status,
        t.last_status,
        s.backend_status
    FROM domain_reseller.registered AS t
    JOIN dns.registered AS s
        USING (domain)
    WHERE
        s.owner = v_owner
    ORDER BY backend_status, domain
;
