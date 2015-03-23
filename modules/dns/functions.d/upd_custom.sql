name: upd_custom
description: Ins Custom

templates:
 - user.userlogin

returns: void

parameters:
 -
  name: p_id
  type: uuid
 -
  name: p_rdata
  type: dns.t_rdata
 -
  name: p_ttl
  type: integer

body: |

    UPDATE dns.custom AS t
        SET rdata = p_rdata, ttl = p_ttl
    FROM dns.registered AS s

    WHERE
        s.domain = t.registered AND

        t.id = p_id AND
        s.owner = v_owner;


