name: session_id
description: |
 Gives an id for the database connection that is unique over all database connections.
 It is used to identify user logins.

return: varchar

body: RETURN (SELECT backend_start || '.' || pid FROM pg_stat_activity);
