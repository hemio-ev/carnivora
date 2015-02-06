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
   type: varchar(255)

body: |
 IF
    (SELECT TRUE FROM "user"."user"
        WHERE name = p_name AND password = p_password AND login)
 THEN
    INSERT INTO "user"."session" (owner) VALUES (p_name);
    RETURN TRUE;
 ELSE
    RAISE 'Carnivora: invalid user login'
     USING DETAIL = '$CARNIVORA:LOGIN_INVALID$';
    RETURN FALSE;
 END IF;

