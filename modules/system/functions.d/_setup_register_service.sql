name: _setup_register_service
description: |
 Allows modules to register their services during setup.
 Returns the total number of service names registered
 for this module.

return: integer

parameters:
 -
  name: p_module
  type: varchar
 -
  name: p_service
  type: varchar

body: |
 INSERT INTO system.service_index
  (module, service) VALUES (p_module, p_service);
 RETURN (SELECT COUNT(*) FROM system.service_index AS s WHERE s.module=p_module);
