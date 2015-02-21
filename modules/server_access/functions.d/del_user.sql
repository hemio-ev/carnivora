name: del_user
description: delete

templates:
 - user.userlogin

returns: void

parameters:
 -
  name: p_user
  type: varchar
 -
  name: p_service_name
  type: system.t_service

body: |
    WITH
    d AS (DELETE FROM server_access.user
    WHERE
        "user" = p_user AND
        service_name = p_service_name AND
        owner = v_owner)
    UPDATE server_access.user
        SET backend_status = 'del'
    WHERE
        "user" = p_user AND
        service_name = p_service_name AND
        owner = v_owner;
