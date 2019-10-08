---
name: del_login
description: |
 Try to logout

returns: void

priv_execute: [userlogin]
security_definer: true
owner: system

---

DELETE FROM "user".session WHERE id = "user"._session_id();

IF NOT FOUND THEN
   RAISE 'Carnivora: user logout failed, not logged in'
    USING DETAIL = '$carnivora:user:logout_failed$';
END IF;

