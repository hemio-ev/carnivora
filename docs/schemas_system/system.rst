system
======================================================================

Carnivora System

Manages services, service entities and contingents.

.. contents:: Schema Contents
   :local:
   :depth: 2



Tables
------


.. _TABLE-system.inherit_contingent:

``system.inherit_contingent``
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Contingents inherited from other users.

Precedence is unambiguous via primary key.

Primary key
 - owner
 - priority


.. BEGIN FKs


.. END FKs


Columns
 - .. _COLUMN-system.inherit_contingent.owner:
   
   ``owner`` :ref:`user.t_user <DOMAIN-user.t_user>`
     Owner


   References :ref:`user.user.owner <COLUMN-user.user.owner>`

   On Delete: CASCADE

   On Update: CASCADE

 - .. _COLUMN-system.inherit_contingent.donor:
   
   ``donor`` :ref:`user.t_user <DOMAIN-user.t_user>`
     Donor of contingent


   References :ref:`user.user.owner <COLUMN-user.user.owner>`

   On Delete: CASCADE

   On Update: CASCADE

 - .. _COLUMN-system.inherit_contingent.priority:
   
   ``priority`` :ref:`int <DOMAIN-int>`
     Priority, higher values take precedence







.. _TABLE-system.service:

``system.service``
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Services

Just a list of services that exist. Modules do register their services here.
Use system._setup_register_service(<module>, <service>) to insert into this
table.

Primary key
 - service


.. BEGIN FKs


.. END FKs


Columns
 - .. _COLUMN-system.service.service:
   
   ``service`` :ref:`commons.t_key <DOMAIN-commons.t_key>`
     Service name





 - .. _COLUMN-system.service.module:
   
   ``module`` :ref:`commons.t_key <DOMAIN-commons.t_key>`
     Module name, just to keep track who uses this name







.. _TABLE-system.service_entity:

``system.service_entity``
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

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

Primary key
 - service_entity_name
 - service


.. BEGIN FKs


.. END FKs


Columns
 - .. _COLUMN-system.service_entity.service_entity_name:
   
   ``service_entity_name`` :ref:`dns.t_hostname <DOMAIN-dns.t_hostname>`
     Host name





 - .. _COLUMN-system.service_entity.service:
   
   ``service`` :ref:`commons.t_key <DOMAIN-commons.t_key>`
     email, ssh, ...


   References :ref:`system.service.service <COLUMN-system.service.service>`





.. _TABLE-system.service_entity_dns:

``system.service_entity_dns``
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Service Entity DNS

Resource records that have to be present to use a service. The records
in this table can be understood as 'templates'. The table does not
contain a name (domain) for the records. Rather for every domain that
uses this service, all appropriate records are created for this domain
based on this table. The assignment from domain to services can
be found in dns.service.

Primary key
 - id


.. BEGIN FKs

Foreign keys
 - Reference service entity

   Local Columns
    - service_entity_name
    - service

   Referenced Columns
    - :ref:`system.service_entity.service_entity_name <COLUMN-system.service_entity.service_entity_name>`
    - :ref:`system.service_entity.service <COLUMN-system.service_entity.service>`


.. END FKs


Columns
 - .. _COLUMN-system.service_entity_dns.service_entity_name:
   
   ``service_entity_name`` :ref:`dns.t_hostname <DOMAIN-dns.t_hostname>`
     Service entity name





 - .. _COLUMN-system.service_entity_dns.service:
   
   ``service`` :ref:`commons.t_key <DOMAIN-commons.t_key>`
     Service (e.g. email, jabber)





 - .. _COLUMN-system.service_entity_dns.type:
   
   ``type`` :ref:`dns.t_type <DOMAIN-dns.t_type>`
     Type (A, AAAA, CNAME, MX, SRV, TXT, ...)





 - .. _COLUMN-system.service_entity_dns.rdata:
   
   ``rdata`` :ref:`dns.t_rdata <DOMAIN-dns.t_rdata>`
     fancy rdata storage





 - .. _COLUMN-system.service_entity_dns.ttl:
   
   ``ttl`` *NULL* | :ref:`dns.t_ttl <DOMAIN-dns.t_ttl>`
     Time to live, NULL indicates default value





 - .. _COLUMN-system.service_entity_dns.id:
   
   ``id`` :ref:`uuid <DOMAIN-uuid>`
     uuid serial number to identify database elements uniquely

   Default
    .. code-block:: sql

     commons._uuid()




 - .. _COLUMN-system.service_entity_dns.domain_prefix:
   
   ``domain_prefix`` *NULL* | :ref:`varchar <DOMAIN-varchar>`
     Domain prefix







