---
name: _setup_register_subservice
description: |
 Allows modules to register their services during setup.
 Returns the total number of service names registered
 for this module.

returns: void

parameters:
 -
  name: p_service
  type: commons.t_key
 -
  name: p_subservice
  type: commons.t_key
---

INSERT INTO system.subservice
 (service, subservice)
 SELECT p_service, p_subservice
  WHERE NOT EXISTS (
   SELECT service FROM system.subservice
    WHERE service=p_service AND subservice=p_subservice
   );
