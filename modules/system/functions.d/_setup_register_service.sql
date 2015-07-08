name: _setup_register_service
description: |
 Allows modules to register their services during setup.
 Returns the total number of service names registered
 for this module.

returns: integer

parameters:
 -
  name: p_module
  type: commons.t_key
 -
  name: p_service
  type: commons.t_key

body: |
 INSERT INTO system.service
  (module, service) VALUES (p_module, p_service);
 RETURN (SELECT COUNT(*) FROM system.service AS s WHERE s.module=p_module);
