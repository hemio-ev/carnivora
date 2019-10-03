---
name: sel_deputy
description: sel deputy

templates:
 - user.userlogin

returns: TABLE
returns_columns:
 -
  name: represented
  type: user.t_user
---

RETURN QUERY
    SELECT t.represented FROM "user".deputy AS t
    WHERE t.deputy = "user"._login_user()
    ORDER BY t.represented;