.. _TABLE-system.service_entity_machine:

``system.service_entity_machine``
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Service Entity Machine

List of machines that provice a certain service. This information is
used to provide these machines access to the data they need to provide
the service. See also the module 'backend'.

Primary key
 - machine_name
 - service_entity_name
 - service


.. BEGIN FKs

Foreign keys
 - Reference service entity

   Local Columns
    - service_entity_name
    - service

   Referenced Columns
    - :ref:`system.service_entity.service_entity_name <COLUMN-system.service_entity.service_entity_name>`
    - :ref:`system.service_entity.service <COLUMN-system.service_entity.service>`


.. END FKs


Columns
 - .. _COLUMN-system.service_entity_machine.service_entity_name:
   
   ``service_entity_name`` :ref:`dns.t_hostname <DOMAIN-dns.t_hostname>`
     Service entity name





 - .. _COLUMN-system.service_entity_machine.service:
   
   ``service`` :ref:`commons.t_key <DOMAIN-commons.t_key>`
     Service (e.g. email, jabber)





 - .. _COLUMN-system.service_entity_machine.machine_name:
   
   ``machine_name`` :ref:`dns.t_hostname <DOMAIN-dns.t_hostname>`
     Assigns machine


   References :ref:`backend.machine.name <COLUMN-backend.machine.name>`





.. _TABLE-system.subservice:

``system.subservice``
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Subservices

Primary key
 - service
 - subservice


.. BEGIN FKs


.. END FKs


Columns
 - .. _COLUMN-system.subservice.service:
   
   ``service`` :ref:`commons.t_key <DOMAIN-commons.t_key>`
     Service


   References :ref:`system.service.service <COLUMN-system.service.service>`



 - .. _COLUMN-system.subservice.subservice:
   
   ``subservice`` :ref:`commons.t_key <DOMAIN-commons.t_key>`
     Subservice (concretization the service)







.. _TABLE-system.subservice_entity:

``system.subservice_entity``
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Subservice Entity

Names under which subservices are made available.

See also: Table system.service_entity

Primary key
 - service_entity_name
 - service
 - subservice


.. BEGIN FKs

Foreign keys
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
 - .. _COLUMN-system.subservice_entity.service_entity_name:
   
   ``service_entity_name`` :ref:`dns.t_hostname <DOMAIN-dns.t_hostname>`
     Service entity name





 - .. _COLUMN-system.subservice_entity.service:
   
   ``service`` :ref:`commons.t_key <DOMAIN-commons.t_key>`
     Service name





 - .. _COLUMN-system.subservice_entity.subservice:
   
   ``subservice`` :ref:`commons.t_key <DOMAIN-commons.t_key>`
     account, alias, ...







.. _TABLE-system.subservice_entity_contingent:

``system.subservice_entity_contingent``
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Subservice entity contingent

Primary key
 - service
 - subservice
 - service_entity_name
 - owner


.. BEGIN FKs

