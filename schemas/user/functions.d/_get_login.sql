---
name: _get_login
description: |
 Shows informations for the current user login.
 Throws an exception if no login is associated to the
 current database connection.

returns:
 table:
 -
  name: owner
  type: user.t_user
 -
  name: act_as
  type: user.t_user
---

IF (SELECT TRUE FROM "user"."session"
   WHERE "id"="user"._session_id())
THEN
   RETURN QUERY SELECT t.owner, t.act_as FROM "user"."session" AS t
       WHERE "id"="user"._session_id();
ELSE
   RAISE 'Database connection is not associated to a user login.'
       USING HINT := 'Use user.login(...) first.';
END IF;
