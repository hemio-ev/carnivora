carnivora
=========

A powerfull backend for web-service management. Written in YamSql.

Documentation for predefined structures can be found here:

http://qua-bla.github.io/carnivora/

![General structure of carnivora project](documentation/structure.png)

# Installation

## HamSql

https://github.com/qua-bla/hamsql

*missing*

## Database
- aptitude install postgresql postgresql-contrib
- aptitude install postgresql-plpython-9.3

> createlang -p <port> plpython2u <database>

# Usage

run `hamsql -e -c"postgres://<user>@localhost/<empty-database>"` to run a full installation
* create tables and functions for modules
* create users and grant defined access

