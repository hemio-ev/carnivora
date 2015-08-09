name: srv_handle
description: |
 srv handles

templates:
 - backend.backend

returns: SETOF domain_reseller."handle"

body: |
    RETURN QUERY
    SELECT * FROM domain_reseller."handle" AS t
    WHERE backend._machine_priviledged_service('domain_reseller', t.service_entity_name);
