======================================================================
system
======================================================================

Carnivora System

Manages services, service entities and contingents.

.. contents:: Module Contents
   :local:
   :depth: 2


Tables
----------------------------------------------------------------------


.. _TBL-system.inherit_contingent:

``system.inherit_contingent``
``````````````````````````````````````````````````````````````````````

x

Primary key:

- owner
- priority


.. BEGIN FKs


.. END FKs


Columns
''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''


.. _COLUMN-system.inherit_contingent.owner:

- ``owner`` *user.t_user*
    for ownage


  - References: :ref:`user.user.owner <COLUMN-user.user.owner>`

  - On Delete: CASCADE



.. _COLUMN-system.inherit_contingent.donor:

- ``donor`` *user.t_user*
    Donor


  - References: :ref:`user.user.owner <COLUMN-user.user.owner>`




.. _COLUMN-system.inherit_contingent.priority:

- ``priority`` *int*
    Priority, higher values take precedence







.. _TBL-system.service:

``system.service``
``````````````````````````````````````````````````````````````````````

Services

Just a list of services that exist. Modules do register their services here.
Use system._setup_register_service(<module>, <service>) to insert into this
table.

Primary key:

- service


.. BEGIN FKs


.. END FKs


Columns
''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''


.. _COLUMN-system.service.service:

- ``service`` *commons.t_key*
    Service name






.. _COLUMN-system.service.module:

- ``module`` *commons.t_key*
    Module name, just to keep track who uses this name







.. _TBL-system.service_entity:

``system.service_entity``
``````````````````````````````````````````````````````````````````````

Service Entity

Names under which services are made available. For example (mail.example.org, email)
could be a mail-server system referred to as mail.example.org by carnivora.
Such a system can consist of multiple physical or virtual machines. The corresponding
machines are listed in system.service_entity_machine. A core feature of services is the
definition of 'templates' for dns records which have to be present for every domain
that uses this service. Such 'templates' can be defined in system.service_dns.
Domain names can be enabled for services in dns.service. Service enabled domains
are automatically equipped with the required dns entries accorting to the existing
'templates'.

The service_entity_name might be exposed to users as the address of this service. For
example as SMTP or SSH server etc. The exact interpretation of the service_entity_name
depends on the module and the frontend.

Primary key:

- service_entity_name
- service


.. BEGIN FKs


.. END FKs


Columns
''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''


.. _COLUMN-system.service_entity.service_entity_name:

- ``service_entity_name`` *dns.t_domain*
    Host name






.. _COLUMN-system.service_entity.service:

- ``service`` *commons.t_key*
    email, ssh, ...


  - References: :ref:`system.service.service <COLUMN-system.service.service>`





.. _TBL-system.service_entity_dns:

``system.service_entity_dns``
``````````````````````````````````````````````````````````````````````

Service Entity DNS

Resource records that have to be present to use a service. The records
in this table can be understood as 'templates'. The table does not
contain a name (domain) for the records. Rather for every domain that
uses this service, all appropriate records are created for this domain
based on this table. The assignment from domain to services can
be found in dns.service.

Primary key:

- id


.. BEGIN FKs

Foreign keys:

- Reference service entity

  Local Columns
   - service_entity_name
   - service

  Referenced Columns
   - :ref:`system.service_entity.service_entity_name <COLUMN-system.service_entity.service_entity_name>`
   - :ref:`system.service_entity.service <COLUMN-system.service_entity.service>`


.. END FKs


Columns
''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''


.. _COLUMN-system.service_entity_dns.service_entity_name:

- ``service_entity_name`` *dns.t_domain*
    Service entity name






.. _COLUMN-system.service_entity_dns.service:

- ``service`` *commons.t_key*
    Service (e.g. email, jabber)






.. _COLUMN-system.service_entity_dns.type:

- ``type`` *dns.t_type*
    Type (A, AAAA, CNAME, MX, SRV, TXT, ...)






.. _COLUMN-system.service_entity_dns.rdata:

- ``rdata`` *dns.t_rdata*
    fancy rdata storage






.. _COLUMN-system.service_entity_dns.ttl:

- ``ttl`` *NULL | dns.t_ttl*
    Time to live, NULL indicates default value