Foreign keys
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
 - .. _COLUMN-system.subservice_entity_contingent.service_entity_name:
   
   ``service_entity_name`` :ref:`dns.t_hostname <DOMAIN-dns.t_hostname>`
     Service entity name





 - .. _COLUMN-system.subservice_entity_contingent.service:
   
   ``service`` :ref:`commons.t_key <DOMAIN-commons.t_key>`
     Service (e.g. email, jabber)





 - .. _COLUMN-system.subservice_entity_contingent.subservice:
   
   ``subservice`` :ref:`commons.t_key <DOMAIN-commons.t_key>`
     Subservice (e.g. account, alias)





 - .. _COLUMN-system.subservice_entity_contingent.owner:
   
   ``owner`` :ref:`user.t_user <DOMAIN-user.t_user>`
     Owner


   References :ref:`user.user.owner <COLUMN-user.user.owner>`

   On Delete: CASCADE

   On Update: CASCADE

 - .. _COLUMN-system.subservice_entity_contingent.domain_contingent:
   
   ``domain_contingent`` :ref:`integer <DOMAIN-integer>`
     Limit per domain





 - .. _COLUMN-system.subservice_entity_contingent.total_contingent:
   
   ``total_contingent`` :ref:`integer <DOMAIN-integer>`
     Limit on the total







.. _TABLE-system.subservice_entity_domain_contingent:

``system.subservice_entity_domain_contingent``
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Subservice entity per domain contingent

Primary key
 - service
 - subservice
 - service_entity_name
 - domain
 - owner


.. BEGIN FKs

Foreign keys
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
 - .. _COLUMN-system.subservice_entity_domain_contingent.service_entity_name:
   
   ``service_entity_name`` :ref:`dns.t_hostname <DOMAIN-dns.t_hostname>`
     Service entity name





 - .. _COLUMN-system.subservice_entity_domain_contingent.service:
   
   ``service`` :ref:`commons.t_key <DOMAIN-commons.t_key>`
     Service (e.g. email, jabber)





 - .. _COLUMN-system.subservice_entity_domain_contingent.subservice:
   
   ``subservice`` :ref:`commons.t_key <DOMAIN-commons.t_key>`
     Subservice (e.g. account, alias)





 - .. _COLUMN-system.subservice_entity_domain_contingent.owner:
   
   ``owner`` :ref:`user.t_user <DOMAIN-user.t_user>`
     Owner


   References :ref:`user.user.owner <COLUMN-user.user.owner>`

   On Delete: CASCADE

   On Update: CASCADE

 - .. _COLUMN-system.subservice_entity_domain_contingent.domain:
   
   ``domain`` :ref:`dns.t_hostname <DOMAIN-dns.t_hostname>`
     Specific domain for which the access is granted





 - .. _COLUMN-system.subservice_entity_domain_contingent.domain_contingent:
   
   ``domain_contingent`` :ref:`integer <DOMAIN-integer>`
     Limit per domain










Functions
---------



.. _FUNCTION-system._contingent_ensure:

``system._contingent_ensure``
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Throws exceptions if the contingent is exceeded

Parameters
 - ``p_owner`` :ref:`user.t_user <DOMAIN-user.t_user>`
   
    
 - ``p_service`` :ref:`commons.t_key <DOMAIN-commons.t_key>`
   
    
 - ``p_subservice`` :ref:`commons.t_key <DOMAIN-commons.t_key>`
   
    
 - ``p_domain`` :ref:`dns.t_hostname <DOMAIN-dns.t_hostname>`
   
    
 - ``p_current_quantity_total`` :ref:`integer <DOMAIN-integer>`
   
    
 - ``p_current_quantity_domain`` :ref:`integer <DOMAIN-integer>`
   
    


Variables defined for body
 - ``v_remaining`` :ref:`integer <DOMAIN-integer>`
   
   
 - ``v_total_contingent`` :ref:`integer <DOMAIN-integer>`
   
   
 - ``v_domain_contingent`` :ref:`integer <DOMAIN-integer>`
   
   
 - ``v_domain_contingent_default`` :ref:`integer <DOMAIN-integer>`
   
   
 - ``v_domain_contingent_specific`` :ref:`integer <DOMAIN-integer>`
   
   
 - ``v_service_entity_name`` :ref:`dns.t_hostname <DOMAIN-dns.t_hostname>`
   
   
 - ``v_domain_owner`` :ref:`user.t_user <DOMAIN-user.t_user>`
   
   

