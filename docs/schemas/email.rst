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


------
Tables
------


.. _TABLE-email.address:

``email.address``
``````````````````````````````````````````````````````````````````````

Collection of all known addresses

Primary key
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







.. _TABLE-email.alias:

``email.alias``
``````````````````````````````````````````````````````````````````````

Aliases for e-mail mailboxes, owner is determined by mailbox.owner

Primary key
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







.. _TABLE-email.list:

``email.list``
``````````````````````````````````````````````````````````````````````

Mailing lists

Primary key
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







.. _TABLE-email.list_subscriber:

``email.list_subscriber``
``````````````````````````````````````````````````````````````````````

list subscribers

Primary key
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







.. _TABLE-email.mailbox:

``email.mailbox``
``````````````````````````````````````````````````````````````````````

E-mail mailboxs correspond to something a mail user can login into. Basically
a mailbox represents a mailbox. A mailbox is bound to a specific address.
Further addresses can be linked to mailboxs via aliases.

Primary key
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







.. _TABLE-email.redirection:

``email.redirection``
``````````````````````````````````````````````````````````````````````

Redirections

Primary key
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









---------
Functions
---------



.. _FUNCTION-email._address:

``email._address``
``````````````````````````````````````````````````````````````````````

List all addresses

Parameters
 *None*



Returns
 TABLE

Returned columns
 - ``localpart`` :ref:`email.t_localpart <DOMAIN-email.t_localpart>`
   
 - ``domain`` :ref:`dns.t_domain <DOMAIN-dns.t_domain>`
   
 - ``owner`` :ref:`user.t_user <DOMAIN-user.t_user>`
   
 - ``subservice`` :ref:`commons.t_key <DOMAIN-commons.t_key>`
   


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



.. _FUNCTION-email._address_valid:

``email._address_valid``
``````````````````````````````````````````````````````````````````````

x

Parameters
 - ``p_localpart`` :ref:`email.t_localpart <DOMAIN-email.t_localpart>`
   
    
 - ``p_domain`` :ref:`dns.t_domain <DOMAIN-dns.t_domain>`
   
    



Returns
 void



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



.. _FUNCTION-email.del_alias:

``email.del_alias``
``````````````````````````````````````````````````````````````````````

Delete Alias

Parameters
 - ``p_localpart`` :ref:`email.t_localpart <DOMAIN-email.t_localpart>`
   
    
 - ``p_domain`` :ref:`dns.t_domain <DOMAIN-dns.t_domain>`
   
    
 - ``p_mailbox_localpart`` :ref:`email.t_localpart <DOMAIN-email.t_localpart>`
   
    
 - ``p_mailbox_domain`` :ref:`dns.t_domain <DOMAIN-dns.t_domain>`
   
    


Variables defined for body
 - ``v_owner`` :ref:`user.t_user <DOMAIN-user.t_user>`
   
   
 - ``v_login`` :ref:`user.t_user <DOMAIN-user.t_user>`
   
   

Returns
 void


Execute privilege
 - :ref:`userlogin <ROLE-userlogin>`

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



.. _FUNCTION-email.del_list:

``email.del_list``
``````````````````````````````````````````````````````````````````````

Delete mailing list

Parameters
 - ``p_domain`` :ref:`dns.t_domain <DOMAIN-dns.t_domain>`
   
    
 - ``p_localpart`` :ref:`email.t_localpart <DOMAIN-email.t_localpart>`
   
    


Variables defined for body
 - ``v_owner`` :ref:`user.t_user <DOMAIN-user.t_user>`
   
   
 - ``v_login`` :ref:`user.t_user <DOMAIN-user.t_user>`
   
   

Returns
 void


Execute privilege
 - :ref:`userlogin <ROLE-userlogin>`

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



.. _FUNCTION-email.del_list_subscriber:

``email.del_list_subscriber``
``````````````````````````````````````````````````````````````````````

del

