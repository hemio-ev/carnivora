name: login
description: |
 Try to bind database connection to new user session.
 Returns valid if sueccessfull, invalid otherwise.

priv_execute: [userlogin]
return: varchar

parameters:
 -
   name: p_name
   type: varchar(50)
 -
   name: p_password
   type: varchar(255)

body: |
 IF
    (SELECT TRUE FROM "user"."user"
        WHERE name = p_name AND password = p_password AND login)
 THEN
    INSERT INTO "user"."session" (owner) VALUES (p_name);
    RETURN 'valid';
 ELSE
    RETURN 'invalid';
 END IF;

