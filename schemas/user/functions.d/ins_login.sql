---
name: ins_login
description: |
 Try to bind database connection to new user session.

priv_execute: [userlogin]
security_definer: true
owner: system

returns:
 table:
 - name: user
   type: user.t_user

parameters:
 -
   name: p_login
   type: varchar
 -
   name: p_password
   type: commons.t_password_plaintext

variables:
 -
  name: v_login_owner
  type: user.t_user
---

SELECT owner INTO v_login_owner FROM "user"."user" AS t
       WHERE
           p_login IS NOT NULL AND
           t.password IS NOT NULL AND
           p_login IN (owner, contact_email) AND
           commons._passwords_equal(p_password, t.password);

IF v_login_owner IS NOT NULL THEN
   INSERT INTO "user"."session" (owner, act_as) VALUES (v_login_owner, v_login_owner);
   RETURN QUERY SELECT v_login_owner;
ELSE
   RAISE 'Carnivora: invalid user login'
    USING DETAIL = '$carnivora:user:login_invalid$';
END IF;

