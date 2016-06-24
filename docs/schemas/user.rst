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

- ``password`` *NULL | commons.t_password*
    Unix shadow crypt format, NULL value disables login






.. _COLUMN-user.user.contact_email:

- ``contact_email`` *NULL | email.t_address*
    Optional contact email address, can be used as login name









Functions
---------


``user._get_login``
``````````````````````````````````````````````````````````````````````

Shows informations for the current user login.
Throws an exception if no login is associated to the
current database connection.


``user._session_id``
``````````````````````````````````````````````````````````````````````

Gives an id for the database connection that is unique over all database connections.
It is used to identify user logins.

Not sure if this stays unique with distributed infrastructure!


``user.ins_deputy``
``````````````````````````````````````````````````````````````````````

Act as deputy


``user.ins_login``
``````````````````````````````````````````````````````````````````````

Try to bind database connection to new user session.


``user.sel_deputy``
``````````````````````````````````````````````````````````````````````

sel deputy


``user.upd_user``
``````````````````````````````````````````````````````````````````````

change user passwd



