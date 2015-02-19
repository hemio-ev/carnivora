name: _deleted
description: Is 'del'

returns: boolean

parameters:
 -
  name: backend_status
  type: backend.t_status

body: |
    RETURN backend_status IS NOT NULL AND backend_status = 'del';