Parameters
 - ``p_list_localpart`` :ref:`email.t_localpart <DOMAIN-email.t_localpart>`
   
    
 - ``p_list_domain`` :ref:`dns.t_domain <DOMAIN-dns.t_domain>`
   
    
 - ``p_address`` :ref:`email.t_address <DOMAIN-email.t_address>`
   
    


Variables defined for body
 - ``v_owner`` :ref:`user.t_user <DOMAIN-user.t_user>`
   
   
 - ``v_login`` :ref:`user.t_user <DOMAIN-user.t_user>`
   
   

Returns
 void


Execute privilege
 - :ref:`userlogin <ROLE-userlogin>`

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



.. _FUNCTION-email.del_mailbox:

``email.del_mailbox``
``````````````````````````````````````````````````````````````````````

Delete mailbox

Parameters
 - ``p_localpart`` :ref:`email.t_localpart <DOMAIN-email.t_localpart>`
   
    
 - ``p_domain`` :ref:`dns.t_domain <DOMAIN-dns.t_domain>`
   
    


Variables defined for body
 - ``v_owner`` :ref:`user.t_user <DOMAIN-user.t_user>`
   
   
 - ``v_login`` :ref:`user.t_user <DOMAIN-user.t_user>`
   
   

Returns
 void


Execute privilege
 - :ref:`userlogin <ROLE-userlogin>`

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



.. _FUNCTION-email.del_redirection:

``email.del_redirection``
``````````````````````````````````````````````````````````````````````

Delete redirection

Parameters
 - ``p_localpart`` :ref:`email.t_localpart <DOMAIN-email.t_localpart>`
   
    
 - ``p_domain`` :ref:`dns.t_domain <DOMAIN-dns.t_domain>`
   
    


Variables defined for body
 - ``v_owner`` :ref:`user.t_user <DOMAIN-user.t_user>`
   
   
 - ``v_login`` :ref:`user.t_user <DOMAIN-user.t_user>`
   
   

Returns
 void


Execute privilege
 - :ref:`userlogin <ROLE-userlogin>`

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



.. _FUNCTION-email.ins_alias:

``email.ins_alias``
``````````````````````````````````````````````````````````````````````

Create e-mail aliases

Parameters
 - ``p_localpart`` :ref:`email.t_localpart <DOMAIN-email.t_localpart>`
   
    
 - ``p_domain`` :ref:`dns.t_domain <DOMAIN-dns.t_domain>`
   
    
 - ``p_mailbox_localpart`` :ref:`email.t_localpart <DOMAIN-email.t_localpart>`
   
    
 - ``p_mailbox_domain`` :ref:`dns.t_domain <DOMAIN-dns.t_domain>`
   
    


Variables defined for body
 - ``v_subservice`` :ref:`commons.t_key <DOMAIN-commons.t_key>`
   (default: ``'alias'``)
   
 - ``v_num_total`` :ref:`int <DOMAIN-int>`
   
   
 - ``v_num_domain`` :ref:`int <DOMAIN-int>`
   
   
 - ``v_owner`` :ref:`user.t_user <DOMAIN-user.t_user>`
   
   
 - ``v_login`` :ref:`user.t_user <DOMAIN-user.t_user>`
   
   

Returns
 void


Execute privilege
 - :ref:`userlogin <ROLE-userlogin>`

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



.. _FUNCTION-email.ins_list:

``email.ins_list``
``````````````````````````````````````````````````````````````````````

Creates a mailing list

Parameters
 - ``p_localpart`` :ref:`email.t_localpart <DOMAIN-email.t_localpart>`
   
    
 - ``p_domain`` :ref:`dns.t_domain <DOMAIN-dns.t_domain>`
   
    
 - ``p_admin`` :ref:`email.t_address <DOMAIN-email.t_address>`
   
    


