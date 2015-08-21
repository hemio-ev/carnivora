Carnivora
=========

A powerfull backend for web-service management. Written in YamSql.

A documentation for the predefined structures is available in
[doc/doc.md](doc/doc.md).

Installing Carnivora
====================

Installing Perequisites
-----------------------

The setup is performed via [HamSql](https://github.com/qua-bla/hamsql).
It should be callable as `hamsql` in you shell. We also need the
database server:

    apt-get install postgresql postgresql-contrib
    apt-get install postgresql-plpython3-9.4

Configuration
-------------

You can configure accounts that can connect to the database via
`/etc/carnivora/_postgresql_user/module.yaml`. The accounts generated
via this config have the names `carnivora_edentata` and
`carnivora_machine_example`.

    name: _postgresql_user
    description: PostgreSQL users and their priviledges

    roles:
     -
      name: edentata
      login: true
      description: Account for edentata web frontend
      member_in:
       - userlogin

     -
      name: machine_example
      description: Account for machine example
      login: true
      member_in:
       - backend

Running the Setup
-----------------

### Default Method

Simplest way to execute the setup on a system with a default PostgreSQL
configuration is to run

    su postgres -c "hamsql install -d -s examples/setup.yaml -c postgres://postgres@/carnivora"

### Advanced Method

Instead you may configure the connection settings for the current user
in the `~/.pgpass` file which needs restricted permissions
`chmod go= ~/.pgpass`. The format is:

    hostname:port:database:username:password

Then run `./setup`.

