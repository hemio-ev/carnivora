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

- ``backend_status`` *NULL* | *backend.t_status*
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

- ``backend_status`` *NULL* | *backend.t_status*
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

- ``options`` *NULL* | *jsonb*
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

- ``backend_status`` *NULL* | *backend.t_status*
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

- ``backend_status`` *NULL* | *backend.t_status*
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

- ``quota`` *NULL* | *int*
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

- ``backend_status`` *NULL* | *backend.t_status*
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

.. code-block:: plpgsql

   RETURN QUERY (
    SELECT t.localpart, t.domain, t.owner, t.subservice FROM email.mailbox AS t
    UNION ALL
    SELECT t.localpart, t.domain, t.owner, t.subservice FROM email.redirection AS t
    UNION ALL
    SELECT t.localpart, t.domain, s.owner, t.subservice FROM email.alias AS t
     LEFT JOIN email.mailbox AS s
      ON
       t.mailbox_localpart = s.localpart AND
       t.mailbox_domain = s.domain
    UNION ALL
    SELECT t.localpart, t.domain, t.owner, t.subservice FROM email.list AS t
   );


``email._address_valid``
``````````````````````````````````````````````````````````````````````

x

.. code-block:: plpgsql

   IF (
       SELECT TRUE FROM email._address()
       WHERE
           localpart = p_localpart AND
           domain = p_domain
   ) THEN
       RAISE 'Email address already exists.'
           USING DETAIL = '$carnivora:email:address_already_exists$';
   END IF;


``email.del_alias``
``````````````````````````````````````````````````````````````````````

Delete Alias

.. code-block:: plpgsql

   -- begin userlogin prelude
   v_login := (SELECT t.owner FROM "user"._get_login() AS t);
   v_owner := (SELECT t.act_as FROM "user"._get_login() AS t);
   -- end userlogin prelude
   
   
   UPDATE email.alias AS t
       SET backend_status = 'del'
   FROM email.mailbox AS s
   WHERE
       -- JOIN
       t.mailbox_localpart = s.localpart AND
       t.mailbox_domain = s.domain AND
   
       t.localpart = p_localpart AND
       t.domain = p_domain AND
       s.localpart = p_mailbox_localpart AND
       s.domain = p_mailbox_domain AND
   
       s.owner = v_owner;
   
   PERFORM backend._conditional_notify(FOUND, 'email', 'alias', p_domain);


``email.del_list``
``````````````````````````````````````````````````````````````````````

Delete mailing list

.. code-block:: plpgsql

   -- begin userlogin prelude
   v_login := (SELECT t.owner FROM "user"._get_login() AS t);
   v_owner := (SELECT t.act_as FROM "user"._get_login() AS t);
   -- end userlogin prelude
   
   DELETE FROM email.list
   WHERE
       domain = p_domain AND
       localpart = p_localpart AND
       owner = v_owner;
   
   PERFORM backend._conditional_notify(FOUND, 'email', 'list', p_domain);


``email.del_list_subscriber``
``````````````````````````````````````````````````````````````````````

del

.. code-block:: plpgsql

   -- begin userlogin prelude
   v_login := (SELECT t.owner FROM "user"._get_login() AS t);
   v_owner := (SELECT t.act_as FROM "user"._get_login() AS t);
   -- end userlogin prelude
   
   UPDATE email.list_subscriber AS t
       SET backend_status = 'del'
   
       FROM email.list AS s
       WHERE
           s.localpart = t.list_localpart AND
           s.domain = t.list_domain AND
           s.owner = v_owner AND
   
           t.list_localpart = p_list_localpart AND
           t.list_domain = p_list_domain AND
           t.address = p_address;
   
   PERFORM backend._conditional_notify(FOUND, 'email', 'list', p_list_domain);


``email.del_mailbox``
``````````````````````````````````````````````````````````````````````

Delete mailbox

.. code-block:: plpgsql

   -- begin userlogin prelude
   v_login := (SELECT t.owner FROM "user"._get_login() AS t);
   v_owner := (SELECT t.act_as FROM "user"._get_login() AS t);
   -- end userlogin prelude
   
   UPDATE email.mailbox
           SET backend_status = 'del'
       WHERE
           localpart = p_localpart AND
           domain = p_domain AND
           owner = v_owner;
   
   PERFORM backend._conditional_notify(FOUND, 'email', 'mailbox', p_domain);


