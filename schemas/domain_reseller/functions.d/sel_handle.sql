---
name: sel_handle
description: Selects handles

templates:
 - user.userlogin

returns: SETOF domain_reseller."handle"

parameters:
 -
  name: p_hide_foreign
  type: bool
  default: 'FALSE'
---

RETURN QUERY
    SELECT * FROM domain_reseller.handle
WHERE
    owner=v_owner OR (owner=v_login AND NOT p_hide_foreign)
ORDER BY backend_status, fname, lname, alias;
