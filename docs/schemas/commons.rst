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

.. code-block:: plpgsql

   import crypt
   
   return crypt.crypt(p_password, crypt.METHOD_SHA512)


``commons._idn``
``````````````````````````````````````````````````````````````````````

Converts a unicode domain name to IDN (ASCII)

Currently using IDNA2003.

.. code-block:: plpgsql

   if p_domain is None:
      return None
   
   if p_domain.lower() != p_domain:
       raise plpy.Error('Only lower case IDNs are allowed and can be handled.')
   
   return p_domain.encode('idna').decode()


``commons._jsonb_to_array``
``````````````````````````````````````````````````````````````````````

Converts a JSONB array to a PostgreSQL text[] array

.. code-block:: plpgsql

   RETURN ARRAY(SELECT jsonb_array_elements_text(p_jsonb));


``commons._passwords_equal``
``````````````````````````````````````````````````````````````````````

Compares a plaintext password with an arbitrary 'crypt(3)' hashed password.

Uses <https://docs.python.org/3/library/hmac.html>

.. code-block:: plpgsql

   import crypt
   from hmac import compare_digest as compare_hash
   
   # Giving crypt.crypt the full hash as second argument fixes the use of the
   # right salt and algorithm. Using compare_hash to avoid timing attacks.
   return compare_hash(crypt.crypt(p_password_plaintext, p_password_hash), p_password_hash)


``commons._raise_inaccessible_or_missing``
``````````````````````````````````````````````````````````````````````

Raised whenever a operation on an object failes because it is not owned by
the user or it is not found.

.. code-block:: plpgsql

   
   IF NOT COALESCE(p_raise, FALSE) THEN
       RAISE 'Object inaccessible or missing'
           USING DETAIL = '$carnivora:commons:inaccessible_or_missing$';
   END IF;


``commons._reverse_array``
``````````````````````````````````````````````````````````````````````

Copied from <https://wiki.postgresql.org/wiki/Array_reverse>

.. code-block:: plpgsql

   RETURN
   ARRAY(
       SELECT p_array[i]
       FROM generate_series(
           array_lower(p_array,1),
           array_upper(p_array,1)
       ) AS s(i)
       ORDER BY i DESC
   );


``commons._uuid``
``````````````````````````````````````````````````````````````````````

Returns a random uuid

.. code-block:: plpgsql

   RETURN uuid_generate_v4();



