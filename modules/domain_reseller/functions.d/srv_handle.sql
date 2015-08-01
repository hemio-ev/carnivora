name: srv_handle
description: srv handles

templates:
 - backend.backend

returns: SETOF domain_reseller."handle"

body: |
    RETURN QUERY
    SELECT * FROM domain_reseller."handle";