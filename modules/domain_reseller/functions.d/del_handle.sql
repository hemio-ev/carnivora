name: del_handle
description: Deletes handle

templates:
 - user.userlogin

returns: void

parameters:
 -
  name: p_alias
  type: varchar

variables:
 -
  name: v_service_entity_name
  type: dns.t_domain

body: |

    BEGIN
        -- perform DELETE to trigger potential foreign key errors
        DELETE FROM domain_reseller.handle
        WHERE
            alias = p_alias AND
            owner = v_owner;

        -- if not failed yet, emulate rollback of DELETE
        RAISE transaction_rollback;
    EXCEPTION
        WHEN transaction_rollback THEN
            UPDATE domain_reseller.handle
                   SET backend_status = 'del'
            WHERE
                alias = p_alias AND
                owner = v_owner
            RETURNING service_entity_name INTO v_service_entity_name;

            PERFORM backend._conditional_notify_service_entity_name(
                FOUND, v_service_entity_name, 'domain_reseller', 'handle'
            );

    END;