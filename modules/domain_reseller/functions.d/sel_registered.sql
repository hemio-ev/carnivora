name: sel_registered
description: Select Registered

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

body: |
    RETURN QUERY
        SELECT
            t.domain,
            t.registrant,
            t.admin_c,
            t.tech_c,
            t.zone_c
        FROM domain_reseller.registered AS t
        JOIN dns.registered AS s
            USING (domain)
        WHERE
            s.owner = v_owner;