.. _COLUMN-system.service_entity_dns.id:

- ``id`` *uuid*
    uuid serial number to identify database elements uniquely
    The default value is generated using uuid_generate_v4().

  - Default: :python:`uuid_generate_v4()`





.. _COLUMN-system.service_entity_dns.domain_prefix:

- ``domain_prefix`` *NULL | varchar*
    Domain prefix







.. _TBL-system.service_entity_machine:

``system.service_entity_machine``
``````````````````````````````````````````````````````````````````````

Service Entity Machine

List of machines that provice a certain service. This information is
used to provide these machines access to the data they need to provide
the service. See also the module 'backend'.

Primary key:

- machine_name
- service_entity_name
- service


.. BEGIN FKs

Foreign keys:

- Reference service entity

  Local Columns
   - service_entity_name
   - service

  Referenced Columns
   - :ref:`system.service_entity.service_entity_name <COLUMN-system.service_entity.service_entity_name>`
   - :ref:`system.service_entity.service <COLUMN-system.service_entity.service>`


.. END FKs


Columns
''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''


.. _COLUMN-system.service_entity_machine.service_entity_name:

- ``service_entity_name`` *dns.t_domain*
    Service entity name






.. _COLUMN-system.service_entity_machine.service:

- ``service`` *commons.t_key*
    Service (e.g. email, jabber)






.. _COLUMN-system.service_entity_machine.machine_name:

- ``machine_name`` *dns.t_domain*
    Assigns machine


  - References: :ref:`backend.machine.name <COLUMN-backend.machine.name>`





.. _TBL-system.subservice:

``system.subservice``
``````````````````````````````````````````````````````````````````````

Subservices

Primary key:

- service
- subservice


.. BEGIN FKs


.. END FKs


Columns
''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''


.. _COLUMN-system.subservice.service:

- ``service`` *commons.t_key*
    Service


  - References: :ref:`system.service.service <COLUMN-system.service.service>`




.. _COLUMN-system.subservice.subservice:

- ``subservice`` *commons.t_key*
    Subservice (concretization the service)







.. _TBL-system.subservice_entity:

``system.subservice_entity``
``````````````````````````````````````````````````````````````````````

Subservice Entity

Names under which subservices are made available.

See also: Table system.service_entity

Primary key:

- service_entity_name
- service
- subservice


.. BEGIN FKs

Foreign keys:

- service ent

  Local Columns
   - service_entity_name
   - service

  Referenced Columns
   - :ref:`system.service_entity.service_entity_name <COLUMN-system.service_entity.service_entity_name>`
   - :ref:`system.service_entity.service <COLUMN-system.service_entity.service>`

- subservice

  Local Columns
   - service
   - subservice

  Referenced Columns
   - :ref:`system.subservice.service <COLUMN-system.subservice.service>`
   - :ref:`system.subservice.subservice <COLUMN-system.subservice.subservice>`


.. END FKs


Columns
''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''


.. _COLUMN-system.subservice_entity.service_entity_name:

- ``service_entity_name`` *dns.t_domain*
    Service entity name






.. _COLUMN-system.subservice_entity.service:

- ``service`` *commons.t_key*
    Service name






.. _COLUMN-system.subservice_entity.subservice:

- ``subservice`` *commons.t_key*
    account, alias, ...







.. _TBL-system.subservice_entity_contingent:

``system.subservice_entity_contingent``
``````````````````````````````````````````````````````````````````````

Subservice entity contingent

Primary key:

- service
- subservice
- service_entity_name
- owner


.. BEGIN FKs

Foreign keys:

- Reference service entity

  Local Columns
   - service_entity_name
   - service

  Referenced Columns
   - :ref:`system.service_entity.service_entity_name <COLUMN-system.service_entity.service_entity_name>`
   - :ref:`system.service_entity.service <COLUMN-system.service_entity.service>`

- Reference subservice entity

  Local Columns
   - service_entity_name
   - service
   - subservice

  Referenced Columns
   - :ref:`system.subservice_entity.service_entity_name <COLUMN-system.subservice_entity.service_entity_name>`
   - :ref:`system.subservice_entity.service <COLUMN-system.subservice_entity.service>`
   - :ref:`system.subservice_entity.subservice <COLUMN-system.subservice_entity.subservice>`


