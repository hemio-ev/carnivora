name: del_custom
description: Delete Custom

templates:
 - user.userlogin

parameters:
 -
  name: p_id
  type: uuid

returns: void

body: |

            UPDATE dns.custom AS t
                   SET backend_status = 'del'
            FROM dns.registered AS s
            WHERE
                s.domain = t.registered AND

                t.id = p_id AND
                s.owner = v_owner;

            PERFORM backend._conditional_notify_service_name(
                FOUND, 'dns', 'example.com'
            );
