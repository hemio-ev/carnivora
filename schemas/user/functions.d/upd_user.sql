---
name: upd_user
description: change user passwd

templates:
 - user.userlogin

returns: void

parameters:
 -
  name: p_password
  type: commons.t_password_plaintext
---

UPDATE "user".user
    SET password = commons._hash_password(p_password)

WHERE
    owner = v_login;
