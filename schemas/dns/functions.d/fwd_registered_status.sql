---
name: fwd_registered_status
description: Update status

templates:
 - backend.backend

returns: void

parameters:
 -
  name: p_domain
  type: dns.t_hostname
 -
  name: p_backend_status
  type: backend.t_status
---

UPDATE dns.registered
SET
    backend_status = p_backend_status
WHERE domain = p_domain;
