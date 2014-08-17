name: get_login
description: |
 Shows informations for the current user login.
 Throws an exception if no login is associated to the
 current database connection.

return: TABLE
return_columns:
 -
  name: name
  type: varchar

body: |
 IF (SELECT TRUE FROM "user"."session"
    WHERE "id"="user".session_id())
 THEN
    RETURN QUERY SELECT "owner" FROM "user"."session"
        WHERE "id"="user".session_id();
 ELSE
    RAISE 'Database connection is not associated to a user login.'
        USING HINT := 'Use user.login(...) first.';
 END IF;

