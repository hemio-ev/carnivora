---
name: _setup_register_service
description: |
 Allows modules to register their services during setup.
 Returns the total number of service names registered
 for this module.

returns: void

parameters:
 -
  name: p_module
  type: commons.t_key
 -
  name: p_service
  type: commons.t_key
---

INSERT INTO system.service
 (module, service)
 SELECT p_module, p_service
  WHERE NOT EXISTS (
   SELECT service FROM system.service
    WHERE module=p_module AND service=p_service
   );
