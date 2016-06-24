======================================================================
domain_reseller
======================================================================

Features for Domains Registered via a Reseller

Stores additional details for dns.registered domains. Also supports storing
contact informations (handles).

This module sends the following signals:
 - domain_reseller/handle
 - domain_registered/managed
 - domain_registered/unmanaged

.. contents:: Module Contents
   :local:
   :depth: 2


Tables
----------------------------------------------------------------------


.. _TBL-domain_reseller.handle:

``domain_reseller.handle``
``````````````````````````````````````````````````````````````````````

Handles (Domain Contacts)

Domain contacts that can be used as owner, admin-c, tech-c or zone-c.

Primary key:

- alias


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


.. _COLUMN-domain_reseller.handle.service_entity_name:

- ``service_entity_name`` *dns.t_domain*
    Service entity name






.. _COLUMN-domain_reseller.handle.service:

- ``service`` *commons.t_key*
    Service (e.g. email, jabber)






.. _COLUMN-domain_reseller.handle.subservice:

- ``subservice`` *commons.t_key*
    Subservice (e.g. account, alias)






.. _COLUMN-domain_reseller.handle.owner:

- ``owner`` *user.t_user*
    for ownage


  - References: :ref:`user.user.owner <COLUMN-user.user.owner>`




.. _COLUMN-domain_reseller.handle.backend_status:

- ``backend_status`` *NULL | backend.t_status*
    Status of database entry in backend. NULL: nothing pending,
    'ins': entry not present on backend client, 'upd': update
    pending on backend client, 'del': deletion peding on
    backend client.

  - Default: :python:`'ins'`





.. _COLUMN-domain_reseller.handle.alias:

- ``alias`` *varchar*
    Free choosable alias






.. _COLUMN-domain_reseller.handle.id:

- ``id`` *NULL | varchar*
    Internal id at reseller






.. _COLUMN-domain_reseller.handle.fname:

- ``fname`` *varchar*
    First name






.. _COLUMN-domain_reseller.handle.lname:

- ``lname`` *varchar*
    Last name






.. _COLUMN-domain_reseller.handle.address:

- ``address`` *varchar*
    Address






.. _COLUMN-domain_reseller.handle.pcode:

- ``pcode`` *varchar*
    Postcode






.. _COLUMN-domain_reseller.handle.city:

- ``city`` *varchar*
    City






.. _COLUMN-domain_reseller.handle.country:

- ``country`` *varchar*
    Country






.. _COLUMN-domain_reseller.handle.state:

- ``state`` *varchar*
    State






.. _COLUMN-domain_reseller.handle.email:

- ``email`` *email.t_address*
    Email






.. _COLUMN-domain_reseller.handle.phone:

- ``phone`` *varchar*
    Phone






.. _COLUMN-domain_reseller.handle.organization:

- ``organization`` *NULL | varchar*
    Organization






.. _COLUMN-domain_reseller.handle.fax:

- ``fax`` *NULL | varchar*
    Fax






.. _COLUMN-domain_reseller.handle.mobile_phone:

- ``mobile_phone`` *NULL | varchar*
    Mobile phone







.. _TBL-domain_reseller.registered:

``domain_reseller.registered``
``````````````````````````````````````````````````````````````````````

Addtional informations to those stored in dns.registered

Primary key:

- domain


.. BEGIN FKs


.. END FKs


Columns
''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''


.. _COLUMN-domain_reseller.registered.domain:

- ``domain`` *dns.t_domain*
    Domain


  - References: :ref:`dns.registered.domain <COLUMN-dns.registered.domain>`

  - On Delete: CASCADE



.. _COLUMN-domain_reseller.registered.registrant:

- ``registrant`` *varchar*
    Registrant (Owner)


  - References: :ref:`domain_reseller.handle.alias <COLUMN-domain_reseller.handle.alias>`




.. _COLUMN-domain_reseller.registered.admin_c:

- ``admin_c`` *varchar*
    Admin-C


  - References: :ref:`domain_reseller.handle.alias <COLUMN-domain_reseller.handle.alias>`




.. _COLUMN-domain_reseller.registered.tech_c:

- ``tech_c`` *NULL | varchar*
    Tech-C


  - References: :ref:`domain_reseller.handle.alias <COLUMN-domain_reseller.handle.alias>`




.. _COLUMN-domain_reseller.registered.zone_c:

- ``zone_c`` *NULL | varchar*
    Zone-C


  - References: :ref:`domain_reseller.handle.alias <COLUMN-domain_reseller.handle.alias>`




.. _COLUMN-domain_reseller.registered.payable:

- ``payable`` *NULL | timestamp*
    Payable






.. _COLUMN-domain_reseller.registered.period:

- ``period`` *NULL | integer*
    Renewal period (years)






.. _COLUMN-domain_reseller.registered.registrar_status:

- ``registrar_status`` *NULL | varchar*
    Registrar status






.. _COLUMN-domain_reseller.registered.registry_status:

- ``registry_status`` *NULL | varchar*
    Registry status






.. _COLUMN-domain_reseller.registered.last_status:

- ``last_status`` *NULL | varchar*
    Last update status









Functions
---------


``domain_reseller.del_handle``
``````````````````````````````````````````````````````````````````````

Deletes handle


``domain_reseller.fwd_handle_id``
``````````````````````````````````````````````````````````````````````

Insert handle id


``domain_reseller.fwd_registered_status``
``````````````````````````````````````````````````````````````````````

Update status


``domain_reseller.ins_handle``
``````````````````````````````````````````````````````````````````````

Inserts handle


``domain_reseller.ins_registered``
``````````````````````````````````````````````````````````````````````

Inserts details for registered domain


``domain_reseller.sel_handle``
``````````````````````````````````````````````````````````````````````

Selects handles


``domain_reseller.sel_registered``
``````````````````````````````````````````````````````````````````````

Selects details for registered domains


``domain_reseller.sel_reseller``
``````````````````````````````````````````````````````````````````````

Selects available resellers


``domain_reseller.srv_handle``
``````````````````````````````````````````````````````````````````````

Serves handles


``domain_reseller.srv_registered``
``````````````````````````````````````````````````````````````````````

Serves details for registered domains


``domain_reseller.upd_handle``
``````````````````````````````````````````````````````````````````````

Updates handle


``domain_reseller.upd_registered``
``````````````````````````````````````````````````````````````````````

Updates details for registered domain