Variables defined for body
 - ``v_subservice`` :ref:`commons.t_key <DOMAIN-commons.t_key>`
   (default: ``'list'``)
   
 - ``v_num_total`` :ref:`int <DOMAIN-int>`
   
   
 - ``v_num_domain`` :ref:`int <DOMAIN-int>`
   
   
 - ``v_owner`` :ref:`user.t_user <DOMAIN-user.t_user>`
   
   
 - ``v_login`` :ref:`user.t_user <DOMAIN-user.t_user>`
   
   

Returns
 void


Execute privilege
 - :ref:`userlogin <ROLE-userlogin>`

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



.. _FUNCTION-email.ins_list_subscriber:

``email.ins_list_subscriber``
``````````````````````````````````````````````````````````````````````

Adds a subscriber to a mailing list

Parameters
 - ``p_address`` :ref:`email.t_address <DOMAIN-email.t_address>`
   
    
 - ``p_list_localpart`` :ref:`email.t_localpart <DOMAIN-email.t_localpart>`
   
    
 - ``p_list_domain`` :ref:`dns.t_domain <DOMAIN-dns.t_domain>`
   
    


Variables defined for body
 - ``v_owner`` :ref:`user.t_user <DOMAIN-user.t_user>`
   
   
 - ``v_login`` :ref:`user.t_user <DOMAIN-user.t_user>`
   
   

Returns
 void


Execute privilege
 - :ref:`userlogin <ROLE-userlogin>`

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



.. _FUNCTION-email.ins_mailbox:

``email.ins_mailbox``
``````````````````````````````````````````````````````````````````````

Creates an email box

Parameters
 - ``p_localpart`` :ref:`email.t_localpart <DOMAIN-email.t_localpart>`
   
    
 - ``p_domain`` :ref:`dns.t_domain <DOMAIN-dns.t_domain>`
   
    
 - ``p_password`` :ref:`commons.t_password_plaintext <DOMAIN-commons.t_password_plaintext>`
   
    


Variables defined for body
 - ``v_subservice`` :ref:`commons.t_key <DOMAIN-commons.t_key>`
   (default: ``'mailbox'``)
   
 - ``v_num_total`` :ref:`int <DOMAIN-int>`
   
   
 - ``v_num_domain`` :ref:`int <DOMAIN-int>`
   
   
 - ``v_owner`` :ref:`user.t_user <DOMAIN-user.t_user>`
   
   
 - ``v_login`` :ref:`user.t_user <DOMAIN-user.t_user>`
   
   

Returns
 void


Execute privilege
 - :ref:`userlogin <ROLE-userlogin>`

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



.. _FUNCTION-email.ins_redirection:

``email.ins_redirection``
``````````````````````````````````````````````````````````````````````

Creates a redirection

Parameters
 - ``p_localpart`` :ref:`email.t_localpart <DOMAIN-email.t_localpart>`
   
    
 - ``p_domain`` :ref:`dns.t_domain <DOMAIN-dns.t_domain>`
   
    
 - ``p_destination`` :ref:`email.t_address <DOMAIN-email.t_address>`
   
    


Variables defined for body
 - ``v_subservice`` :ref:`commons.t_key <DOMAIN-commons.t_key>`
   (default: ``'redirection'``)
   
 - ``v_num_total`` :ref:`int <DOMAIN-int>`
   
   
 - ``v_num_domain`` :ref:`int <DOMAIN-int>`
   
   
 - ``v_owner`` :ref:`user.t_user <DOMAIN-user.t_user>`
   
   
 - ``v_login`` :ref:`user.t_user <DOMAIN-user.t_user>`
   
   

Returns
 void


Execute privilege
 - :ref:`userlogin <ROLE-userlogin>`

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



.. _FUNCTION-email.sel_alias:

``email.sel_alias``
``````````````````````````````````````````````````````````````````````

Select aliases

Parameters
 *None*


Variables defined for body
 - ``v_owner`` :ref:`user.t_user <DOMAIN-user.t_user>`
   
   
 - ``v_login`` :ref:`user.t_user <DOMAIN-user.t_user>`
   
   

