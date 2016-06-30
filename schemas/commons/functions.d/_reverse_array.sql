name: _reverse_array
description: Copied from <https://wiki.postgresql.org/wiki/Array_reverse>

templates:
 - commons.public_util

parameters:
 -
  name: p_array
  type: anyarray

returns: anyarray

body: |
    RETURN
    ARRAY(
        SELECT p_array[i]
        FROM generate_series(
            array_lower(p_array,1),
            array_upper(p_array,1)
        ) AS s(i)
        ORDER BY i DESC
    );
