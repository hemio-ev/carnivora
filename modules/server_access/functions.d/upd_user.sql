name: upd_user
description: passwd user

templates:
 - user.userlogin

returns: void

parameters:
 -
  name: p_user
  type: server_access.t_user
 -
  name: p_service_entity_name
  type: dns.t_domain
 -
  name: p_password
  type: commons.t_password_plaintext
  default: "NULL"

variables:
 -
  name: v_password
  type: commons.t_password
  default: "NULL"

body: |
    IF p_password IS NOT NULL THEN
        v_password := commons._hash_password(p_password);
    END IF;

    UPDATE server_access.user
    SET
        password = v_password,
        backend_status = 'upd'
    WHERE
        "user" = p_user AND
        service_entity_name = p_service_entity_name;

    PERFORM backend._conditional_notify_service_entity_name(
        FOUND, 'server_access', p_service_entity_name
    );
