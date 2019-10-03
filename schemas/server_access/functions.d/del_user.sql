---
name: del_user
description: delete

templates:
 - user.userlogin

returns: void

parameters:
 -
  name: p_user
  type: server_access.t_user
 -
  name: p_service_entity_name
  type: dns.t_hostname

variables:
 -
  name: v_subservice
  type: commons.t_key
---

BEGIN
    -- perform DELETE to trigger potential foreign key errors
    DELETE FROM server_access.user
    WHERE
        "user" = p_user AND
        service_entity_name = p_service_entity_name AND
        owner = v_owner;

    -- if not failed yet, emulate rollback of DELETE
    RAISE transaction_rollback;
EXCEPTION
    WHEN transaction_rollback THEN
        UPDATE server_access.user
            SET backend_status = 'del'
        WHERE
            "user" = p_user AND
            service_entity_name = p_service_entity_name AND
            owner = v_owner
        RETURNING subservice INTO v_subservice;

        PERFORM backend._conditional_notify_service_entity_name(
             FOUND,  p_service_entity_name, 'server_access', v_subservice
         );
END;

