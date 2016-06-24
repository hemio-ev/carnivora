======================================================================
dns
======================================================================

DNS

.. contents:: Module Contents
   :local:
   :depth: 2


Tables
----------------------------------------------------------------------


.. _TBL-dns.custom:

``dns.custom``
``````````````````````````````````````````````````````````````````````

Direct name server entries.

Primary key:

- id


.. BEGIN FKs


.. END FKs


Columns
''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''


.. _COLUMN-dns.custom.type:

- ``type`` *dns.t_type*
    Type (A, AAAA, CNAME, MX, SRV, TXT, ...)






.. _COLUMN-dns.custom.rdata:

- ``rdata`` *dns.t_rdata*
    fancy rdata storage






.. _COLUMN-dns.custom.ttl:

- ``ttl`` *NULL | dns.t_ttl*
    Time to live, NULL indicates default value






.. _COLUMN-dns.custom.backend_status:

- ``backend_status`` *NULL | backend.t_status*
    Status of database entry in backend. NULL: nothing pending,
    'ins': entry not present on backend client, 'upd': update
    pending on backend client, 'del': deletion peding on
    backend client.

  - Default: :python:`'ins'`





.. _COLUMN-dns.custom.registered:

- ``registered`` *dns.t_domain*
    Registered domain of which domain is a sub domain


  - References: :ref:`dns.registered.domain <COLUMN-dns.registered.domain>`




.. _COLUMN-dns.custom.domain:

- ``domain`` *dns.t_domain*
    domain of entry






.. _COLUMN-dns.custom.id:

- ``id`` *uuid*
    uuid serial number to identify database elements uniquely
    The default value is generated using uuid_generate_v4().

  - Default: :python:`uuid_generate_v4()`






.. _TBL-dns.registered:

``dns.registered``
``````````````````````````````````````````````````````````````````````

Domains registered under a public suffix.

Primary key:

- domain


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


.. _COLUMN-dns.registered.owner:

- ``owner`` *user.t_user*
    for ownage


  - References: :ref:`user.user.owner <COLUMN-user.user.owner>`




.. _COLUMN-dns.registered.backend_status:

- ``backend_status`` *NULL | backend.t_status*
    Status of database entry in backend. NULL: nothing pending,
    'ins': entry not present on backend client, 'upd': update
    pending on backend client, 'del': deletion peding on
    backend client.

  - Default: :python:`'ins'`





.. _COLUMN-dns.registered.service_entity_name:

- ``service_entity_name`` *dns.t_domain*
    Service entity name






.. _COLUMN-dns.registered.service:

- ``service`` *commons.t_key*
    Service (e.g. email, jabber)






.. _COLUMN-dns.registered.subservice:

- ``subservice`` *commons.t_key*
    Subservice (e.g. account, alias)






.. _COLUMN-dns.registered.domain:

- ``domain`` *dns.t_domain*
    Domain






.. _COLUMN-dns.registered.public_suffix:

- ``public_suffix`` *varchar*
    Public Suffix







.. _TBL-dns.service:

``dns.service``
``````````````````````````````````````````````````````````````````````

Name server entries based on system.service (i.e. system.service_dns)

Primary key:

- domain
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


.. _COLUMN-dns.service.service_entity_name:

- ``service_entity_name`` *dns.t_domain*
    Service entity name






.. _COLUMN-dns.service.service:

- ``service`` *commons.t_key*
    Service (e.g. email, jabber)






.. _COLUMN-dns.service.backend_status:

- ``backend_status`` *NULL | backend.t_status*
    Status of database entry in backend. NULL: nothing pending,
    'ins': entry not present on backend client, 'upd': update
    pending on backend client, 'del': deletion peding on
    backend client.

  - Default: :python:`'ins'`





.. _COLUMN-dns.service.registered:

- ``registered`` *dns.t_domain*
    Registered domain of which domain is a sub domain


  - References: :ref:`dns.registered.domain <COLUMN-dns.registered.domain>`




.. _COLUMN-dns.service.domain:

- ``domain`` *dns.t_domain*
    domain for which the entries should be created









Functions
---------


``dns._domain_order``
``````````````````````````````````````````````````````````````````````

ORDER


``dns._rdata_txtdata_valid``
``````````````````````````````````````````````````````````````````````

Rdata txt-data valid


``dns.del_custom``
``````````````````````````````````````````````````````````````````````

Delete Custom


``dns.del_registered``
``````````````````````````````````````````````````````````````````````

Delete registered domain


``dns.del_service``
``````````````````````````````````````````````````````````````````````

deletes all service entries of a specific domain


``dns.fwd_registered_status``
``````````````````````````````````````````````````````````````````````

Update status


``dns.ins_custom``
``````````````````````````````````````````````````````````````````````

Ins Custom


``dns.ins_registered``
``````````````````````````````````````````````````````````````````````

registeres new domain


``dns.ins_service``
``````````````````````````````````````````````````````````````````````

Creates service dns entry


``dns.sel_activatable_service``
``````````````````````````````````````````````````````````````````````

Activatable services


``dns.sel_available_service``
``````````````````````````````````````````````````````````````````````

List all domains that have a service entry in dns with their service.
This is particularly usefull since these domains are ready for use with
this service. Usually this means that accounts etc. can be created for this
domain.


``dns.sel_custom``
``````````````````````````````````````````````````````````````````````

sel custom


``dns.sel_nameserver``
``````````````````````````````````````````````````````````````````````

Select available nameservers


``dns.sel_registered``
``````````````````````````````````````````````````````````````````````

List registered domains


``dns.sel_service``
``````````````````````````````````````````````````````````````````````

Select service based dns entries


``dns.sel_usable_domain``
``````````````````````````````````````````````````````````````````````

Usable domains


``dns.srv_record``
``````````````````````````````````````````````````````````````````````

Servers both record types combined: Raw entries and the ones assembled
from records templates for services (system.service_entity_dns).


``dns.upd_custom``
``````````````````````````````````````````````````````````````````````

Ins Custom



