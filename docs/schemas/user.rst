======================================================================
user
======================================================================

Carnivora Users: Users own things objects in the DB,
and they can login into frontends (edentata)

.. contents:: Module Contents
   :local:
   :depth: 2


Tables
----------------------------------------------------------------------


.. _TBL-user.deputy:

``user.deputy``
``````````````````````````````````````````````````````````````````````

Deputies for users

Primary key:

- deputy
- represented


.. BEGIN FKs


.. END FKs


Columns
''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''


.. _COLUMN-user.deputy.deputy:

- ``deputy`` *user.t_user*
    Deputy


  - References: :ref:`user.user.owner <COLUMN-user.user.owner>`

  - On Delete: CASCADE



.. _COLUMN-user.deputy.represented:

- ``represented`` *user.t_user*
    User for which the deputy can act


  - References: :ref:`user.user.owner <COLUMN-user.user.owner>`

  - On Delete: CASCADE




.. _TBL-user.session:

``user.session``
``````````````````````````````````````````````````````````````````````

User login sessions

Primary key:

- id


.. BEGIN FKs


.. END FKs


Columns
''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''


.. _COLUMN-user.session.id:

- ``id`` *varchar*
    Session id

  - Default: :python:`"user"._session_id()`





.. _COLUMN-user.session.owner:

- ``owner`` *user.t_user*
    for ownage


  - References: :ref:`user.user.owner <COLUMN-user.user.owner>`

  - On Delete: CASCADE



.. _COLUMN-user.session.act_as:

- ``act_as`` *user.t_user*
    Act as






.. _COLUMN-user.session.started:

- ``started`` *timestamp*
    Session started at this time

  - Default: :python:`CURRENT_TIMESTAMP`






.. _TBL-user.user:

``user.user``
``````````````````````````````````````````````````````````````````````

User

Primary key:

- owner


.. BEGIN FKs


.. END FKs


Columns
''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''


.. _COLUMN-user.user.option:

- ``option`` *jsonb*
    Free options in JSON format

  - Default: :python:`'{}'`





.. _COLUMN-user.user.owner:

- ``owner`` *user.t_user*
    User name, login name






.. _COLUMN-user.user.password:

- ``password`` *NULL* | *commons.t_password*
    Unix shadow crypt format, NULL value disables login






.. _COLUMN-user.user.contact_email:

- ``contact_email`` *NULL* | *email.t_address*
    Optional contact email address, can be used as login name









Functions
---------


``user._get_login``
``````````````````````````````````````````````````````````````````````

Shows informations for the current user login.
Throws an exception if no login is associated to the
current database connection.

.. code-block:: plpgsql

   IF (SELECT TRUE FROM "user"."session"
      WHERE "id"="user"._session_id())
   THEN
      RETURN QUERY SELECT t.owner, t.act_as FROM "user"."session" AS t
          WHERE "id"="user"._session_id();
   ELSE
      RAISE 'Database connection is not associated to a user login.'
          USING HINT := 'Use user.login(...) first.';
   END IF;


``user._session_id``
``````````````````````````````````````````````````````````````````````

Gives an id for the database connection that is unique over all database connections.
It is used to identify user logins.

Not sure if this stays unique with distributed infrastructure!

.. code-block:: plpgsql

   
   RETURN
    session_user || '.' ||
    pg_backend_pid() || '.' ||
    COALESCE((SELECT backend_start FROM pg_stat_get_activity(pg_backend_pid()))::varchar, 'xxx') || '.' ||
    pg_conf_load_time();


``user.ins_deputy``
``````````````````````````````````````````````````````````````````````

Act as deputy

.. code-block:: plpgsql

   -- begin userlogin prelude
   v_login := (SELECT t.owner FROM "user"._get_login() AS t);
   v_owner := (SELECT t.act_as FROM "user"._get_login() AS t);
   -- end userlogin prelude
   
   UPDATE "user".session AS t
       SET act_as = p_act_as
       FROM "user".deputy AS s
       WHERE
           s.deputy = t.owner AND
           s.represented = p_act_as AND
           t.id = "user"._session_id();
   
   IF NOT FOUND THEN
       RAISE 'Acting as deputy failed.'
           USING DETAIL := '$carnivora:user:deputy_failed$';
   END IF;


``user.ins_login``
``````````````````````````````````````````````````````````````````````

Try to bind database connection to new user session.

.. code-block:: plpgsql

   
   SELECT owner INTO v_login_owner FROM "user"."user" AS t
          WHERE
              p_login IS NOT NULL AND
              t.password IS NOT NULL AND
              p_login IN (owner, contact_email) AND
              commons._passwords_equal(p_password, t.password);
   
   IF v_login_owner IS NOT NULL THEN
      INSERT INTO "user"."session" (owner, act_as) VALUES (v_login_owner, v_login_owner);
      RETURN QUERY SELECT v_login_owner;
   ELSE
      RAISE 'Carnivora: invalid user login'
       USING DETAIL = '$carnivora:user:login_invalid$';
   END IF;


``user.sel_deputy``
``````````````````````````````````````````````````````````````````````

sel deputy

.. code-block:: plpgsql

   -- begin userlogin prelude
   v_login := (SELECT t.owner FROM "user"._get_login() AS t);
   v_owner := (SELECT t.act_as FROM "user"._get_login() AS t);
   -- end userlogin prelude
   
   RETURN QUERY
       SELECT t.represented FROM "user".deputy AS t
       WHERE t.deputy = v_login;


``user.upd_user``
``````````````````````````````````````````````````````````````````````

change user passwd

.. code-block:: plpgsql

   -- begin userlogin prelude
   v_login := (SELECT t.owner FROM "user"._get_login() AS t);
   v_owner := (SELECT t.act_as FROM "user"._get_login() AS t);
   -- end userlogin prelude
   
   UPDATE "user".user
       SET password = commons._hash_password(p_password)
   
   WHERE
       owner = v_login;



