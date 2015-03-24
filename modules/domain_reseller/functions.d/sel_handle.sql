name: sel_handle
description: Select Handle

templates:
 - user.userlogin

returns: SETOF domain_reseller."handle"

body: |

    RETURN QUERY
        SELECT * FROM domain_reseller.handle
    WHERE
        owner=v_owner
    ORDER BY backend_status, fname, lname, alias;
