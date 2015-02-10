name: _active
description: Is not 'del'

returns: boolean

parameters:
 -
  name: backend_status
  type: backend.t_status

body: |
    RETURN backend_status <> 'del';