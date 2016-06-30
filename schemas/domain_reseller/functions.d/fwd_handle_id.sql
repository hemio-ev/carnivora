name: fwd_handle_id
description: Insert handle id

templates:
 - backend.backend

returns: void

parameters:
 -
  name: p_alias
  type: varchar
 -
  name: p_id
  type: varchar

body: |

    UPDATE domain_reseller.handle
    SET id = p_id
    WHERE alias = p_alias;
