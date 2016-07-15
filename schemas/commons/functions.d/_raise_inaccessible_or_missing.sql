---
name: _raise_inaccessible_or_missing
description: |
 Raised whenever a operation on an object failes because it is not owned by
 the user or it is not found.

returns: void

parameters:
 -
  name: p_raise
  description: Controls if the exception is raised
  type: boolean
  default: "FALSE"
---

IF NOT COALESCE(p_raise, FALSE) THEN
    RAISE 'Object inaccessible or missing'
        USING DETAIL = '$carnivora:commons:inaccessible_or_missing$';
END IF;
