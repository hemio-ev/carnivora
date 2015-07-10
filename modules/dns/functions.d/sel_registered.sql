name: sel_registered
description: List registered domains

templates:
 - user.userlogin

returns: TABLE
returns_columns:
 -
  name: domain
  type: dns.t_domain
 -
  name: public_suffix
  type: varchar
 -
  name: backend_status
  type: backend.t_status
 -
  name: subservice
  type: commons.t_key
 -
  name: service_entity_name
  type: dns.t_domain

body: |
    RETURN QUERY
        SELECT t.domain, t.public_suffix, t.backend_status, t.subservice, t.service_entity_name
        FROM dns.registered AS t
        WHERE
            t.owner = v_owner
        ORDER BY backend_status, domain;
