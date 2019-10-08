---
name: _session_id
description: |
 Gives an id for the database connection that is unique over all database connections.
 It is used to identify user logins.

 Not sure if this stays unique with distributed infrastructure!

returns: varchar
security_definer: false
owner: system
---

RETURN
    pg_backend_pid() || '.' ||
    COALESCE((SELECT backend_start FROM pg_stat_get_activity(pg_backend_pid()))::varchar, 'xxx') || '.' ||
    pg_conf_load_time();