.. END FKs


Columns
''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''


.. _COLUMN-system.subservice_entity_contingent.service_entity_name:

- ``service_entity_name`` *dns.t_domain*
    Service entity name






.. _COLUMN-system.subservice_entity_contingent.service:

- ``service`` *commons.t_key*
    Service (e.g. email, jabber)






.. _COLUMN-system.subservice_entity_contingent.subservice:

- ``subservice`` *commons.t_key*
    Subservice (e.g. account, alias)






.. _COLUMN-system.subservice_entity_contingent.owner:

- ``owner`` *user.t_user*
    for ownage


  - References: :ref:`user.user.owner <COLUMN-user.user.owner>`




.. _COLUMN-system.subservice_entity_contingent.domain_contingent:

- ``domain_contingent`` *integer*
    Limit per domain






.. _COLUMN-system.subservice_entity_contingent.total_contingent:

- ``total_contingent`` *integer*
    Limit on the total







.. _TBL-system.subservice_entity_domain_contingent:

``system.subservice_entity_domain_contingent``
``````````````````````````````````````````````````````````````````````

Subservice entity per domain contingent

Primary key:

- service
- subservice
- service_entity_name
- domain
- owner


.. BEGIN FKs

Foreign keys:

- Reference service entity

  Local Columns
   - service_entity_name
   - service

  Referenced Columns
   - :ref:`system.service_entity.service_entity_name <COLUMN-system.service_entity.service_entity_name>`
   - :ref:`system.service_entity.service <COLUMN-system.service_entity.service>`

- Reference subservice entity

  Local Columns
   - service_entity_name
   - service
   - subservice

  Referenced Columns
   - :ref:`system.subservice_entity.service_entity_name <COLUMN-system.subservice_entity.service_entity_name>`
   - :ref:`system.subservice_entity.service <COLUMN-system.subservice_entity.service>`
   - :ref:`system.subservice_entity.subservice <COLUMN-system.subservice_entity.subservice>`


.. END FKs


Columns
''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''


.. _COLUMN-system.subservice_entity_domain_contingent.service_entity_name:

- ``service_entity_name`` *dns.t_domain*
    Service entity name






.. _COLUMN-system.subservice_entity_domain_contingent.service:

- ``service`` *commons.t_key*
    Service (e.g. email, jabber)






.. _COLUMN-system.subservice_entity_domain_contingent.subservice:

- ``subservice`` *commons.t_key*
    Subservice (e.g. account, alias)






.. _COLUMN-system.subservice_entity_domain_contingent.owner:

- ``owner`` *user.t_user*
    for ownage


  - References: :ref:`user.user.owner <COLUMN-user.user.owner>`




.. _COLUMN-system.subservice_entity_domain_contingent.domain:

- ``domain`` *dns.t_domain*
    Specific domain for which the access is granted






.. _COLUMN-system.subservice_entity_domain_contingent.domain_contingent:

- ``domain_contingent`` *integer*
    Limit per domain









Functions
---------


``system._contingent_ensure``
``````````````````````````````````````````````````````````````````````

Throws exceptions if the contingent is exceeded


``system._contingent_total``
``````````````````````````````````````````````````````````````````````

Contingent


``system._effective_contingent``
``````````````````````````````````````````````````````````````````````

contingent


``system._effective_contingent_domain``
``````````````````````````````````````````````````````````````````````

contingent


``system._inherit_contingent_donor``
``````````````````````````````````````````````````````````````````````

Returns all contingent donors for a given user with their priority.


``system._setup_register_service``
``````````````````````````````````````````````````````````````````````

Allows modules to register their services during setup.
Returns the total number of service names registered
for this module.


``system._setup_register_subservice``
``````````````````````````````````````````````````````````````````````

Allows modules to register their services during setup.
Returns the total number of service names registered
for this module.


``system.sel_inherit_contingent``
``````````````````````````````````````````````````````````````````````

Select inherit contingent


``system.sel_usable_host``
``````````````````````````````````````````````````````````````````````

Usable hosts



