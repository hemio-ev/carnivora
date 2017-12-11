---
name: srv_user
description: backend server_access.user

templates:
 - backend.backend

returns:
 table:
 -
  name: user
  type: server_access.t_user
 -
  name: password
  type: commons.t_password
 -
  name: service
  type: commons.t_key
 -
  name: subservice
  type: commons.t_key
 -
  name: service_entity_name
  type: dns.t_hostname
 -
  name: backend_status
  type: backend.t_status
 -
  name: uid
  type: int
---

RETURN QUERY
    WITH

    -- DELETE
    d AS (
        DELETE FROM server_access.user AS t
        WHERE
            backend._deleted(t.backend_status) AND
            backend._machine_priviledged_entity(t.service, t.service_entity_name)
    ),

    -- UPDATE
    s AS (
        UPDATE server_access.user AS t
            SET backend_status = NULL
        WHERE
            backend._machine_priviledged_entity(t.service, t.service_entity_name) AND
            backend._active(t.backend_status)
    )

    -- SELECT
    SELECT
        t.user,
        t.password,
        t.service,
        t.subservice,
        t.service_entity_name,
        t.backend_status,
        t.uid
    FROM server_access.user AS t

    WHERE
        backend._machine_priviledged_entity(t.service, t.service_entity_name) AND
        (backend._active(t.backend_status) OR p_include_inactive);
