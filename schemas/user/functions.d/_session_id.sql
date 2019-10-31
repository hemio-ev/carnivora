---
name: _session_id
description: |
 Gives an id for the database connection that is unique over all database connections.
 It is used to identify user logins.

 Not sure if this stays unique with distributed infrastructure!

returns: varchar
---

RETURN pg_backend_pid()::varchar;
