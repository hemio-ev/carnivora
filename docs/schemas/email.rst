======================================================================
email
======================================================================

Email and Mailing lists

This module sends the following signals:
 - email/alias
 - email/list
 - email/mailbox
 - email/redirection

.. contents:: Module Contents
   :local:
   :depth: 2


Tables
----------------------------------------------------------------------


.. _TBL-email.address:

``email.address``
``````````````````````````````````````````````````````````````````````

Collection of all known addresses

Primary key:

- localpart
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


.. _COLUMN-email.address.domain:

- ``domain`` *dns.t_domain*
    Domain name






.. _COLUMN-email.address.service:

- ``service`` *commons.t_key*
    Service






.. _COLUMN-email.address.service_entity_name:

- ``service_entity_name`` *dns.t_domain*
    ent. name






.. _COLUMN-email.address.subservice:

- ``subservice`` *commons.t_key*
    Subservice (e.g. account, alias)






.. _COLUMN-email.address.localpart:

- ``localpart`` *email.t_localpart*
    Local part







.. _TBL-email.alias:

``email.alias``
``````````````````````````````````````````````````````````````````````

Aliases for e-mail mailboxes, owner is determined by mailbox.owner

Primary key:

- localpart
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

- reference to a mailbox

  Local Columns
   - mailbox_localpart
   - mailbox_domain

  Referenced Columns
   - :ref:`email.mailbox.localpart <COLUMN-email.mailbox.localpart>`
   - :ref:`email.mailbox.domain <COLUMN-email.mailbox.domain>`


.. END FKs


Columns
''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''


.. _COLUMN-email.alias.domain:

- ``domain`` *dns.t_domain*
    Domain name






.. _COLUMN-email.alias.service:

- ``service`` *commons.t_key*
    Service






.. _COLUMN-email.alias.service_entity_name:

- ``service_entity_name`` *dns.t_domain*
    ent. name






.. _COLUMN-email.alias.subservice:

- ``subservice`` *commons.t_key*
    Subservice (e.g. account, alias)






.. _COLUMN-email.alias.backend_status:

- ``backend_status`` *NULL | backend.t_status*
    Status of database entry in backend. NULL: nothing pending,
    'ins': entry not present on backend client, 'upd': update
    pending on backend client, 'del': deletion peding on
    backend client.

  - Default: :python:`'ins'`





.. _COLUMN-email.alias.localpart:

- ``localpart`` *email.t_localpart*
    Local part






.. _COLUMN-email.alias.mailbox_localpart:

- ``mailbox_localpart`` *email.t_localpart*
    Mailbox to which the mails will be delivered






.. _COLUMN-email.alias.mailbox_domain:

- ``mailbox_domain`` *dns.t_domain*
    Mailbox to which the mails will be delivered







.. _TBL-email.list:

``email.list``
``````````````````````````````````````````````````````````````````````

Mailing lists

Primary key:

- localpart
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


.. _COLUMN-email.list.domain:

- ``domain`` *dns.t_domain*
    Domain name






.. _COLUMN-email.list.service:

- ``service`` *commons.t_key*
    Service






.. _COLUMN-email.list.service_entity_name:

- ``service_entity_name`` *dns.t_domain*
    ent. name






.. _COLUMN-email.list.subservice:

- ``subservice`` *commons.t_key*
    Subservice (e.g. account, alias)






.. _COLUMN-email.list.owner:

- ``owner`` *user.t_user*
    for ownage


  - References: :ref:`user.user.owner <COLUMN-user.user.owner>`




.. _COLUMN-email.list.backend_status:

- ``backend_status`` *NULL | backend.t_status*
    Status of database entry in backend. NULL: nothing pending,
    'ins': entry not present on backend client, 'upd': update
    pending on backend client, 'del': deletion peding on
    backend client.

  - Default: :python:`'ins'`





.. _COLUMN-email.list.option:

- ``option`` *jsonb*
    Free options in JSON format

  - Default: :python:`'{}'`





.. _COLUMN-email.list.localpart:

- ``localpart`` *email.t_localpart*
    Local part of the email list address






.. _COLUMN-email.list.admin:

- ``admin`` *email.t_address*
    Email address of the list admin






.. _COLUMN-email.list.options:

- ``options`` *NULL | jsonb*
    Arbitrary options







.. _TBL-email.list_subscriber:

``email.list_subscriber``
``````````````````````````````````````````````````````````````````````

list subscribers

Primary key:

- address
- list_localpart
- list_domain


.. BEGIN FKs

Foreign keys:

- reference to a list

  Local Columns
   - list_localpart
   - list_domain

  Referenced Columns
   - :ref:`email.list.localpart <COLUMN-email.list.localpart>`
   - :ref:`email.list.domain <COLUMN-email.list.domain>`


.. END FKs


Columns
''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''


.. _COLUMN-email.list_subscriber.backend_status:

- ``backend_status`` *NULL | backend.t_status*
    Status of database entry in backend. NULL: nothing pending,
    'ins': entry not present on backend client, 'upd': update
    pending on backend client, 'del': deletion peding on
    backend client.

  - Default: :python:`'ins'`





.. _COLUMN-email.list_subscriber.option:

- ``option`` *jsonb*
    Free options in JSON format

  - Default: :python:`'{}'`





.. _COLUMN-email.list_subscriber.address:

- ``address`` *email.t_address*
    Subscribers address






.. _COLUMN-email.list_subscriber.list_localpart:

- ``list_localpart`` *email.t_localpart*
    List






.. _COLUMN-email.list_subscriber.list_domain:

