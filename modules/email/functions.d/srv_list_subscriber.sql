name: srv_list_subscriber
description: Lists all mailinglist subscribers

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
  name: address
  type: email.t_address
 -
  name: backend_status
  type: backend.t_status

parameters:
 -
  name: p_include_inactive
  type: boolean
  default: "FALSE"

body: |
    RETURN QUERY
        WITH

        -- DELETE
        d AS (
            DELETE FROM email.list_subscriber AS t
            USING email.list AS l
            WHERE
                t.list_domain = l.domain AND
                t.list_localpart = l.localpart AND

                backend._deleted(t.backend_status) AND
                backend._machine_priviledged(l.service, l.domain)
        ),

        -- UPDATE
        s AS (
            UPDATE email.list_subscriber AS t
                SET backend_status = NULL
            FROM email.list AS l
            WHERE
                t.list_domain = l.domain AND
                t.list_localpart = l.localpart AND

                backend._machine_priviledged(l.service, l.domain) AND
                backend._active(t.backend_status)
        )

        -- SELECT
        SELECT
            t.list_localpart,
            t.list_domain,
            t.address,
            t.backend_status
        FROM email.list_subscriber AS t

        JOIN email.list AS l ON
            t.list_domain = l.domain AND
            t.list_localpart = l.localpart

        WHERE
            backend._machine_priviledged(l.service, l.domain) AND
            (backend._active(t.backend_status) OR p_include_inactive);
