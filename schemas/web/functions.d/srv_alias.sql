---
name: srv_alias
description: backend web.alias

templates:
 - backend.backend

returns: TABLE
returns_columns:
 -
  name: domain
  type: dns.t_hostname
 -
  name: site
  type: dns.t_hostname
 -
  name: site_port
  type: commons.t_port
 -
  name: backend_status
  type: backend.t_status
---

RETURN QUERY
    WITH

    -- DELETE
    d AS (
        DELETE FROM web.alias AS t
        WHERE
            backend._deleted(t.backend_status) AND
            backend._machine_priviledged(t.service, t.domain)
    ),

    -- UPDATE
    s AS (
        UPDATE web.alias AS t
            SET backend_status = NULL
        WHERE
            backend._machine_priviledged(t.service, t.domain) AND
            backend._active(t.backend_status)
    )

    -- SELECT
    SELECT
        t.domain,
        t.site,
        t.site_port,
        t.backend_status
    FROM web.alias AS t

    WHERE
        backend._machine_priviledged(t.service, t.domain) AND
        (backend._active(t.backend_status) OR p_include_inactive);
