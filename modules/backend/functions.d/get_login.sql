name: get_login
description: |
 Shows informations for the current backend login.
 Throws an error if the current user is not a grantee
 for a machine.

return: TABLE
return_columns:
 -
  name: machine
  type: dns.domain_name

body: |
 IF (SELECT TRUE FROM "backend"."auth"
    WHERE "role"=session_user)
 THEN
    RETURN QUERY SELECT backend.auth.machine FROM backend.auth
        WHERE "role"=session_user;
 ELSE
    RAISE 'Connected role `%` is not a grantee for a machine.', session_user;
 END IF;

