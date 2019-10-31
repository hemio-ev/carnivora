user
======================================================================

Carnivora Users: Users own things objects in the DB,
and they can login into frontends (edentata)

.. contents:: Schema Contents
   :local:
   :depth: 2



Tables
------


.. _TABLE-user.deputy:

``user.deputy``
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Deputies for users

Primary key
 - deputy
 - represented


.. BEGIN FKs


.. END FKs


Columns
 - .. _COLUMN-user.deputy.deputy:
   
   ``deputy`` :ref:`user.t_user <DOMAIN-user.t_user>`
     Deputy


   References :ref:`user.user.owner <COLUMN-user.user.owner>`

   On Delete: CASCADE

   On Update: CASCADE

 - .. _COLUMN-user.deputy.represented:
   
   ``represented`` :ref:`user.t_user <DOMAIN-user.t_user>`
     User for which the deputy can act


   References :ref:`user.user.owner <COLUMN-user.user.owner>`

   On Delete: CASCADE

   On Update: CASCADE



.. _TABLE-user.session:

``user.session``
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

User login sessions

Primary key
 - id


.. BEGIN FKs


.. END FKs


Columns
 - .. _COLUMN-user.session.owner:
   
   ``owner`` :ref:`user.t_user <DOMAIN-user.t_user>`
     Owner


   References :ref:`user.user.owner <COLUMN-user.user.owner>`

   On Delete: CASCADE

   On Update: CASCADE

 - .. _COLUMN-user.session.id:
   
   ``id`` :ref:`varchar <DOMAIN-varchar>`
     Session id

   Default
    .. code-block:: sql

     "user"._session_id()




 - .. _COLUMN-user.session.act_as:
   
   ``act_as`` :ref:`user.t_user <DOMAIN-user.t_user>`
     Act as





 - .. _COLUMN-user.session.started:
   
   ``started`` :ref:`timestamp <DOMAIN-timestamp>`
     Session started at this time

   Default
    .. code-block:: sql

     CURRENT_TIMESTAMP






.. _TABLE-user.user:

``user.user``
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Users

Users with password set to ``NULL`` can be used as groups.

Primary key
 - owner


.. BEGIN FKs


.. END FKs


Columns
 - .. _COLUMN-user.user.option:
   
   ``option`` :ref:`jsonb <DOMAIN-jsonb>`
     Free options in JSON format

   Default
    .. code-block:: sql

     '{}'




 - .. _COLUMN-user.user.owner:
   
   ``owner`` :ref:`user.t_user <DOMAIN-user.t_user>`
     User name, login name





 - .. _COLUMN-user.user.password:
   
   ``password`` *NULL* | :ref:`commons.t_password <DOMAIN-commons.t_password>`
     Unix shadow crypt format, NULL value disables login





 - .. _COLUMN-user.user.contact_email:
   
   ``contact_email`` *NULL* | :ref:`email.t_address <DOMAIN-email.t_address>`
     Optional contact email address, can be used as login name










Functions
---------



.. _FUNCTION-user._get_login:

``user._get_login``
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Shows informations for the current user login.
Throws an exception if no login is associated to the
current database connection.

Parameters
 *None*



Returns
 TABLE

Returned columns
 - ``owner`` :ref:`user.t_user <DOMAIN-user.t_user>`
    
 - ``act_as`` :ref:`user.t_user <DOMAIN-user.t_user>`
    


.. code-block:: plpgsql

   
   IF (SELECT TRUE FROM "user"."session"
      WHERE "id"="user"._session_id())
   THEN
      RETURN QUERY SELECT t.owner, t.act_as FROM "user"."session" AS t
          WHERE "id"="user"._session_id();
   ELSE
      RAISE 'Database connection is not associated to a user login.'
          USING HINT := 'Use user.ins_login(...) first.';
   END IF;



.. _FUNCTION-user._login_user:

``user._login_user``
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Shows informations for the current user login.
Throws an exception if no login is associated to the
current database connection.

Parameters
 *None*



Returns
 user.t_user



.. code-block:: plpgsql

   
   RETURN (SELECT owner FROM "user"._get_login());



.. _FUNCTION-user._session_id:

``user._session_id``
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Gives an id for the database connection that is unique over all database connections.
It is used to identify user logins.

Not sure if this stays unique with distributed infrastructure!

Parameters
 *None*



Returns
 varchar



.. code-block:: plpgsql

   
   RETURN pg_backend_pid()::varchar;



.. _FUNCTION-user.del_login:

``user.del_login``
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Try to logout

Parameters
 *None*



Returns
 void


Execute privilege
 - :ref:`userlogin <ROLE-userlogin>`