``email.del_redirection``
``````````````````````````````````````````````````````````````````````

Delete redirection

.. code-block:: plpgsql

   -- begin userlogin prelude
   v_login := (SELECT t.owner FROM "user"._get_login() AS t);
   v_owner := (SELECT t.act_as FROM "user"._get_login() AS t);
   -- end userlogin prelude
   
   
   UPDATE email.redirection
           SET backend_status = 'del'
       WHERE
           localpart = p_localpart AND
           domain = p_domain AND
           owner = v_owner;
   
   PERFORM backend._conditional_notify(FOUND, 'email', 'redirection', p_domain);


``email.ins_alias``
``````````````````````````````````````````````````````````````````````

Create e-mail aliases

.. code-block:: plpgsql

   -- begin userlogin prelude
   v_login := (SELECT t.owner FROM "user"._get_login() AS t);
   v_owner := (SELECT t.act_as FROM "user"._get_login() AS t);
   -- end userlogin prelude
   
   PERFORM email._address_valid(p_localpart, p_domain);
   
   v_num_total := (SELECT COUNT(*) FROM email._address() AS t WHERE t.owner=v_owner AND t.subservice=v_subservice);
   v_num_domain := (SELECT COUNT(*) FROM email._address() AS t WHERE t.owner=v_owner AND t.subservice=v_subservice AND t.domain = p_domain);
   
   PERFORM system._contingent_ensure(
       p_owner:=v_owner,
       p_domain:=p_domain,
       p_service:='email',
       p_subservice:=v_subservice,
       p_current_quantity_total:=v_num_total,
       p_current_quantity_domain:=v_num_domain);
   
   
   PERFORM email._address_valid(p_localpart, p_domain);
   LOCK TABLE email.mailbox;
   
   PERFORM commons._raise_inaccessible_or_missing(
   EXISTS(
       SELECT TRUE FROM email.mailbox
       WHERE
           domain=p_mailbox_domain AND
           localpart=p_mailbox_localpart AND
           owner=v_owner AND
           backend._active(backend_status)
    ));
   
   INSERT INTO email.alias
       (service, subservice, localpart, domain, mailbox_localpart, mailbox_domain, service_entity_name)
   VALUES
       ('email', 'alias', p_localpart, p_domain, p_mailbox_localpart, p_mailbox_domain,
       (SELECT service_entity_name FROM dns.service WHERE service='email' AND domain = p_domain));
   
   PERFORM backend._notify_domain('email', 'alias', p_domain);


``email.ins_list``
``````````````````````````````````````````````````````````````````````

Creates a mailing list

.. code-block:: plpgsql

   -- begin userlogin prelude
   v_login := (SELECT t.owner FROM "user"._get_login() AS t);
   v_owner := (SELECT t.act_as FROM "user"._get_login() AS t);
   -- end userlogin prelude
   
   PERFORM email._address_valid(p_localpart, p_domain);
   
   v_num_total := (SELECT COUNT(*) FROM email._address() AS t WHERE t.owner=v_owner AND t.subservice=v_subservice);
   v_num_domain := (SELECT COUNT(*) FROM email._address() AS t WHERE t.owner=v_owner AND t.subservice=v_subservice AND t.domain = p_domain);
   
   PERFORM system._contingent_ensure(
       p_owner:=v_owner,
       p_domain:=p_domain,
       p_service:='email',
       p_subservice:=v_subservice,
       p_current_quantity_total:=v_num_total,
       p_current_quantity_domain:=v_num_domain);
   
   
   INSERT INTO email.list
       (service, subservice, localpart, domain, owner, admin, service_entity_name) VALUES
       ('email', 'list', p_localpart, p_domain, v_owner, p_admin,
       (SELECT service_entity_name FROM dns.service WHERE service='email' AND domain = p_domain));
   
   PERFORM backend._notify_domain('email', 'list', p_domain);


``email.ins_list_subscriber``
``````````````````````````````````````````````````````````````````````

Adds a subscriber to a mailing list

.. code-block:: plpgsql

   -- begin userlogin prelude
   v_login := (SELECT t.owner FROM "user"._get_login() AS t);
   v_owner := (SELECT t.act_as FROM "user"._get_login() AS t);
   -- end userlogin prelude
   
   
   PERFORM commons._raise_inaccessible_or_missing(
       EXISTS(
           SELECT TRUE FROM email.list
           WHERE
               localpart = p_list_localpart AND
               domain =  p_list_domain AND
               owner = v_owner
       )
   );
   
   INSERT INTO email.list_subscriber
       (address, list_localpart, list_domain)
   VALUES
       (p_address, p_list_localpart, p_list_domain);
   
   PERFORM backend._notify_domain('email', 'list', p_list_domain);


