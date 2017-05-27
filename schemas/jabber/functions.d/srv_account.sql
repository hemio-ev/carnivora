---
name: srv_account
description: Lists all jabber accounts

templates:
 - backend.backend

returns: TABLE
returns_columns:
 -
  name: node
  type: email.t_localpart
 -
  name: domain
  type: dns.t_hostname
 -
  name: password
  type: commons.t_password
 -
  name: backend_status
  type: backend.t_status
---

RETURN QUERY
    WITH

    -- DELETE
    d AS (
        DELETE FROM jabber.account AS t
        WHERE
            backend._deleted(t.backend_status) AND
            backend._machine_priviledged_domain(t.service, t.domain)
    ),

    -- UPDATE
    s AS (
        UPDATE jabber.account AS t
            SET backend_status = NULL
        WHERE
            backend._machine_priviledged_domain(t.service, t.domain) AND
            backend._active(t.backend_status)
    )

    -- SELECT
    SELECT
        t.node,
        t.domain,
        t.password,
        t.backend_status
    FROM jabber.account AS t

    WHERE
        backend._machine_priviledged_domain(t.service, t.domain) AND
        (backend._active(t.backend_status) OR p_include_inactive);

