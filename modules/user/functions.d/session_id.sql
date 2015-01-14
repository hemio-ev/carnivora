name: session_id
description: |
 Gives an id for the database connection that is unique over all database connections.
 It is used to identify user logins.

return: varchar

body: |
 RETURN session_user || '.' || pg_backend_pid();
