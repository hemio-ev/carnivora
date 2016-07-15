---
name: _passwords_equal
description: |
 Compares a plaintext password with an arbitrary 'crypt(3)' hashed password.

 Uses <https://docs.python.org/3/library/hmac.html>

language: plpython3u

returns: boolean

parameters:
 -
  name: p_password_plaintext
  type: commons.t_password_plaintext
 -
  name: p_password_hash
  type: commons.t_password
---

import crypt
from hmac import compare_digest as compare_hash

# Giving crypt.crypt the full hash as second argument fixes the use of the
# right salt and algorithm. Using compare_hash to avoid timing attacks.
return compare_hash(crypt.crypt(p_password_plaintext, p_password_hash), p_password_hash)
