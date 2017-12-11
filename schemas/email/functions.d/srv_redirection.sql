---
name: srv_redirection
description: Lists all mailinglists

templates:
 - backend.backend

returns:
 table:
 -
  name: localpart
  type: email.t_localpart
 -
  name: domain
  type: dns.t_hostname
 -
  name: destination
  type: email.t_address
 -
  name: backend_status
  type: backend.t_status
---

RETURN QUERY
    WITH

    -- DELETE
    d AS (
        DELETE FROM email.redirection AS t
        WHERE
            backend._deleted(t.backend_status) AND
            backend._machine_priviledged_domain(t.service, t.domain)
    ),

    -- UPDATE
    s AS (
        UPDATE email.redirection AS t
            SET backend_status = NULL
        WHERE
            backend._machine_priviledged_domain(t.service, t.domain) AND
            backend._active(t.backend_status)
    )

    -- SELECT
    SELECT
        t.localpart,
        t.domain,
        t.destination,
        t.backend_status
    FROM email.redirection AS t

    WHERE
        backend._machine_priviledged_domain(t.service, t.domain) AND
        (backend._active(t.backend_status) OR p_include_inactive);