Returns
 TABLE

Returned columns
 - ``localpart`` :ref:`email.t_localpart <DOMAIN-email.t_localpart>`
   
 - ``domain`` :ref:`dns.t_domain <DOMAIN-dns.t_domain>`
   
 - ``mailbox_localpart`` :ref:`email.t_localpart <DOMAIN-email.t_localpart>`
   
 - ``mailbox_domain`` :ref:`dns.t_domain <DOMAIN-dns.t_domain>`
   
 - ``backend_status`` :ref:`backend.t_status <DOMAIN-backend.t_status>`
   

Execute privilege
 - :ref:`userlogin <ROLE-userlogin>`

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



.. _FUNCTION-email.sel_list:

``email.sel_list``
``````````````````````````````````````````````````````````````````````

List all lists

Parameters
 *None*


Variables defined for body
 - ``v_owner`` :ref:`user.t_user <DOMAIN-user.t_user>`
   
   
 - ``v_login`` :ref:`user.t_user <DOMAIN-user.t_user>`
   
   

Returns
 TABLE

Returned columns
 - ``domain`` :ref:`dns.t_domain <DOMAIN-dns.t_domain>`
   
 - ``localpart`` :ref:`email.t_localpart <DOMAIN-email.t_localpart>`
   
 - ``owner`` :ref:`user.t_user <DOMAIN-user.t_user>`
   
 - ``admin`` :ref:`email.t_address <DOMAIN-email.t_address>`
   
 - ``backend_status`` :ref:`backend.t_status <DOMAIN-backend.t_status>`
   
 - ``num_subscribers`` :ref:`bigint <DOMAIN-bigint>`
   

Execute privilege
 - :ref:`userlogin <ROLE-userlogin>`

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



.. _FUNCTION-email.sel_list_subscriber:

``email.sel_list_subscriber``
``````````````````````````````````````````````````````````````````````

a

Parameters
 *None*


Variables defined for body
 - ``v_owner`` :ref:`user.t_user <DOMAIN-user.t_user>`
   
   
 - ``v_login`` :ref:`user.t_user <DOMAIN-user.t_user>`
   
   

Returns
 TABLE

Returned columns
 - ``address`` :ref:`email.t_address <DOMAIN-email.t_address>`
   
 - ``list_localpart`` :ref:`email.t_localpart <DOMAIN-email.t_localpart>`
   
 - ``list_domain`` :ref:`dns.t_domain <DOMAIN-dns.t_domain>`
   
 - ``backend_status`` :ref:`backend.t_status <DOMAIN-backend.t_status>`
   

Execute privilege
 - :ref:`userlogin <ROLE-userlogin>`

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



.. _FUNCTION-email.sel_mailbox:

``email.sel_mailbox``
``````````````````````````````````````````````````````````````````````

List all mailboxes

Parameters
 *None*


Variables defined for body
 - ``v_owner`` :ref:`user.t_user <DOMAIN-user.t_user>`
   
   
 - ``v_login`` :ref:`user.t_user <DOMAIN-user.t_user>`
   
   

Returns
 TABLE

Returned columns
 - ``domain`` :ref:`dns.t_domain <DOMAIN-dns.t_domain>`
   
 - ``localpart`` :ref:`email.t_localpart <DOMAIN-email.t_localpart>`
   
 - ``owner`` :ref:`user.t_user <DOMAIN-user.t_user>`
   
 - ``quota`` :ref:`int <DOMAIN-int>`
   
 - ``backend_status`` :ref:`backend.t_status <DOMAIN-backend.t_status>`
   

Execute privilege
 - :ref:`userlogin <ROLE-userlogin>`

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



.. _FUNCTION-email.sel_redirection:

``email.sel_redirection``
``````````````````````````````````````````````````````````````````````

Lists all redirections

Parameters
 *None*


Variables defined for body
 - ``v_owner`` :ref:`user.t_user <DOMAIN-user.t_user>`
   
   
 - ``v_login`` :ref:`user.t_user <DOMAIN-user.t_user>`
   
   

