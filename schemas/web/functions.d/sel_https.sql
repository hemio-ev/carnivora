name: sel_https
description: sel https

templates:
 - user.userlogin

returns: TABLE
returns_columns:
 -
  name: identifier
  type: commons.t_key
 -
  name: domain
  type: dns.t_domain
 -
  name: port
  type: commons.t_port
 -
  name: x509_request
  type: web.t_cert
 -
  name: x509_certificate
  type: web.t_cert
 -
  name: authority_key_identifier
  type: varchar
 -
  name: backend_status
  type: backend.t_status

body: |
    RETURN QUERY
        SELECT
            t.identifier,
            t.domain,
            t.port,
            t.x509_request,
            t.x509_certificate,
            t.authority_key_identifier,
            t.backend_status
        FROM web.https AS t
        ORDER BY t.backend_status, t.identifier;
