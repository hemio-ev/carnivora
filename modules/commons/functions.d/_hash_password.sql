name: _hash_password
description: |
 SHA512 hash of the password with 16 charcters random salt.
 The returned format is the traditional 'crypt(3)' format.

language: plpython3u

returns: commons.t_password

parameters:
 -
  name: p_password
  type: commons.t_password_plaintext

body: |
 import crypt

 return crypt.crypt(p_password, crypt.METHOD_SHA512)
