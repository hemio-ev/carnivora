name: srv_handle
description: |
 srv handles

templates:
 - backend.backend

returns: SETOF domain_reseller."handle"

body: |
    RETURN QUERY
        WITH

        -- DELETE
        d AS (
            DELETE FROM domain_reseller.handle AS t
            WHERE
                backend._machine_priviledged_service(t.service, t.service_entity_name) AND
                backend._deleted(t.backend_status)
        ),

        -- UPDATE
        s AS (
            UPDATE domain_reseller.handle AS t
                SET backend_status = NULL
            WHERE
                backend._machine_priviledged_service(t.service, t.service_entity_name) AND
                backend._active(t.backend_status)
        )

        SELECT * FROM domain_reseller.handle AS t
        WHERE
            backend._machine_priviledged_service(t.service, t.service_entity_name) AND
            (backend._active(t.backend_status) OR p_include_inactive);
