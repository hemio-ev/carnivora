======================================================================
commons
======================================================================

Carnivora Commons

Usefull templates, functions and domains.

.. contents:: Module Contents
   :local:
   :depth: 2




---------
Functions
---------



.. _FUNCTION-commons._hash_password:

``commons._hash_password``
``````````````````````````````````````````````````````````````````````

SHA512 hash of the password with 16 charcters random salt.
The returned format is the traditional 'crypt(3)' format.

Parameters
 - ``p_password`` :ref:`commons.t_password_plaintext <DOMAIN-commons.t_password_plaintext>`
   
    

Language
 plpython3u


Returns
 commons.t_password



.. code-block:: guess

   import crypt
   
   return crypt.crypt(p_password, crypt.METHOD_SHA512)



.. _FUNCTION-commons._idn:

``commons._idn``
``````````````````````````````````````````````````````````````````````

Converts a unicode domain name to IDN (ASCII)

Currently using IDNA2003.

Parameters
 - ``p_domain`` :ref:`varchar <DOMAIN-varchar>`
   
    

Language
 plpython3u


Returns
 varchar


Execute privilege
 - :ref:`userlogin <ROLE-userlogin>`
 - :ref:`backend <ROLE-backend>`

.. code-block:: guess

   if p_domain is None:
      return None
   
   if p_domain.lower() != p_domain:
       raise plpy.Error('Only lower case IDNs are allowed and can be handled.')
   
   return p_domain.encode('idna').decode()



.. _FUNCTION-commons._jsonb_to_array:

``commons._jsonb_to_array``
``````````````````````````````````````````````````````````````````````

Converts a JSONB array to a PostgreSQL text[] array

Parameters
 - ``p_jsonb`` :ref:`jsonb <DOMAIN-jsonb>`
   
    



Returns
 text[]



.. code-block:: plpgsql

   RETURN ARRAY(SELECT jsonb_array_elements_text(p_jsonb));



.. _FUNCTION-commons._passwords_equal:

``commons._passwords_equal``
``````````````````````````````````````````````````````````````````````

Compares a plaintext password with an arbitrary 'crypt(3)' hashed password.

Uses <https://docs.python.org/3/library/hmac.html>

Parameters
 - ``p_password_plaintext`` :ref:`commons.t_password_plaintext <DOMAIN-commons.t_password_plaintext>`
   
    
 - ``p_password_hash`` :ref:`commons.t_password <DOMAIN-commons.t_password>`
   
    

Language
 plpython3u


Returns
 boolean



.. code-block:: guess

   import crypt
   from hmac import compare_digest as compare_hash
   
   # Giving crypt.crypt the full hash as second argument fixes the use of the
   # right salt and algorithm. Using compare_hash to avoid timing attacks.
   return compare_hash(crypt.crypt(p_password_plaintext, p_password_hash), p_password_hash)



.. _FUNCTION-commons._raise_inaccessible_or_missing:

``commons._raise_inaccessible_or_missing``
``````````````````````````````````````````````````````````````````````

Raised whenever a operation on an object failes because it is not owned by
the user or it is not found.

Parameters
 - ``p_raise`` :ref:`boolean <DOMAIN-boolean>`
   
    Controls if the exception is raised



Returns
 void



.. code-block:: plpgsql

   
   IF NOT COALESCE(p_raise, FALSE) THEN
       RAISE 'Object inaccessible or missing'
           USING DETAIL = '$carnivora:commons:inaccessible_or_missing$';
   END IF;



.. _FUNCTION-commons._reverse_array:

``commons._reverse_array``
``````````````````````````````````````````````````````````````````````

Copied from <https://wiki.postgresql.org/wiki/Array_reverse>

Parameters
 - ``p_array`` :ref:`anyarray <DOMAIN-anyarray>`
   
    



Returns
 anyarray


Execute privilege
 - :ref:`userlogin <ROLE-userlogin>`
 - :ref:`backend <ROLE-backend>`

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



.. _FUNCTION-commons._uuid:

``commons._uuid``
``````````````````````````````````````````````````````````````````````

Returns a random uuid

Parameters
 *None*



Returns
 uuid



.. code-block:: plpgsql

   RETURN uuid_generate_v4();




-------
Domains
-------



.. _DOMAIN-commons.t_port:

``commons.t_port``
```````````````````````````````````````````````````````````````````````

Port

Checks
 - | *invalid_port*
   | ``VALUE >= 0 AND VALUE <= 65535``
   | Only allow port values




.. _DOMAIN-commons.t_password:

``commons.t_password``
```````````````````````````````````````````````````````````````````````

unix hash thingy - todo: propper checking of format

Checks
 - | *crypt(3) password format*
   | ``VALUE ~ '^\$6\$[.\/a-zA-Z0-9]{8,16}\$[.\/a-zA-Z0-9]{86}$'``
   | Only allows SHA512 strings.




.. _DOMAIN-commons.t_password_plaintext:

``commons.t_password_plaintext``
```````````````````````````````````````````````````````````````````````

Password in plaintext

Checks
 - | *minimum password length 8*
   | ``character_length(VALUE) >= 8``
   | Ensures that passwords at least have 8 chars




.. _DOMAIN-commons.t_key:

``commons.t_key``
```````````````````````````````````````````````````````````````````````

Key




.. _DOMAIN-commons.t_hexvarchar:

``commons.t_hexvarchar``
```````````````````````````````````````````````````````````````````````

Varchar only with HEX values

Checks
 - | *invalid characters*
   | ``VALUE ~ '^[0-9a-f]*$'``
   | Only allows numbers and chars a-f for hex representation







