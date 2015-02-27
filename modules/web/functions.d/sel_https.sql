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
  name: x509_request
  type: web.t_cert
 -
  name: x509_certificate
  type: web.t_cert
 -
  name: authority_key_identifier
  type: varchar

body: |
    RETURN QUERY
        SELECT
            t.identifier,
            t.domain,
            t.x509_request,
            t.x509_certificate,
            t.authority_key_identifier
        FROM web.https AS t;
