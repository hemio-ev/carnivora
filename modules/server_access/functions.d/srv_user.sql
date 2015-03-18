name: srv_user
description: backend server_access.user

templates:
 - backend.backend

returns: TABLE
returns_columns:
 -
  name: user
  type: server_access.t_user
 -
  name: password
  type: commons.t_password
 -
  name: service
  type: system.t_service
 -
  name: service_name
  type: dns.t_domain
 -
  name: backend_status
  type: backend.t_status

body: |
    RETURN QUERY
        WITH

        -- DELETE
        d AS (
            DELETE FROM server_access.user AS t
            WHERE
                backend._deleted(t.backend_status) AND
                backend._machine_priviledged_service(t.service, t.service_name)
        ),

        -- UPDATE
        s AS (
            UPDATE server_access.user AS t
                SET backend_status = NULL
            WHERE
                backend._machine_priviledged_service(t.service, t.service_name) AND
                backend._active(t.backend_status)
        )

        -- SELECT
        SELECT
            t.user,
            t.password,
            t.service,
            t.service_name,
            t.backend_status
        FROM server_access.user AS t

        WHERE
            backend._machine_priviledged_service(t.service, t.service_name) AND
            (backend._active(t.backend_status) OR p_include_inactive);
