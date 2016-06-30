---
name: _domain_order
description: ORDER

templates:
 - commons.public_util

returns: varchar[]

parameters:
 -
  name: p_domain
  type: dns.t_domain
---

RETURN commons._reverse_array(regexp_split_to_array(p_domain, E'\\.'));
