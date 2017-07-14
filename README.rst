Carnivora
=========

.. image:: https://readthedocs.org/projects/carnivora/badge/?version=stable
  :target: https://carnivora.readthedocs.io/en/stable/
.. image:: https://readthedocs.org/projects/carnivora/badge/?version=latest
  :target: https://carnivora.readthedocs.io/en/latest/

A powerfull backend for web-service management. Written in YamSql.

The documentation can be found online at `carnivora.readthedocs.io <http://carnivora.readthedocs.io>`__
or as sphinx source in ``docs/``.

Client Software
---------------

`Canini <https://git.hemio.de/hemio/canini>`__
 Full privileged superadmin CLI. Supports adding additional modules via config. Written in Python 3.

`Edentata <https://git.hemio.de/hemio/edentata>`__
 An unprivileged webinterface without superadmin capabilities. Targeting end-users and focused on usability. Supports adding additional modules via config. Written in PHP 5.

`Genconfig <https://git.hemio.de/hemio/genconfig>`__
 A generic config producer which can use carnivora as backend. Written in Python.

`PgListend <https://git.hemio.de/hemio/pglistend>`__
 Daemon that executes tasks on PostgreSQL push signals. Designed to call genconfig on database updates. Written in Python 3.

`LibInternetX <https://git.hemio.de/hemio/libinternetx>`__
 PHP library for connecting to the InterNetX domain reseller XML API. Includes CLI coupling to Carnivora. 

Installing Carnivora
--------------------

Perequisites
~~~~~~~~~~~~

The setup is performed via
`HamSql <https://git.hemio.de/hemio/hamsql>`__. It should be callable as
``hamsql`` in your shell.

Install PostgreSQL on Debian 8 (Jessie)

.. code-block:: sh

    apt-get install postgresql postgresql-contrib postgresql-plpython3-9.4

Configuration
~~~~~~~~~~~~~

You can configure accounts that can connect to the database via
``/etc/carnivora/_postgresql_user/module.yaml``. The accounts generated
via this config have the names ``carnivora_edentata`` and
``carnivora_machine_example``.

.. code-block:: yaml

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
~~~~~~~~~~~~~~~~~

Simplest way to execute the setup on a system with a default PostgreSQL
configuration is to run

::

    su postgres -c "hamsql install -s examples/setup.yml -c postgres://postgres@/carnivora"

Supplying the database name (here *carnivora*) via the ``-c`` option is
mandatory. The database will be create if it is not present. Additional
or deviating connection options can be provided.