Returns
 void



.. code-block:: plpgsql

   
   IF p_owner IS NULL
   THEN
       RAISE 'Owner argument must not be NULL.';
   END IF;
   
   SELECT
       t.service_entity_name,
       s.owner
   INTO
       v_service_entity_name,
       v_domain_owner
   FROM dns.service AS t
   JOIN dns.registered AS s
       ON s.domain = t.registered
   
   WHERE
       t.domain = p_domain AND
       t.service = p_service;
   
   -- check dns.service entry
   IF v_domain_owner IS NULL
   THEN
       RAISE 'Contingent check impossible, since dns.service entry missing.'
           USING
               DETAIL = '$carnivora:system:no_contingent$',
               HINT = (p_owner, p_service, p_domain);
   END IF;
   
   SELECT domain_contingent, total_contingent
       INTO v_domain_contingent_default, v_total_contingent
   FROM system._effective_contingent()
   WHERE
       service = p_service AND
       subservice = p_subservice AND
       service_entity_name = v_service_entity_name AND
       owner = p_owner
   ;
   
   SELECT domain_contingent
       INTO v_domain_contingent_specific
   FROM system._effective_contingent_hostname()
   WHERE
       service = p_service AND
       subservice = p_subservice AND
       service_entity_name = v_service_entity_name AND
       owner = p_owner
   ;
   
   v_domain_contingent :=
       COALESCE(v_domain_contingent_default, v_domain_contingent_specific);
   
   IF
       v_total_contingent IS NULL AND
       v_domain_contingent IS NULL
   THEN
       RAISE 'You do no have a contingent'
           USING
               DETAIL = '$carnivora:system:no_contingent$',
               HINT = (p_owner, p_service, v_service_entity_name);
   END IF;
   
   IF v_domain_contingent IS NULL AND p_owner <> v_domain_owner
   THEN
       RAISE 'You are not the owner of the registered domain'
           USING
               DETAIL = '$carnivora:system:contingent_not_owner$',
               HINT = (p_owner, p_service, v_service_entity_name);
   END IF;
   
   IF v_total_contingent <= p_current_quantity_total
   THEN
       RAISE 'Total contingent exceeded'
           USING
               DETAIL = '$carnivora:system:contingent_total_exceeded$',
               HINT = (p_owner, p_service, p_domain, v_total_contingent);
   END IF;
   
   IF v_domain_contingent <= p_current_quantity_domain
   THEN
       RAISE 'Domain contingent exceeded'
           USING
               DETAIL = '$carnivora:system:contingent_hostname_exceeded$',
               HINT = (p_owner, p_service, p_domain, v_domain_contingent);
   END IF;



.. _FUNCTION-system._contingent_total:

``system._contingent_total``
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Contingent

Parameters
 - ``p_owner`` :ref:`user.t_user <DOMAIN-user.t_user>`
   
    
 - ``p_service`` :ref:`commons.t_key <DOMAIN-commons.t_key>`
   
    
 - ``p_service_entity_name`` :ref:`dns.t_hostname <DOMAIN-dns.t_hostname>`
   
    


Variables defined for body
 - ``v_user`` :ref:`integer <DOMAIN-integer>`
   
   
 - ``v_default`` :ref:`integer <DOMAIN-integer>`
   
   

Returns
 integer



.. code-block:: plpgsql

   
   v_user := (
       SELECT t.quantity
       FROM system.contingent_total AS t
       WHERE
           t.owner = p_owner AND
           t.service = p_service AND
           t.service_entity_name = p_service_entity_name
   );
   
   v_default := (
       SELECT t.quantity
       FROM system.contingent_default_total AS t
       WHERE
           t.service = p_service AND
           t.service_entity_name = p_service_entity_name
   );
   
   RETURN COALESCE(v_user, v_default);



.. _FUNCTION-system._effective_contingent:

``system._effective_contingent``
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

contingent

Parameters
 *None*



Returns
 TABLE

