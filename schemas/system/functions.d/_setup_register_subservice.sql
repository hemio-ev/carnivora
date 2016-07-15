---
name: _setup_register_subservice
description: |
 Allows modules to register their services during setup.
 Returns the total number of service names registered
 for this module.

returns: integer

parameters:
 -
  name: p_service
  type: commons.t_key
 -
  name: p_subservice
  type: commons.t_key
---

INSERT INTO system.subservice
 (service, subservice) VALUES (p_service, p_subservice);
RETURN (SELECT COUNT(*) FROM system.subservice AS s WHERE s.service=p_service);