- ``list_domain`` *dns.t_domain*
    List







.. _TBL-email.mailbox:

``email.mailbox``
``````````````````````````````````````````````````````````````````````

E-mail mailboxs correspond to something a mail user can login into. Basically
a mailbox represents a mailbox. A mailbox is bound to a specific address.
Further addresses can be linked to mailboxs via aliases.

Primary key:

- localpart
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


.. _COLUMN-email.mailbox.domain:

- ``domain`` *dns.t_domain*
    Domain name






.. _COLUMN-email.mailbox.service:

- ``service`` *commons.t_key*
    Service






.. _COLUMN-email.mailbox.service_entity_name:

- ``service_entity_name`` *dns.t_domain*
    ent. name






.. _COLUMN-email.mailbox.subservice:

- ``subservice`` *commons.t_key*
    Subservice (e.g. account, alias)






.. _COLUMN-email.mailbox.owner:

- ``owner`` *user.t_user*
    for ownage


  - References: :ref:`user.user.owner <COLUMN-user.user.owner>`




.. _COLUMN-email.mailbox.backend_status:

- ``backend_status`` *NULL | backend.t_status*
    Status of database entry in backend. NULL: nothing pending,
    'ins': entry not present on backend client, 'upd': update
    pending on backend client, 'del': deletion peding on
    backend client.

  - Default: :python:`'ins'`





.. _COLUMN-email.mailbox.option:

- ``option`` *jsonb*
    Free options in JSON format

  - Default: :python:`'{}'`





.. _COLUMN-email.mailbox.localpart:

- ``localpart`` *email.t_localpart*
    Local part






.. _COLUMN-email.mailbox.uid:

- ``uid`` *SERIAL*
    Unix user identifier






.. _COLUMN-email.mailbox.password:

- ``password`` *commons.t_password*
    Unix shadow crypt format






.. _COLUMN-email.mailbox.quota:

- ``quota`` *NULL | int*
    Quota for mailbox in MiB







.. _TBL-email.redirection:

``email.redirection``
``````````````````````````````````````````````````````````````````````

Redirections

Primary key:

- localpart
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


.. _COLUMN-email.redirection.domain:

- ``domain`` *dns.t_domain*
    Domain name






.. _COLUMN-email.redirection.service:

- ``service`` *commons.t_key*
    Service






.. _COLUMN-email.redirection.service_entity_name:

- ``service_entity_name`` *dns.t_domain*
    ent. name






.. _COLUMN-email.redirection.subservice:

- ``subservice`` *commons.t_key*
    Subservice (e.g. account, alias)






.. _COLUMN-email.redirection.owner:

- ``owner`` *user.t_user*
    for ownage


  - References: :ref:`user.user.owner <COLUMN-user.user.owner>`




.. _COLUMN-email.redirection.backend_status:

- ``backend_status`` *NULL | backend.t_status*
    Status of database entry in backend. NULL: nothing pending,
    'ins': entry not present on backend client, 'upd': update
    pending on backend client, 'del': deletion peding on
    backend client.

  - Default: :python:`'ins'`





.. _COLUMN-email.redirection.localpart:

- ``localpart`` *email.t_localpart*
    Local part






.. _COLUMN-email.redirection.destination:

- ``destination`` *email.t_address*
    External address to which the mails will be delivered









Functions
---------


``email._address``
``````````````````````````````````````````````````````````````````````

List all addresses


``email._address_valid``
``````````````````````````````````````````````````````````````````````

x


``email.del_alias``
``````````````````````````````````````````````````````````````````````

Delete Alias


``email.del_list``
``````````````````````````````````````````````````````````````````````

Delete mailing list


``email.del_list_subscriber``
``````````````````````````````````````````````````````````````````````

del


``email.del_mailbox``
``````````````````````````````````````````````````````````````````````

Delete mailbox


``email.del_redirection``
``````````````````````````````````````````````````````````````````````

Delete redirection


``email.ins_alias``
``````````````````````````````````````````````````````````````````````

Create e-mail aliases


``email.ins_list``
``````````````````````````````````````````````````````````````````````

Creates a mailing list


``email.ins_list_subscriber``
``````````````````````````````````````````````````````````````````````

Adds a subscriber to a mailing list


``email.ins_mailbox``
``````````````````````````````````````````````````````````````````````

Creates an email box


``email.ins_redirection``
``````````````````````````````````````````````````````````````````````

Creates a redirection


``email.sel_alias``
``````````````````````````````````````````````````````````````````````

Select aliases


``email.sel_list``
``````````````````````````````````````````````````````````````````````

List all lists


``email.sel_list_subscriber``
``````````````````````````````````````````````````````````````````````

a


``email.sel_mailbox``
``````````````````````````````````````````````````````````````````````

List all mailboxes


``email.sel_redirection``
``````````````````````````````````````````````````````````````````````

Lists all redirections


``email.srv_alias``
``````````````````````````````````````````````````````````````````````

Lists all email aliases


``email.srv_list``
``````````````````````````````````````````````````````````````````````

Lists all mailinglists


``email.srv_list_subscriber``
``````````````````````````````````````````````````````````````````````

Lists all mailinglist subscribers


``email.srv_mailbox``
``````````````````````````````````````````````````````````````````````

Lists all mailboxes


``email.srv_redirection``
``````````````````````````````````````````````````````````````````````

Lists all mailinglists


``email.upd_list``
``````````````````````````````````````````````````````````````````````

Change list admin


``email.upd_mailbox``
``````````````````````````````````````````````````````````````````````

Change mailbox password



