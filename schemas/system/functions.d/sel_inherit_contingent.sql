---
name: sel_inherit_contingent
description: |
 Select inherit contingent

templates:
 - user.userlogin

returns: TABLE
returns_columns:
 -
  name: owner
  type: user.t_user
 -
  name: donor
  type: user.t_user
 -
  name: priority
  type: int
---

RETURN QUERY
    SELECT t.owner, t.donor, t.priority
    FROM system.inherit_contingent AS t
    ORDER BY t.owner, t.priority;
