Carnivora
=========

A powerfull backend for web-service management. Written in YamSql.

A documentation for the predefined structures [is available online](http://qua-bla.github.io/carnivora/). Currently this documentation is outdated.

# Installing Carnivora

## Installing Perequisites

The setup is performed via [HamSql](https://github.com/qua-bla/hamsql). It should be callable as `hamsql` in you shell. We also need the database server:

    apt-get install postgresql postgresql-contrib
    apt-get install postgresql-plpython3-9.4

# Running the Setup

Simplest way to execute the setup on a system with a default PostgreSQL configuration is to run `sudo postgres -c ./setup`.

Instead you may configure the connection settings for the current user in the `~/.pgpass` file which needs restricted permissions `chmod go= ~/.pgpass`. The format is:

    hostname:port:database:username:password

Then run `./setup`.