``email.ins_mailbox``
``````````````````````````````````````````````````````````````````````

Creates an email box

.. code-block:: plpgsql

   -- begin userlogin prelude
   v_login := (SELECT t.owner FROM "user"._get_login() AS t);
   v_owner := (SELECT t.act_as FROM "user"._get_login() AS t);
   -- end userlogin prelude
   
   PERFORM email._address_valid(p_localpart, p_domain);
   
   v_num_total := (SELECT COUNT(*) FROM email._address() AS t WHERE t.owner=v_owner AND t.subservice=v_subservice);
   v_num_domain := (SELECT COUNT(*) FROM email._address() AS t WHERE t.owner=v_owner AND t.subservice=v_subservice AND t.domain = p_domain);
   
   PERFORM system._contingent_ensure(
       p_owner:=v_owner,
       p_domain:=p_domain,
       p_service:='email',
       p_subservice:=v_subservice,
       p_current_quantity_total:=v_num_total,
       p_current_quantity_domain:=v_num_domain);
   
   
   PERFORM email._address_valid(p_localpart, p_domain);
   
   INSERT INTO email.mailbox
       (service, subservice, localpart, domain, owner, password, service_entity_name) VALUES
       ('email', 'mailbox', p_localpart, p_domain, v_owner, commons._hash_password(p_password),
       (SELECT service_entity_name FROM dns.service WHERE service='email' AND domain = p_domain)
       );
   
   PERFORM backend._notify_domain('email', 'mailbox', p_domain);


``email.ins_redirection``
``````````````````````````````````````````````````````````````````````

Creates a redirection

.. code-block:: plpgsql

   -- begin userlogin prelude
   v_login := (SELECT t.owner FROM "user"._get_login() AS t);
   v_owner := (SELECT t.act_as FROM "user"._get_login() AS t);
   -- end userlogin prelude
   
   PERFORM email._address_valid(p_localpart, p_domain);
   
   v_num_total := (SELECT COUNT(*) FROM email._address() AS t WHERE t.owner=v_owner AND t.subservice=v_subservice);
   v_num_domain := (SELECT COUNT(*) FROM email._address() AS t WHERE t.owner=v_owner AND t.subservice=v_subservice AND t.domain = p_domain);
   
   PERFORM system._contingent_ensure(
       p_owner:=v_owner,
       p_domain:=p_domain,
       p_service:='email',
       p_subservice:=v_subservice,
       p_current_quantity_total:=v_num_total,
       p_current_quantity_domain:=v_num_domain);
   
   
   PERFORM email._address_valid(p_localpart, p_domain);
   
   INSERT INTO email.redirection
       (service, subservice, localpart, domain, destination, owner, service_entity_name) VALUES
       ('email', 'redirection', p_localpart, p_domain, p_destination, v_owner,
       (SELECT service_entity_name FROM dns.service WHERE service='email' AND domain = p_domain));
   
   PERFORM backend._notify_domain('email', 'redirection', p_domain);


``email.sel_alias``
``````````````````````````````````````````````````````````````````````

Select aliases

.. code-block:: plpgsql

   -- begin userlogin prelude
   v_login := (SELECT t.owner FROM "user"._get_login() AS t);
   v_owner := (SELECT t.act_as FROM "user"._get_login() AS t);
   -- end userlogin prelude
   
   RETURN QUERY
   SELECT
       t.localpart,
       t.domain,
       t.mailbox_localpart,
       t.mailbox_domain,
       t.backend_status
   FROM email.alias AS t
       
   INNER JOIN email.mailbox AS s
       ON
           t.mailbox_localpart = s.localpart AND
           t.mailbox_domain = s.domain
   WHERE s.owner = v_owner;


``email.sel_list``
``````````````````````````````````````````````````````````````````````

List all lists

.. code-block:: plpgsql

   -- begin userlogin prelude
   v_login := (SELECT t.owner FROM "user"._get_login() AS t);
   v_owner := (SELECT t.act_as FROM "user"._get_login() AS t);
   -- end userlogin prelude
   
   RETURN QUERY
       SELECT
           t.domain,
           t.localpart,
           t.owner,
           t.admin,
           t.backend_status,
           (SELECT COUNT(*) FROM email.list_subscriber AS s
           WHERE s.list_localpart=t.localpart AND s.list_domain=t.domain)
       FROM
           email.list AS t
       WHERE
           t.owner = v_owner;


