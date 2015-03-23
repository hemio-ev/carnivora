name: sel_handle
description: Select Handle

templates:
 - user.userlogin

returns: SETOF domain_reseller."handle"

body: |

    RETURN QUERY SELECT * FROM domain_reseller.handle;