.. code-block:: plpgsql

   
   DELETE FROM "user".session WHERE id = "user"._session_id();
   
   IF NOT FOUND THEN
      RAISE 'Carnivora: user logout failed, not logged in'
       USING DETAIL = '$carnivora:user:logout_failed$';
   END IF;



.. _FUNCTION-user.ins_deputy:

``user.ins_deputy``
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Act as deputy

Parameters
 - ``p_act_as`` :ref:`user.t_user <DOMAIN-user.t_user>`
   
    


Variables defined for body
 - ``v_owner`` :ref:`user.t_user <DOMAIN-user.t_user>`
   
   

Returns
 void


Execute privilege
 - :ref:`userlogin <ROLE-userlogin>`

.. code-block:: plpgsql

   -- begin userlogin prelude
   v_owner := (SELECT t.act_as FROM "user"._get_login() AS t);
   -- end userlogin prelude
   
   
   UPDATE "user".session AS t
       SET act_as = p_act_as
       FROM "user".deputy AS s
       WHERE
           s.deputy = t.owner AND
           s.represented = p_act_as AND
           t.id = "user"._session_id() AND
           t.owner = v_owner;
   
   IF NOT FOUND THEN
       RAISE 'Acting as deputy failed.'
           USING DETAIL := '$carnivora:user:deputy_failed$';
   END IF;



.. _FUNCTION-user.ins_login:

``user.ins_login``
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Try to bind database connection to new user session.

Parameters
 - ``p_login`` :ref:`varchar <DOMAIN-varchar>`
   
    
 - ``p_password`` :ref:`commons.t_password_plaintext <DOMAIN-commons.t_password_plaintext>`
   
    


Variables defined for body
 - ``v_login_owner`` :ref:`user.t_user <DOMAIN-user.t_user>`
   
   

Returns
 TABLE

Returned columns
 - ``user`` :ref:`user.t_user <DOMAIN-user.t_user>`
    

Execute privilege
 - :ref:`userlogin <ROLE-userlogin>`

.. code-block:: plpgsql

   
   SELECT owner INTO v_login_owner FROM "user"."user" AS t
          WHERE
              p_login IS NOT NULL AND
              t.password IS NOT NULL AND
              lower(p_login) IN (owner, contact_email) AND
              commons._passwords_equal(p_password, t.password);
   
   IF v_login_owner IS NOT NULL THEN
      INSERT INTO "user"."session" (owner, act_as) VALUES (v_login_owner, v_login_owner);
      RETURN QUERY SELECT v_login_owner;
   ELSE
      RAISE 'Carnivora: invalid user login'
       USING DETAIL = '$carnivora:user:login_invalid$';
   END IF;



.. _FUNCTION-user.sel_deputy:

``user.sel_deputy``
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

sel deputy

Parameters
 *None*


Variables defined for body
 - ``v_owner`` :ref:`user.t_user <DOMAIN-user.t_user>`
   
   

Returns
 TABLE

Returned columns
 - ``represented`` :ref:`user.t_user <DOMAIN-user.t_user>`
    

Execute privilege
 - :ref:`userlogin <ROLE-userlogin>`

.. code-block:: plpgsql

   -- begin userlogin prelude
   v_owner := (SELECT t.act_as FROM "user"._get_login() AS t);
   -- end userlogin prelude
   
   
   RETURN QUERY
       SELECT t.represented FROM "user".deputy AS t
       WHERE t.deputy = "user"._login_user()
       ORDER BY t.represented;



.. _FUNCTION-user.upd_user:

``user.upd_user``
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

change user passwd

Parameters
 - ``p_password`` :ref:`commons.t_password_plaintext <DOMAIN-commons.t_password_plaintext>`
   
    


Variables defined for body
 - ``v_owner`` :ref:`user.t_user <DOMAIN-user.t_user>`
   
   

Returns
 void


Execute privilege
 - :ref:`userlogin <ROLE-userlogin>`

.. code-block:: plpgsql

   -- begin userlogin prelude
   v_owner := (SELECT t.act_as FROM "user"._get_login() AS t);
   -- end userlogin prelude
   
   
   UPDATE "user".user
       SET password = commons._hash_password(p_password)
   
   WHERE
       owner = "user"._login_user();





Domains
-------



.. _DOMAIN-user.t_user:

``user.t_user``
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Username

Checks
 - ``valid_characters``
    Only lower-case letters, numbers and .-_

   .. code-block:: sql

    VALUE ~ '^[a-z0-9.\-_]+$'





Roles
-----


.. _ROLE-userlogin:

``userlogin``
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Do user actions via this group

Login
 *Disabled*


.. _ROLE-system:

``system``
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Highly priviledged user

Login
 *Disabled*




.. This file was generated via HamSql