Returns
 TABLE

Returned columns
 - ``domain`` :ref:`dns.t_domain <DOMAIN-dns.t_domain>`
   
 - ``localpart`` :ref:`email.t_localpart <DOMAIN-email.t_localpart>`
   
 - ``destination`` :ref:`email.t_address <DOMAIN-email.t_address>`
   
 - ``backend_status`` :ref:`backend.t_status <DOMAIN-backend.t_status>`
   

Execute privilege
 - :ref:`userlogin <ROLE-userlogin>`

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



.. _FUNCTION-email.srv_alias:

``email.srv_alias``
``````````````````````````````````````````````````````````````````````

Lists all email aliases

Parameters
 - ``p_include_inactive`` :ref:`boolean <DOMAIN-boolean>`
   
    


Variables defined for body
 - ``v_machine`` :ref:`dns.t_domain <DOMAIN-dns.t_domain>`
   
   

Returns
 TABLE

Returned columns
 - ``localpart`` :ref:`email.t_localpart <DOMAIN-email.t_localpart>`
   
 - ``domain`` :ref:`dns.t_domain <DOMAIN-dns.t_domain>`
   
 - ``mailbox_localpart`` :ref:`email.t_localpart <DOMAIN-email.t_localpart>`
   
 - ``mailbox_domain`` :ref:`dns.t_domain <DOMAIN-dns.t_domain>`
   
 - ``backend_status`` :ref:`backend.t_status <DOMAIN-backend.t_status>`
   

Execute privilege
 - :ref:`backend <ROLE-backend>`

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



.. _FUNCTION-email.srv_list:

``email.srv_list``
``````````````````````````````````````````````````````````````````````

Lists all mailinglists

Parameters
 - ``p_include_inactive`` :ref:`boolean <DOMAIN-boolean>`
   
    


Variables defined for body
 - ``v_machine`` :ref:`dns.t_domain <DOMAIN-dns.t_domain>`
   
   

Returns
 TABLE

Returned columns
 - ``localpart`` :ref:`email.t_localpart <DOMAIN-email.t_localpart>`
   
 - ``domain`` :ref:`dns.t_domain <DOMAIN-dns.t_domain>`
   
 - ``admin`` :ref:`email.t_address <DOMAIN-email.t_address>`
   
 - ``backend_status`` :ref:`backend.t_status <DOMAIN-backend.t_status>`
   

Execute privilege
 - :ref:`backend <ROLE-backend>`

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



.. _FUNCTION-email.srv_list_subscriber:

``email.srv_list_subscriber``
``````````````````````````````````````````````````````````````````````

Lists all mailinglist subscribers

Parameters
 - ``p_include_inactive`` :ref:`boolean <DOMAIN-boolean>`
   
    


Variables defined for body
 - ``v_machine`` :ref:`dns.t_domain <DOMAIN-dns.t_domain>`
   
   

Returns
 TABLE

Returned columns
 - ``localpart`` :ref:`email.t_localpart <DOMAIN-email.t_localpart>`
   
 - ``domain`` :ref:`dns.t_domain <DOMAIN-dns.t_domain>`
   
 - ``address`` :ref:`email.t_address <DOMAIN-email.t_address>`
   
 - ``backend_status`` :ref:`backend.t_status <DOMAIN-backend.t_status>`
   

Execute privilege
 - :ref:`backend <ROLE-backend>`

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



.. _FUNCTION-email.srv_mailbox:

``email.srv_mailbox``
``````````````````````````````````````````````````````````````````````

Lists all mailboxes

Parameters
 - ``p_include_inactive`` :ref:`boolean <DOMAIN-boolean>`
   
    


Variables defined for body
 - ``v_machine`` :ref:`dns.t_domain <DOMAIN-dns.t_domain>`
   
   

Returns
 TABLE

