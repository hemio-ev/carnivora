---
name: srv_request
description: |
 Open certificate requests

returns: TABLE
returns_columns:
 -
  name: id
  type: uuid
 -
  name: request
  type: ssl.t_request
---

RETURN QUERY
  SELECT c.id, c.request
  FROM ssl.cert AS c
  WHERE c.cert IS NULL AND c.request IS NOT NULL;
