---
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
  name: port
  type: commons.t_port
 -
  name: x509_request
  type: web.t_cert
 -
  name: x509_certificate
  type: web.t_cert
 -
  name: x509_chain
  type: varchar[]
 -
  name: backend_status
  type: backend.t_status
---

RETURN QUERY
    WITH

    -- NO DELETE OPTION

    -- UPDATE
    s AS (
        UPDATE web.https AS t
            SET backend_status = NULL
        WHERE
            backend._machine_priviledged('web', t.domain) AND
            backend._active(t.backend_status)
    )

    -- SELECT
    SELECT
        t.identifier,
        t.domain,
        t.port,
        t.x509_request,
        t.x509_certificate,
        ARRAY(
            SELECT s.x509_certificate::varchar
            FROM web.intermediate_chain AS u
            JOIN web.intermediate_cert AS s
                USING (subject_key_identifier)
            WHERE
                u.domain = t.domain AND
                u.port = t.port AND
                u.identifier = t.identifier
            ORDER by "order"
        ),
        t.backend_status
    FROM web.https AS t

    WHERE
        backend._machine_priviledged('web', t.domain) AND
        (backend._active(t.backend_status) OR p_include_inactive);
