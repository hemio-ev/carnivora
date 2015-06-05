name: srv_site
description: backend web.site

templates:
 - backend.backend

returns: TABLE
returns_columns:
 -
  name: domain
  type: dns.t_domain
 -
  name: port
  type: commons.t_port
 -
  name: user
  type: server_access.t_user
 -
  name: service_entity_name
  type: dns.t_domain
 -
  name: https
  type: commons.t_key
 -
  name: backend_status
  type: backend.t_status

body: |
    RETURN QUERY
        WITH

        -- DELETE
        d AS (
            DELETE FROM web.site AS t
            WHERE
                backend._deleted(t.backend_status) AND
                backend._machine_priviledged(t.service, t.domain)
        ),

        -- UPDATE
        s AS (
            UPDATE web.site AS t
                SET backend_status = NULL
            WHERE
                backend._machine_priviledged(t.service, t.domain) AND
                backend._active(t.backend_status)
        )

        -- SELECT
        SELECT
            t.domain,
            t.port,
            t.user,
            t.service_entity_name,
            t.https,
            t.backend_status
        FROM web.site AS t

        WHERE
            backend._machine_priviledged(t.service, t.domain) AND
            (backend._active(t.backend_status) OR p_include_inactive);