``email.sel_list_subscriber``
``````````````````````````````````````````````````````````````````````

a

.. code-block:: plpgsql

   -- begin userlogin prelude
   v_login := (SELECT t.owner FROM "user"._get_login() AS t);
   v_owner := (SELECT t.act_as FROM "user"._get_login() AS t);
   -- end userlogin prelude
   
   RETURN QUERY
       SELECT
           t.address,
           t.list_localpart,
           t.list_domain,
           t.backend_status
       FROM email.list_subscriber AS t
       JOIN email.list AS s
       ON
           t.list_localpart = s.localpart AND
           t.list_domain = s.domain
       WHERE
           s.owner = v_owner;


``email.sel_mailbox``
``````````````````````````````````````````````````````````````````````

List all mailboxes

.. code-block:: plpgsql

   -- begin userlogin prelude
   v_login := (SELECT t.owner FROM "user"._get_login() AS t);
   v_owner := (SELECT t.act_as FROM "user"._get_login() AS t);
   -- end userlogin prelude
   
   RETURN QUERY
    SELECT
     t.domain,
     t.localpart,
     t.owner,
     t.quota,
     t.backend_status
    FROM
     email.mailbox AS t
    WHERE
     t.owner = v_owner;


``email.sel_redirection``
``````````````````````````````````````````````````````````````````````

Lists all redirections

.. code-block:: plpgsql

   -- begin userlogin prelude
   v_login := (SELECT t.owner FROM "user"._get_login() AS t);
   v_owner := (SELECT t.act_as FROM "user"._get_login() AS t);
   -- end userlogin prelude
   
   RETURN QUERY
    SELECT
     t.domain, 
     t.localpart, 
     t.destination,
     t.backend_status
    FROM
     email.redirection AS t
    WHERE
     t.owner = v_owner;


``email.srv_alias``
``````````````````````````````````````````````````````````````````````

Lists all email aliases

.. code-block:: plpgsql

   v_machine := (SELECT "machine" FROM "backend"._get_login());
   
   RETURN QUERY
       WITH
   
       -- DELETE
       d AS (
           DELETE FROM email.alias AS t
           WHERE
               backend._deleted(t.backend_status) AND
               backend._machine_priviledged(t.service, t.domain)
       ),
   
       -- UPDATE
       s AS (
           UPDATE email.alias AS t
               SET backend_status = NULL
           WHERE
               backend._machine_priviledged(t.service, t.domain) AND
               backend._active(t.backend_status)
       )
   
       -- SELECT
       SELECT
           t.localpart,
           t.domain,
           t.mailbox_localpart,
           t.mailbox_domain,
           t.backend_status
       FROM email.alias AS t
   
       WHERE
           backend._machine_priviledged(t.service, t.domain) AND
           (backend._active(t.backend_status) OR p_include_inactive);


``email.srv_list``
``````````````````````````````````````````````````````````````````````

Lists all mailinglists

.. code-block:: plpgsql

   v_machine := (SELECT "machine" FROM "backend"._get_login());
   
   RETURN QUERY
       WITH
   
       -- DELETE
       d AS (
           DELETE FROM email.list AS t
           WHERE
               backend._deleted(t.backend_status) AND
               backend._machine_priviledged(t.service, t.domain)
       ),
   
       -- UPDATE
       s AS (
           UPDATE email.list AS t
               SET backend_status = NULL
           WHERE
               backend._machine_priviledged(t.service, t.domain) AND
               backend._active(t.backend_status)
       )
   
       -- SELECT
       SELECT
           t.localpart,
           t.domain,
           t.admin,
           t.backend_status
       FROM email.list AS t
   
       WHERE
           backend._machine_priviledged(t.service, t.domain) AND
           (backend._active(t.backend_status) OR p_include_inactive);


``email.srv_list_subscriber``
``````````````````````````````````````````````````````````````````````

Lists all mailinglist subscribers