Returned columns
 - ``localpart`` :ref:`email.t_localpart <DOMAIN-email.t_localpart>`
   
 - ``domain`` :ref:`dns.t_domain <DOMAIN-dns.t_domain>`
   
 - ``password`` :ref:`commons.t_password <DOMAIN-commons.t_password>`
   
 - ``uid`` :ref:`integer <DOMAIN-integer>`
   
 - ``quota`` :ref:`integer <DOMAIN-integer>`
   
 - ``option`` :ref:`jsonb <DOMAIN-jsonb>`
   
 - ``backend_status`` :ref:`backend.t_status <DOMAIN-backend.t_status>`
   

Execute privilege
 - :ref:`backend <ROLE-backend>`

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



.. _FUNCTION-email.srv_redirection:

``email.srv_redirection``
``````````````````````````````````````````````````````````````````````

Lists all mailinglists

Parameters
 - ``p_include_inactive`` :ref:`boolean <DOMAIN-boolean>`
   
    


Variables defined for body
 - ``v_machine`` :ref:`dns.t_domain <DOMAIN-dns.t_domain>`
   
   

Returns
 TABLE

Returned columns
 - ``localpart`` :ref:`email.t_localpart <DOMAIN-email.t_localpart>`
   
 - ``domain`` :ref:`dns.t_domain <DOMAIN-dns.t_domain>`
   
 - ``destination`` :ref:`email.t_address <DOMAIN-email.t_address>`
   
 - ``backend_status`` :ref:`backend.t_status <DOMAIN-backend.t_status>`
   

Execute privilege
 - :ref:`backend <ROLE-backend>`

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



.. _FUNCTION-email.upd_list:

``email.upd_list``
``````````````````````````````````````````````````````````````````````

Change list admin

Parameters
 - ``p_localpart`` :ref:`email.t_localpart <DOMAIN-email.t_localpart>`
   
    
 - ``p_domain`` :ref:`dns.t_domain <DOMAIN-dns.t_domain>`
   
    
 - ``p_admin`` :ref:`email.t_address <DOMAIN-email.t_address>`
   
    


Variables defined for body
 - ``v_owner`` :ref:`user.t_user <DOMAIN-user.t_user>`
   
   
 - ``v_login`` :ref:`user.t_user <DOMAIN-user.t_user>`
   
   

Returns
 void


Execute privilege
 - :ref:`userlogin <ROLE-userlogin>`

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



.. _FUNCTION-email.upd_mailbox:

``email.upd_mailbox``
``````````````````````````````````````````````````````````````````````

Change mailbox password

Parameters
 - ``p_localpart`` :ref:`email.t_localpart <DOMAIN-email.t_localpart>`
   
    
 - ``p_domain`` :ref:`dns.t_domain <DOMAIN-dns.t_domain>`
   
    
 - ``p_password`` :ref:`commons.t_password_plaintext <DOMAIN-commons.t_password_plaintext>`
   
    


Variables defined for body
 - ``v_owner`` :ref:`user.t_user <DOMAIN-user.t_user>`
   
   
 - ``v_login`` :ref:`user.t_user <DOMAIN-user.t_user>`
   
   

Returns
 void


Execute privilege
 - :ref:`userlogin <ROLE-userlogin>`

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




-------
Domains
-------



.. _DOMAIN-email.t_localpart:

``email.t_localpart``
```````````````````````````````````````````````````````````````````````

Local part of an email address, the thing in front of the @

Checks
 - *valid_characters*

   .. code-block:: sql
   
    VALUE ~ '^[a-z0-9.-]+$'

   Only allow lower-case addresses

 - *no_starting_dot*

   .. code-block:: sql
   
    left(VALUE, 1) <> '.'

   b

 - *no_ending_dot*

   .. code-block:: sql
   
    right(VALUE, 1) <> '.'

   c




.. _DOMAIN-email.t_address:

``email.t_address``
```````````````````````````````````````````````````````````````````````

Email address, TODO validity checks







