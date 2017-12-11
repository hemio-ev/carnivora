---
name: srv_alias
description: Lists all email aliases

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
  name: mailbox_localpart
  type: email.t_localpart
 -
  name: mailbox_domain
  type: dns.t_hostname
 -
  name: backend_status
  type: backend.t_status
---

RETURN QUERY
    WITH

    -- DELETE
    d AS (
        DELETE FROM email.alias AS t
        WHERE
            backend._deleted(t.backend_status) AND
            backend._machine_priviledged_domain(t.service, t.domain)
    ),

    -- UPDATE
    s AS (
        UPDATE email.alias AS t
            SET backend_status = NULL
        WHERE
            backend._machine_priviledged_domain(t.service, t.domain) AND
            backend._active(t.backend_status)
    )

    -- SELECT
    SELECT
        t.localpart,
        t.domain,
        t.mailbox_localpart,
        t.mailbox_domain,
        t.backend_status
    FROM email.alias AS t

    WHERE
        backend._machine_priviledged_domain(t.service, t.domain) AND
        (backend._active(t.backend_status) OR p_include_inactive);
