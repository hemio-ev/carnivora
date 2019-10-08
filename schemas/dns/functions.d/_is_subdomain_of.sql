---
name: _is_subdomain_of
description: Checks if `p_subdomain` is a subdomain of `p_domain`

returns: bool

parameters:
 - name: p_subdomain
   type: dns.t_domain
 - name: p_domain
   type: varchar

---

RETURN p_domain = p_subdomain OR
 '.' || p_domain = right(p_subdomain, char_length(p_domain) + 1);
