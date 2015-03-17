name: srv_list
description: Lists all mailinglists

templates:
 - backend.backend

returns: TABLE
returns_columns:
 -
  name: localpart
  type: email.t_localpart
 -
  name: domain
  type: dns.t_domain
 -
  name: admin
  type: email.t_address
 -
  name: backend_status
  type: backend.t_status

body: |
    RETURN QUERY
        WITH

        -- DELETE
        d AS (
            DELETE FROM email.list AS t
            WHERE
                backend._deleted(t.backend_status) AND
                backend._machine_priviledged(t.service, t.domain)
        ),

        -- UPDATE
        s AS (
            UPDATE email.list AS t
                SET backend_status = NULL
            WHERE
                backend._machine_priviledged(t.service, t.domain) AND
                backend._active(t.backend_status)
        )

        -- SELECT
        SELECT
            t.localpart,
            t.domain,
            t.admin,
            t.backend_status
        FROM email.list AS t

        WHERE
            backend._machine_priviledged(t.service, t.domain) AND
            (backend._active(t.backend_status) OR p_include_inactive);