.. code-block:: plpgsql

   v_machine := (SELECT "machine" FROM "backend"._get_login());
   
   RETURN QUERY
       WITH
   
       -- DELETE
       d AS (
           DELETE FROM email.list_subscriber AS t
           USING email.list AS l
           WHERE
               t.list_domain = l.domain AND
               t.list_localpart = l.localpart AND
   
               backend._deleted(t.backend_status) AND
               backend._machine_priviledged(l.service, l.domain)
       ),
   
       -- UPDATE
       s AS (
           UPDATE email.list_subscriber AS t
               SET backend_status = NULL
           FROM email.list AS l
           WHERE
               t.list_domain = l.domain AND
               t.list_localpart = l.localpart AND
   
               backend._machine_priviledged(l.service, l.domain) AND
               backend._active(t.backend_status)
       )
   
       -- SELECT
       SELECT
           t.list_localpart,
           t.list_domain,
           t.address,
           t.backend_status
       FROM email.list_subscriber AS t
   
       JOIN email.list AS l ON
           t.list_domain = l.domain AND
           t.list_localpart = l.localpart
   
       WHERE
           backend._machine_priviledged(l.service, l.domain) AND
           (backend._active(t.backend_status) OR p_include_inactive);


``email.srv_mailbox``
``````````````````````````````````````````````````````````````````````

Lists all mailboxes

.. code-block:: plpgsql

   v_machine := (SELECT "machine" FROM "backend"._get_login());
   
   RETURN QUERY
       WITH
   
       -- DELETE
       d AS (
           DELETE FROM email.mailbox AS t
           WHERE
               backend._deleted(t.backend_status) AND
               backend._machine_priviledged(t.service, t.domain)
       ),
   
       -- UPDATE
       s AS (
           UPDATE email.mailbox AS t
               SET backend_status = NULL
           WHERE
               backend._machine_priviledged(t.service, t.domain) AND
               backend._active(t.backend_status)
       )
   
       -- SELECT
       SELECT
           t.localpart,
           t.domain,
           t.password,
           t.uid,
           t.quota,
           t.option,
           t.backend_status
       FROM email.mailbox AS t
   
       WHERE
           backend._machine_priviledged(t.service, t.domain) AND
           (backend._active(t.backend_status) OR p_include_inactive);


``email.srv_redirection``
``````````````````````````````````````````````````````````````````````

Lists all mailinglists

.. code-block:: plpgsql

   v_machine := (SELECT "machine" FROM "backend"._get_login());
   
   RETURN QUERY
       WITH
   
       -- DELETE
       d AS (
           DELETE FROM email.redirection AS t
           WHERE
               backend._deleted(t.backend_status) AND
               backend._machine_priviledged(t.service, t.domain)
       ),
   
       -- UPDATE
       s AS (
           UPDATE email.redirection AS t
               SET backend_status = NULL
           WHERE
               backend._machine_priviledged(t.service, t.domain) AND
               backend._active(t.backend_status)
       )
   
       -- SELECT
       SELECT
           t.localpart,
           t.domain,
           t.destination,
           t.backend_status
       FROM email.redirection AS t
   
       WHERE
           backend._machine_priviledged(t.service, t.domain) AND
           (backend._active(t.backend_status) OR p_include_inactive);


``email.upd_list``
``````````````````````````````````````````````````````````````````````

Change list admin

.. code-block:: plpgsql

   -- begin userlogin prelude
   v_login := (SELECT t.owner FROM "user"._get_login() AS t);
   v_owner := (SELECT t.act_as FROM "user"._get_login() AS t);
   -- end userlogin prelude
   
   UPDATE email.list
       SET
           admin = p_admin,
           backend_status = 'upd'
   WHERE
       localpart = p_localpart AND
       domain = p_domain AND
       owner = v_owner AND
       backend._active(backend_status);
   
   PERFORM backend._conditional_notify(FOUND, 'email', 'list', p_domain);


``email.upd_mailbox``
``````````````````````````````````````````````````````````````````````

Change mailbox password

.. code-block:: plpgsql

   -- begin userlogin prelude
   v_login := (SELECT t.owner FROM "user"._get_login() AS t);
   v_owner := (SELECT t.act_as FROM "user"._get_login() AS t);
   -- end userlogin prelude
   
   UPDATE email.mailbox
       SET
           password = commons._hash_password(p_password),
           backend_status = 'upd'
   WHERE
       localpart = p_localpart AND
       domain = p_domain AND
       owner = v_owner AND
       backend._active(backend_status);
   
   PERFORM backend._conditional_notify(FOUND, 'email', 'mailbox', p_domain);