Returned columns
 - ``service`` :ref:`commons.t_key <DOMAIN-commons.t_key>`
    
 - ``subservice`` :ref:`commons.t_key <DOMAIN-commons.t_key>`
    
 - ``service_entity_name`` :ref:`dns.t_hostname <DOMAIN-dns.t_hostname>`
    
 - ``owner`` :ref:`user.t_user <DOMAIN-user.t_user>`
    
 - ``domain_contingent`` :ref:`int <DOMAIN-int>`
    
 - ``total_contingent`` :ref:`int <DOMAIN-int>`
    


.. code-block:: plpgsql

   
   RETURN QUERY
    SELECT
     DISTINCT ON
     (contingent.service, contingent.subservice, contingent.service_entity_name, usr.owner)
     contingent.service,
     contingent.subservice,
     contingent.service_entity_name,
     usr.owner,
     contingent.domain_contingent,
     contingent.total_contingent
    FROM system.subservice_entity_contingent AS contingent
   
    CROSS JOIN "user"."user" AS usr
   
    JOIN system._inherit_contingent_donor(usr.owner) AS des
      ON des.donor = contingent.owner
   
    ORDER BY
     contingent.service,
     contingent.subservice,
     contingent.service_entity_name,
     usr.owner,
     des.priority_list DESC;



.. _FUNCTION-system._effective_contingent_hostname:

``system._effective_contingent_hostname``
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

contingent

Parameters
 *None*



Returns
 TABLE

Returned columns
 - ``service`` :ref:`commons.t_key <DOMAIN-commons.t_key>`
    
 - ``subservice`` :ref:`commons.t_key <DOMAIN-commons.t_key>`
    
 - ``service_entity_name`` :ref:`dns.t_hostname <DOMAIN-dns.t_hostname>`
    
 - ``domain`` :ref:`dns.t_hostname <DOMAIN-dns.t_hostname>`
    
 - ``owner`` :ref:`user.t_user <DOMAIN-user.t_user>`
    
 - ``domain_contingent`` :ref:`int <DOMAIN-int>`
    


.. code-block:: plpgsql

   
   RETURN QUERY
     SELECT
      DISTINCT ON
      (contingent.service, contingent.subservice, contingent.service_entity_name, contingent.domain, usr.owner)
      contingent.service,
      contingent.subservice,
      contingent.service_entity_name,
      contingent.domain,
      usr.owner,
      contingent.domain_contingent
     FROM system.subservice_entity_domain_contingent AS contingent
   
     CROSS JOIN "user"."user" AS usr
   
     JOIN system._inherit_contingent_donor(usr.owner) AS des
       ON des.donor = contingent.owner
   
     ORDER BY
      contingent.service,
      contingent.subservice,
      contingent.service_entity_name,
      contingent.domain,
      usr.owner,
      des.priority_list DESC;



.. _FUNCTION-system._inherit_contingent_donor:

``system._inherit_contingent_donor``
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Returns all contingent donors for a given user with their priority.

Parameters
 - ``p_owner`` :ref:`user.t_user <DOMAIN-user.t_user>`
   
    



Returns
 TABLE

Returned columns
 - ``donor`` :ref:`user.t_user <DOMAIN-user.t_user>`
    User from which contingents are inherited
 - ``priority_list`` :ref:`integer[] <DOMAIN-integer[]>`
    


.. code-block:: plpgsql

   
   RETURN QUERY
   WITH RECURSIVE contingent_donor(donor, priority_list, cycle_detector) AS
   (
      -- cast to varchar, since arrays of t_user are not defined
      SELECT p_owner, ARRAY[]::integer[], ARRAY[CAST(p_owner AS varchar)]
   
      UNION
   
      SELECT
       curr.donor,
       prev.priority_list || curr.priority,
       cycle_detector || CAST(curr.donor AS varchar)
      FROM system.inherit_contingent AS curr
       JOIN contingent_donor AS prev
       ON
        prev.donor = curr.owner AND
        curr.donor <> ALL (prev.cycle_detector)
   )
   SELECT
    contingent_donor.donor,
    array_append(contingent_donor.priority_list, NULL)
   FROM contingent_donor
   -- Appending the NULL changes the ordering between arrays with different size
   ORDER BY array_append(contingent_donor.priority_list, NULL) DESC;



