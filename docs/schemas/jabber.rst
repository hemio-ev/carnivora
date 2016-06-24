======================================================================
jabber
======================================================================

Jabber (XMPP)

This module sends the following signals:
 - jabber/account

.. contents:: Module Contents
   :local:
   :depth: 2


Tables
----------------------------------------------------------------------


.. _TBL-jabber.account:

``jabber.account``
``````````````````````````````````````````````````````````````````````

Jabber accounts

Primary key:

- node
- domain


.. BEGIN FKs

Foreign keys:

- reference dns (service)

  Local Columns
   - domain
   - service
   - service_entity_name

  Referenced Columns
   - :ref:`dns.service.domain <COLUMN-dns.service.domain>`
   - :ref:`dns.service.service <COLUMN-dns.service.service>`
   - :ref:`dns.service.service_entity_name <COLUMN-dns.service.service_entity_name>`

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


.. _COLUMN-jabber.account.domain:

- ``domain`` *dns.t_domain*
    Domain name






.. _COLUMN-jabber.account.service:

- ``service`` *commons.t_key*
    Service






.. _COLUMN-jabber.account.service_entity_name:

- ``service_entity_name`` *dns.t_domain*
    ent. name






.. _COLUMN-jabber.account.subservice:

- ``subservice`` *commons.t_key*
    Subservice (e.g. account, alias)






.. _COLUMN-jabber.account.owner:

- ``owner`` *user.t_user*
    for ownage


  - References: :ref:`user.user.owner <COLUMN-user.user.owner>`




.. _COLUMN-jabber.account.backend_status:

- ``backend_status`` *NULL | backend.t_status*
    Status of database entry in backend. NULL: nothing pending,
    'ins': entry not present on backend client, 'upd': update
    pending on backend client, 'del': deletion peding on
    backend client.

  - Default: :python:`'ins'`





.. _COLUMN-jabber.account.node:

- ``node`` *email.t_localpart*
    part in front of the @ in account name






.. _COLUMN-jabber.account.password:

- ``password`` *commons.t_password*
    Unix shadow crypt format









Functions
---------


``jabber.del_account``
``````````````````````````````````````````````````````````````````````

Delete jabber account


``jabber.ins_account``
``````````````````````````````````````````````````````````````````````

Insert jabber account


``jabber.sel_account``
``````````````````````````````````````````````````````````````````````

Select jabber accounts


``jabber.srv_account``
``````````````````````````````````````````````````````````````````````

Lists all jabber accounts


``jabber.upd_account``
``````````````````````````````````````````````````````````````````````

Change jabber account password



