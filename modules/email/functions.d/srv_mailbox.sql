name: srv_mailbox
description: Lists all mailboxes

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
  name: password
  type: commons.t_password
 -
  name: quota
  type: integer
 -
  name: backend_status
  type: backend.t_status

body: |
    RETURN QUERY
        WITH

        -- DELETE
        d AS (
            DELETE FROM email.mailbox AS t
            WHERE
                backend._deleted(t.backend_status) AND
                backend._machine_priviledged(t.service, t.domain)
        ),

        -- UPDATE
        s AS (
            UPDATE email.mailbox AS t
                SET backend_status = NULL
            WHERE
                backend._machine_priviledged(t.service, t.domain) AND
                backend._active(t.backend_status)
        )

        -- SELECT
        SELECT
            t.localpart,
            t.domain,
            t.password,
            t.quota,
            t.backend_status
        FROM email.mailbox AS t

        WHERE
            backend._machine_priviledged(t.service, t.domain) AND
            (backend._active(t.backend_status) OR p_include_inactive);
