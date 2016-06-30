---
name: _active
description: Is not 'del'

returns: boolean

parameters:
 -
  name: backend_status
  type: backend.t_status
---

RETURN backend_status IS NULL OR (backend_status <> 'del' AND backend_status <> 'old');