.. _FUNCTION-system._setup_register_service:

``system._setup_register_service``
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Allows modules to register their services during setup.
Returns the total number of service names registered
for this module.

Parameters
 - ``p_module`` :ref:`commons.t_key <DOMAIN-commons.t_key>`
   
    
 - ``p_service`` :ref:`commons.t_key <DOMAIN-commons.t_key>`
   
    



Returns
 void



.. code-block:: plpgsql

   
   INSERT INTO system.service
    (module, service)
    SELECT p_module, p_service
     WHERE NOT EXISTS (
      SELECT service FROM system.service
       WHERE module=p_module AND service=p_service
      );



.. _FUNCTION-system._setup_register_subservice:

``system._setup_register_subservice``
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Allows modules to register their services during setup.
Returns the total number of service names registered
for this module.

Parameters
 - ``p_service`` :ref:`commons.t_key <DOMAIN-commons.t_key>`
   
    
 - ``p_subservice`` :ref:`commons.t_key <DOMAIN-commons.t_key>`
   
    



Returns
 void



.. code-block:: plpgsql

   
   INSERT INTO system.subservice
    (service, subservice)
    SELECT p_service, p_subservice
     WHERE NOT EXISTS (
      SELECT service FROM system.subservice
       WHERE service=p_service AND subservice=p_subservice
      );



.. _FUNCTION-system.sel_inherit_contingent:

``system.sel_inherit_contingent``
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Select inherit contingent

Parameters
 *None*


Variables defined for body
 - ``v_owner`` :ref:`user.t_user <DOMAIN-user.t_user>`
   
   
 - ``v_login`` :ref:`user.t_user <DOMAIN-user.t_user>`
   
   

Returns
 TABLE

Returned columns
 - ``owner`` :ref:`user.t_user <DOMAIN-user.t_user>`
    
 - ``donor`` :ref:`user.t_user <DOMAIN-user.t_user>`
    
 - ``priority`` :ref:`int <DOMAIN-int>`
    

Execute privilege
 - :ref:`userlogin <ROLE-userlogin>`

.. code-block:: plpgsql

   -- begin userlogin prelude
   v_login := (SELECT t.owner FROM "user"._get_login() AS t);
   v_owner := (SELECT t.act_as FROM "user"._get_login() AS t);
   -- end userlogin prelude
   
   
   RETURN QUERY
       SELECT t.owner, t.donor, t.priority
       FROM system.inherit_contingent AS t
       ORDER BY t.owner, t.priority;



.. _FUNCTION-system.sel_usable_host:

``system.sel_usable_host``
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Usable hosts

Parameters
 - ``p_service`` :ref:`commons.t_key <DOMAIN-commons.t_key>`
   
    


Variables defined for body
 - ``v_owner`` :ref:`user.t_user <DOMAIN-user.t_user>`
   
   
 - ``v_login`` :ref:`user.t_user <DOMAIN-user.t_user>`
   
   

Returns
 TABLE

Returned columns
 - ``subservice`` :ref:`commons.t_key <DOMAIN-commons.t_key>`
    
 - ``service_entity_name`` :ref:`dns.t_hostname <DOMAIN-dns.t_hostname>`
    

Execute privilege
 - :ref:`userlogin <ROLE-userlogin>`

.. code-block:: plpgsql

   -- begin userlogin prelude
   v_login := (SELECT t.owner FROM "user"._get_login() AS t);
   v_owner := (SELECT t.act_as FROM "user"._get_login() AS t);
   -- end userlogin prelude
   
   
   RETURN QUERY
       SELECT t.subservice, t.service_entity_name FROM system._effective_contingent() AS t
           WHERE
               owner = v_owner AND
               t.service = p_service AND
               t.total_contingent > 0
           ORDER BY
               t.service_entity_name
       ;









.. This file was generated via HamSql

