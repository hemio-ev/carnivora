---
name: ins_deputy
description: Act as deputy

templates:
 - user.userlogin

returns: void

parameters:
 -
  name: p_act_as
  type: user.t_user
---

UPDATE "user".session AS t
    SET act_as = p_act_as
    FROM "user".deputy AS s
    WHERE
        s.deputy = t.owner AND
        s.represented = p_act_as AND
        t.id = "user"._session_id() AND
        t.owner = v_owner;

IF NOT FOUND THEN
    RAISE 'Acting as deputy failed.'
        USING DETAIL := '$carnivora:user:deputy_failed$';
END IF;
