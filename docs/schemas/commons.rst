======================================================================
commons
======================================================================

Carnivora Commons

Usefull templates, functions and domains.

.. contents:: Module Contents
   :local:
   :depth: 2



Functions
---------


``commons._hash_password``
``````````````````````````````````````````````````````````````````````

SHA512 hash of the password with 16 charcters random salt.
The returned format is the traditional 'crypt(3)' format.


``commons._idn``
``````````````````````````````````````````````````````````````````````

Converts a unicode domain name to IDN (ASCII)

Currently using IDNA2003.


``commons._jsonb_to_array``
``````````````````````````````````````````````````````````````````````

Converts a JSONB array to a PostgreSQL text[] array


``commons._passwords_equal``
``````````````````````````````````````````````````````````````````````

Compares a plaintext password with an arbitrary 'crypt(3)' hashed password.

Uses <https://docs.python.org/3/library/hmac.html>


``commons._raise_inaccessible_or_missing``
``````````````````````````````````````````````````````````````````````

Raised whenever a operation on an object failes because it is not owned by
the user or it is not found.


``commons._reverse_array``
``````````````````````````````````````````````````````````````````````

Copied from <https://wiki.postgresql.org/wiki/Array_reverse>


``commons._uuid``
``````````````````````````````````````````````````````````````````````

Returns a random uuid



