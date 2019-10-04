---
name: upd_user
description: change user passwd

returns: void

parameters:
 -
  name: p_password
  type: commons.t_password_plaintext
---

UPDATE "user".user
    SET password = commons._hash_password(p_password)

WHERE
    owner = "user"._login_user();
