name: ins_login
description: |
 Try to bind database connection to new user session.
 Returns valid if sueccessfull, invalid otherwise.

priv_execute: [userlogin]
returns: boolean

parameters:
 -
   name: p_name
   type: commons.t_key
 -
   name: p_password
   type: commons.t_password_plaintext

body: |
 IF
    (SELECT TRUE FROM "user"."user" AS t
        WHERE
            name = p_name AND
            commons._passwords_equal(p_password, t.password) AND
            t.login
    )
 THEN
    INSERT INTO "user"."session" (owner) VALUES (p_name);
    RETURN TRUE;
 ELSE
    RAISE 'Carnivora: invalid user login'
     USING DETAIL = '$carnivora:user:login_invalid$';
    RETURN FALSE;
 END IF;

