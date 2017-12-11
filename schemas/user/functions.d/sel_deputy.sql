---
name: sel_deputy
description: sel deputy

templates:
 - user.userlogin

returns:
 table:
 -
  name: represented
  type: user.t_user
---

RETURN QUERY
    SELECT t.represented FROM "user".deputy AS t
    WHERE t.deputy = v_login
    ORDER BY t.represented;
