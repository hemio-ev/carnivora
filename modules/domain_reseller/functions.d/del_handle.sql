name: del_handle
description: Delete Handle

templates:
 - user.userlogin

returns: void

parameters:
 -
  name: p_alias
  type: varchar

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
                owner = v_owner;

            PERFORM backend._conditional_notify(
                FOUND, 'domain_reseller', 'example.org'
            );

    END;