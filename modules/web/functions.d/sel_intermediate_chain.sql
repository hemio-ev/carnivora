name: sel_intermediate_chain
description: sel

templates:
 - user.userlogin

returns: TABLE
returns_columns:
 -
  name: domain
  type: dns.t_domain
 -
  name: port
  type: commons.t_port
 -
  name: identifier
  type: commons.t_key
 -
  name: subject_key_identifier
  type: varchar
 -
  name: x509_certificate
  type: web.t_cert

body: |
    RETURN QUERY
        SELECT
            t.domain,
            t.port,
            t.identifier,
            t.subject_key_identifier,
            s.x509_certificate
        FROM web.intermediate_chain AS t
        JOIN web.intermediate_cert AS s
            USING (subject_key_identifier);
