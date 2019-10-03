---
name: _login_user
description: |
 Shows informations for the current user login.
 Throws an exception if no login is associated to the
 current database connection.

returns: user.t_user
---

RETURN (SELECT owner FROM "user"._get_login());
