---
name: _login_machine
description: |
 Shows machine for the current backend login.

returns: dns.t_hostname
---

RETURN (SELECT machine FROM backend._get_login());

