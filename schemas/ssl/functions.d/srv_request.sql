---
name: srv_acme_request
description: |
 Open certificate requests
 
 .. todo :: use backend template for backend auth

returns: TABLE
returns_columns:
 -
  name: id
  type: uuid
 -
  name: request
  type: ssl.t_request
 -
  name: ca_name
  type: dns.t_domain
---

RETURN QUERY
  SELECT c.id, c.request, d.ca_name
  FROM ssl.cert AS c
  JOIN ssl.demand AS d ON d.id = c.demand_id
  WHERE
    c.cert IS NULL AND c.request IS NOT NULL AND
    d.ca_type = 'ssl' AND d.ca_system = 'acme';

