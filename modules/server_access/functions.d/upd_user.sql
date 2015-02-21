name: upd_user
description: passwd user

templates:
 - user.userlogin

returns: void

parameters:
 -
  name: p_user
  type: varchar
 -
  name: p_service_name
  type: dns.t_domain
 -
  name: p_password
  type: commons.t_password_plaintext
  default: "NULL"

variables:
 -
  name: v_password
  type: commons.t_password

body: |
    IF p_password IS NULL THEN
        v_password := NULL;
    ELSE
        v_password := commons._hash_password(p_password);
    END IF;

    UPDATE server_access.user
    SET
        password = v_password,
        backend_status = 'upd'
    WHERE
        "user" = p_user AND
        service_name = p_service_name;

    IF NOT FOUND THEN
        PERFORM commons._raise_inaccessible_or_missing();
    END IF;