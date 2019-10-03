---
name: _reverse_array
description: Copied from <https://wiki.postgresql.org/wiki/Array_reverse>

templates:
 - commons.public_util

parameters:
 -
  name: p_array
  type: anyarray

returns: anyarray
language: sql
---

SELECT
    ARRAY(
        SELECT $1[i]
        FROM generate_subscripts($1,1) AS s(i)
        ORDER BY i DESC
    );
