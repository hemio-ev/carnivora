name: srv_https
description: |
 Certs

templates:
 - backend.backend

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
  name: x509_chain
  type: varchar[]

body: |

    RETURN QUERY
    SELECT
        t.identifier,
        t.domain,
        t.x509_request,
        t.x509_certificate,
        ARRAY(
            SELECT s.x509_certificate::varchar
            FROM web.intermediate_chain AS u
            JOIN web.intermediate_cert AS s
                USING (subject_key_identifier)
            WHERE
                u.domain = t.domain AND
                u.identifier = t.identifier
            ORDER by "order"
        )
    FROM web.https AS t;
