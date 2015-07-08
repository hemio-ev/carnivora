name: del_service
description: deletes all service entries of a specific domain

templates:
 - user.userlogin

parameters:
 -
  name: p_domain
  type: dns.t_domain
 -
  name: p_service
  type: commons.t_key

returns: void

body: |

    BEGIN
        -- perform DELETE to trigger potential foreign key errors
        DELETE FROM dns.service AS t
        USING dns.registered AS s
        WHERE
            s.domain = t.registered AND

            t.domain = p_domain AND
            t.service = p_service AND
            s.owner = v_owner;

        -- if not failed yet, emulate rollback of DELETE
        RAISE transaction_rollback;
    EXCEPTION
        WHEN transaction_rollback THEN
            UPDATE dns.service AS t
                   SET backend_status = 'del'
            FROM dns.registered AS s
            WHERE
                s.domain = t.registered AND

                t.domain = p_domain AND
                t.service = p_service AND
                s.owner = v_owner;

            PERFORM backend._conditional_notify(
                FOUND, 'dns', p_domain
            );

    END;
