Carnivora
=========

A powerfull backend for web-service management. Written in YamSql.

The documentation can be found online at `carnivora.readthedocs.io <http://carnivora.readthedocs.io>`__
or as sphinx source in ``docs/``.

Installing Carnivora
--------------------

Perequisites
~~~~~~~~~~~~

The setup is performed via
`HamSql <https://github.com/qua-bla/hamsql>`__. It should be callable as
``hamsql`` in your shell.

Install PostgreSQL on Debian 8 (Jessie)

::

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

    su postgres -c "hamsql install -d -s examples/setup.yaml -c postgres://postgres@/carnivora"

Supplying the database name (here carnivora) via the ``-c`` option is
mandatory. The database will be create if it is not present. Additional
or deviating connection options can be provided.

.. toctree::
   :maxdepth: 1
   :caption: User Documentation
   :hidden:

   self

.. toctree::
   :maxdepth: 1
   :caption: Default Schemas 
   :glob:
   :hidden:

   schemas/*

