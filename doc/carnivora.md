Module "\_postgresql\_user"
===========================

    PostgreSQL users and their priviledges

Roles
-----

### Role "edentata"

Account for edentata web frontend

-   Login: true

### Role "machine\_example"

Account for machine example

-   Login: true

Module "backend"
================

    Carnivora Backend

    The backend module provides everything required for the backend API.
    The backend API delivers content required for building configs etc.
    to clients, called machines.

Tables
------

### Table "backend"."auth"

    Grants rights to backend API clients based on SQL roles.

-   Primary key:
    -   role

#### Columns

##### role

    Grantee for right to access the backend date for the defined machine.
    A role is basically a user or a user group on the SQL server.

-   Type: commons.t\_key

##### machine

    Machine for which the rights are granted.

-   Type: dns.t\_domain
-   References: [backend.machine.name](#COLUMN-backend.machine.name)
    -   On delete: CASCADE

### Table "backend"."machine"

    Physical or virtual machines that hosts services.

-   Primary key:
    -   name

#### Columns

##### name

    Machine name

-   Type: dns.t\_domain

Functions
---------

### Function "backend"."\_active"

    Is not 'del'

-   Parameters:
    -   **backend\_status** *backend.t\_status*
-   Returns: boolean

### Function "backend"."\_conditional\_notify"

    Notifies if first argument is true. Throws inaccessible otherwise.

-   Parameters:
    -   **p\_condition** *boolean*
    -   **p\_service** *commons.t\_key*
    -   **p\_subservice** *commons.t\_key*
    -   **p\_domain** *dns.t\_domain*
-   Returns: void

### Function "backend"."\_conditional\_notify\_service\_entity\_name"

    Notifies if first argument is true. Throws inaccessible otherwise.

-   Parameters:
    -   **p\_condition** *boolean*
    -   **p\_service\_entity\_name** *dns.t\_domain*
    -   **p\_service** *commons.t\_key*
    -   **p\_subservice** *commons.t\_key*
-   Returns: void

### Function "backend"."\_deleted"

    Is 'del'

-   Parameters:
    -   **backend\_status** *backend.t\_status*
-   Returns: boolean

### Function "backend"."\_get\_login"

    Shows informations for the current backend login.
    Throws an error if the current user is not a grantee
    for a machine.

-   Parameters: *non*
-   Returns: TABLE

### Function "backend"."\_machine\_priviledged"

    Checks if a currently connected machine is priviledged to obtain data for
    a certain service for a certain domain name.

    WARNING: The parameter p_domain must be a domain, which means an entry in
    the column dns.service.domain. It must not be confused with a service_entity_name.

-   Parameters:
    -   **p\_service** *commons.t\_key*
    -   **p\_domain** *dns.t\_domain*
    -   **p\_include\_inactive** *boolean*
-   Variables defined for body:
    -   **v\_machine** *dns.t\_domain*
-   Returns: boolean
-   Execute privilege:
    -   [backend](#ROLE-backend)

### Function "backend"."\_machine\_priviledged\_service"

    Checks if a currently connected machine is priviledged to obtain data for
    a certain service for a certain servicee name.

    WARNING: The parameter p_server_name must be a service name. It must not be
    confused with a domain.

-   Parameters:
    -   **p\_service** *commons.t\_key*
    -   **p\_service\_entity\_name** *dns.t\_domain*
    -   **p\_include\_inactive** *boolean*
-   Variables defined for body:
    -   **v\_machine** *dns.t\_domain*
-   Returns: boolean
-   Execute privilege:
    -   [backend](#ROLE-backend)

### Function "backend"."\_notify"

    Informs all machines about changes.

    To listen to signals use LISTEN "carnivora/machine.name.example".
    The payload has the form 'mail.domain.example/email/list'.

-   Parameters:
    -   **p\_machine** *dns.t\_domain*
    -   **p\_service\_entity\_name** *dns.t\_domain*
    -   **p\_service** *commons.t\_key*
    -   **p\_subservice** *commons.t\_key*
-   Returns: void

### Function "backend"."\_notify\_domain"

    Informs all machines about changes.

    WARNING: The parameter p_domain must be a domain, which means an entry in
    the column dns.service.domain. It must not be confused with a service_entity_name.

-   Parameters:
    -   **p\_service** *commons.t\_key*
    -   **p\_subservice** *commons.t\_key*
    -   **p\_domain** *dns.t\_domain*
-   Returns: void

### Function "backend"."\_notify\_service\_entity\_name"

    Informs all machines about changes.

    WARNING: The parameter p_service_entity_name must be a servcie name. It must not be
    confused with a domain.

-   Parameters:
    -   **p\_service\_entity\_name** *dns.t\_domain*
    -   **p\_service** *commons.t\_key*
    -   **p\_subservice** *commons.t\_key*
-   Returns: void

Domains
-------

### Domain "backend"."t\_status"

    Backend status

Roles
-----

### Role "backend"

vms

-   Login:

Module "commons"
================

    Carnivora Commons

    Usefull templates, functions and domains.

Functions
---------

### Function "commons"."\_hash\_password"

    SHA512 hash of the password with 16 charcters random salt.
    The returned format is the traditional 'crypt(3)' format.

-   Parameters:
    -   **p\_password** *commons.t\_password\_plaintext*
-   Language: plpython3u
-   Returns: commons.t\_password

### Function "commons"."\_idn"

    Converts a unicode domain name to IDN (ASCII)

-   Parameters:
    -   **p\_domain** *varchar*
-   Language: plpython3u
-   Returns: varchar
-   Execute privilege:
    -   [userlogin](#ROLE-userlogin)
    -   [backend](#ROLE-backend)

### Function "commons"."\_passwords\_equal"

    Compares a plaintext password with an arbitrary 'crypt(3)' hashed password.

    Uses 

-   Parameters:
    -   **p\_password\_plaintext** *commons.t\_password\_plaintext*
    -   **p\_password\_hash** *commons.t\_password*
-   Language: plpython3u
-   Returns: boolean

### Function "commons"."\_raise\_inaccessible\_or\_missing"

    Raised whenever a operation on an object failes because it is not owned by
    the user or it is not found.

-   Parameters:
    -   **p\_raise** *boolean* Controls if the exception is raised
-   Returns: void

### Function "commons"."\_reverse\_array"

    Copied from 

-   Parameters:
    -   **p\_array** *anyarray*
-   Returns: anyarray
-   Execute privilege:
    -   [userlogin](#ROLE-userlogin)
    -   [backend](#ROLE-backend)

### Function "commons"."\_uuid"

    Returns a random uuid

-   Parameters: *non*
-   Returns: uuid

Domains
-------

### Domain "commons"."t\_port"

    Port

### Domain "commons"."t\_password"

    unix hash thingy - todo: propper checking of format

### Domain "commons"."t\_password\_plaintext"

    Password in plaintext

### Domain "commons"."t\_key"

    Key

Module "dns"
============

    DNS

Tables
------

### Table "dns"."custom"

    Direct name server entries.

-   Primary key:
    -   id

#### Columns

##### type

    Type (?) like MX, A, AAAA, ...

-   Type: dns.t\_type

##### rdata

    fancy rdata storage

-   Type: dns.t\_rdata

##### ttl

    Time to live, NULL indicates default value

-   Type: dns.t\_ttl
-   Can be *NULL*

##### backend\_status

    Status of database entry in backend. NULL: nothing pending,
    'ins': entry not present on backend client, 'upd': update
    pending on backend client, 'del': deletion peding on
    backend client.

-   Type: backend.t\_status
-   Can be *NULL*
-   Default value: 'ins'

##### registered

    Registered domain of which domain is a sub domain

-   Type: dns.t\_domain
-   References: [dns.registered.domain](#COLUMN-dns.registered.domain)

##### domain

    domain of entry

-   Type: dns.t\_domain

##### id

    uuid serial number to identify database elements uniquely
    The default value is generated using uuid_generate_v4().

-   Type: uuid
-   Default value: uuid\_generate\_v4()

### Table "dns"."registered"

    Domains registered under a public suffix.

-   Primary key:
    -   domain
-   Foreign keys:
    1.  **Reference service entity**
        -   Columns:
            1.  service\_entity\_name →
            2.  service →
        -   Referenced columns:
            1.  [system.service\_entity.service\_entity\_name](#COLUMN-system.service_entity.service_entity_name)
            2.  [system.service\_entity.service](#COLUMN-system.service_entity.service)

    2.  **Reference subservice entity**
        -   Columns:
            1.  service\_entity\_name →
            2.  service →
            3.  subservice →
        -   Referenced columns:
            1.  [system.subservice\_entity.service\_entity\_name](#COLUMN-system.subservice_entity.service_entity_name)
            2.  [system.subservice\_entity.service](#COLUMN-system.subservice_entity.service)
            3.  [system.subservice\_entity.subservice](#COLUMN-system.subservice_entity.subservice)

#### Columns

##### owner

    for ownage

-   Type: user.t\_user
-   References: [user.user.owner](#COLUMN-user.user.owner)

##### backend\_status

    Status of database entry in backend. NULL: nothing pending,
    'ins': entry not present on backend client, 'upd': update
    pending on backend client, 'del': deletion peding on
    backend client.

-   Type: backend.t\_status
-   Can be *NULL*
-   Default value: 'ins'

##### service\_entity\_name

    Service entity name

-   Type: dns.t\_domain

##### service

    Service (e.g. email, jabber)

-   Type: commons.t\_key

##### subservice

    Subservice (e.g. account, alias)

-   Type: commons.t\_key

##### domain

    Domain

-   Type: dns.t\_domain

##### public\_suffix

    Public Suffix

-   Type: varchar

### Table "dns"."service"

    Name server entries based on system.service (i.e. system.service_dns)

-   Primary key:
    -   domain
    -   service
-   Foreign keys:
    1.  **Reference service entity**
        -   Columns:
            1.  service\_entity\_name →
            2.  service →
        -   Referenced columns:
            1.  [system.service\_entity.service\_entity\_name](#COLUMN-system.service_entity.service_entity_name)
            2.  [system.service\_entity.service](#COLUMN-system.service_entity.service)

#### Columns

##### service\_entity\_name

    Service entity name

-   Type: dns.t\_domain

##### service

    Service (e.g. email, jabber)

-   Type: commons.t\_key

##### backend\_status

    Status of database entry in backend. NULL: nothing pending,
    'ins': entry not present on backend client, 'upd': update
    pending on backend client, 'del': deletion peding on
    backend client.

-   Type: backend.t\_status
-   Can be *NULL*
-   Default value: 'ins'

##### registered

    Registered domain of which domain is a sub domain

-   Type: dns.t\_domain
-   References: [dns.registered.domain](#COLUMN-dns.registered.domain)

##### domain

    domain for which the entries should be created

-   Type: dns.t\_domain

Functions
---------

### Function "dns"."\_domain\_order"

    ORDER

-   Parameters:
    -   **p\_domain** *dns.t\_domain*
-   Returns: varchar[]
-   Execute privilege:
    -   [userlogin](#ROLE-userlogin)
    -   [backend](#ROLE-backend)

### Function "dns"."del\_custom"

    Delete Custom

-   Parameters:
    -   **p\_id** *uuid*
-   Variables defined for body:
    -   **v\_nameserver** *dns.t\_domain*
    -   **v\_managed** *commons.t\_key*
    -   **v\_owner** *user.t\_user*
    -   **v\_login** *user.t\_user*
-   Returns: void
-   Execute privilege:
    -   [userlogin](#ROLE-userlogin)

### Function "dns"."del\_registered"

    Delete registered domain

-   Parameters:
    -   **p\_domain** *dns.t\_domain*
-   Variables defined for body:
    -   **v\_nameserver** *dns.t\_domain*
    -   **v\_managed** *commons.t\_key*
    -   **v\_owner** *user.t\_user*
    -   **v\_login** *user.t\_user*
-   Returns: void
-   Execute privilege:
    -   [userlogin](#ROLE-userlogin)

### Function "dns"."del\_service"

    deletes all service entries of a specific domain

-   Parameters:
    -   **p\_domain** *dns.t\_domain*
    -   **p\_service** *commons.t\_key*
-   Variables defined for body:
    -   **v\_nameserver** *dns.t\_domain*
    -   **v\_managed** *commons.t\_key*
    -   **v\_owner** *user.t\_user*
    -   **v\_login** *user.t\_user*
-   Returns: void
-   Execute privilege:
    -   [userlogin](#ROLE-userlogin)

### Function "dns"."fwd\_registered\_status"

    Update status

-   Parameters:
    -   **p\_domain** *dns.t\_domain*
    -   **p\_backend\_status** *backend.t\_status*
    -   **p\_include\_inactive** *boolean*
-   Variables defined for body:
    -   **v\_machine** *dns.t\_domain*
-   Returns: void
-   Execute privilege:
    -   [backend](#ROLE-backend)

### Function "dns"."ins\_custom"

    Ins Custom

-   Parameters:
    -   **p\_registered** *dns.t\_domain*
    -   **p\_domain** *dns.t\_domain*
    -   **p\_type** *dns.t\_type*
    -   **p\_rdata** *dns.t\_rdata*
    -   **p\_ttl** *integer*
-   Variables defined for body:
    -   **v\_nameserver** *dns.t\_domain*
    -   **v\_managed** *commons.t\_key*
    -   **v\_owner** *user.t\_user*
    -   **v\_login** *user.t\_user*
-   Returns: void
-   Execute privilege:
    -   [userlogin](#ROLE-userlogin)

### Function "dns"."ins\_registered"

    registeres new domain

-   Parameters:
    -   **p\_domain** *dns.t\_domain*
    -   **p\_subservice** *commons.t\_key*
    -   **p\_service\_entity\_name** *dns.t\_domain*
    -   **p\_public\_suffix** *varchar*
-   Variables defined for body:
    -   **v\_owner** *user.t\_user*
    -   **v\_login** *user.t\_user*
-   Returns: void
-   Execute privilege:
    -   [userlogin](#ROLE-userlogin)

### Function "dns"."ins\_service"

    Creates service dns entry

-   Parameters:
    -   **p\_registered** *dns.t\_domain*
    -   **p\_domain** *dns.t\_domain*
    -   **p\_service\_entity\_name** *dns.t\_domain*
    -   **p\_service** *commons.t\_key*
-   Variables defined for body:
    -   **v\_nameserver** *dns.t\_domain*
    -   **v\_managed** *commons.t\_key*
    -   **v\_owner** *user.t\_user*
    -   **v\_login** *user.t\_user*
-   Returns: void
-   Execute privilege:
    -   [userlogin](#ROLE-userlogin)

### Function "dns"."sel\_activatable\_service"

    Activatable services

-   Parameters: *non*
-   Variables defined for body:
    -   **v\_owner** *user.t\_user*
    -   **v\_login** *user.t\_user*
-   Returns: TABLE
-   Execute privilege:
    -   [userlogin](#ROLE-userlogin)

### Function "dns"."sel\_available\_service"

    List all domains that have a service entry in dns with their service.
    This is particularly usefull since these domains are ready for use with
    this service. Usually this means that accounts etc. can be created for this
    domain.

-   Parameters: *non*
-   Variables defined for body:
    -   **v\_owner** *user.t\_user*
    -   **v\_login** *user.t\_user*
-   Returns: TABLE
-   Execute privilege:
    -   [userlogin](#ROLE-userlogin)

### Function "dns"."sel\_custom"

    sel custom

-   Parameters: *non*
-   Variables defined for body:
    -   **v\_owner** *user.t\_user*
    -   **v\_login** *user.t\_user*
-   Returns: TABLE
-   Execute privilege:
    -   [userlogin](#ROLE-userlogin)

### Function "dns"."sel\_nameserver"

    Select available nameservers

-   Parameters: *non*
-   Variables defined for body:
    -   **v\_owner** *user.t\_user*
    -   **v\_login** *user.t\_user*
-   Returns: TABLE
-   Execute privilege:
    -   [userlogin](#ROLE-userlogin)

### Function "dns"."sel\_registered"

    List registered domains

-   Parameters: *non*
-   Variables defined for body:
    -   **v\_owner** *user.t\_user*
    -   **v\_login** *user.t\_user*
-   Returns: TABLE
-   Execute privilege:
    -   [userlogin](#ROLE-userlogin)

### Function "dns"."sel\_service"

    Select service based dns entries

-   Parameters: *non*
-   Variables defined for body:
    -   **v\_owner** *user.t\_user*
    -   **v\_login** *user.t\_user*
-   Returns: TABLE
-   Execute privilege:
    -   [userlogin](#ROLE-userlogin)

### Function "dns"."sel\_usable\_domain"

    Usable domains

-   Parameters:
    -   **p\_service** *commons.t\_key*
    -   **p\_subservice** *commons.t\_key*
-   Variables defined for body:
    -   **v\_owner** *user.t\_user*
    -   **v\_login** *user.t\_user*
-   Returns: TABLE
-   Execute privilege:
    -   [userlogin](#ROLE-userlogin)

### Function "dns"."srv\_record"

    Servers both record types combined: Raw entries and the ones assembled
    from records templates for services (system.service_entity_dns).

-   Parameters:
    -   **p\_include\_inactive** *boolean*
-   Variables defined for body:
    -   **v\_machine** *dns.t\_domain*
-   Returns: TABLE
-   Execute privilege:
    -   [backend](#ROLE-backend)

### Function "dns"."upd\_custom"

    Ins Custom

-   Parameters:
    -   **p\_id** *uuid*
    -   **p\_rdata** *dns.t\_rdata*
    -   **p\_ttl** *integer*
-   Variables defined for body:
    -   **v\_nameserver** *dns.t\_domain*
    -   **v\_managed** *commons.t\_key*
    -   **v\_owner** *user.t\_user*
    -   **v\_login** *user.t\_user*
-   Returns: void
-   Execute privilege:
    -   [userlogin](#ROLE-userlogin)

Domains
-------

### Domain "dns"."t\_domain"

    Domain name unicode (not IDN)

### Domain "dns"."t\_type"

    Resource record type

### Domain "dns"."t\_rdata"

    record entry

### Domain "dns"."t\_ttl"

    time to live

Module "domain\_reseller"
=========================

    Features for Domains Registered via a Reseller

    Stores additional details for dns.registered domains. Also supports storing
    contact informations (handles).

    This module sends the following signals:
     - domain_reseller/handle
     - domain_registered/managed
     - domain_registered/unmanaged

Tables
------

### Table "domain\_reseller"."handle"

    Handles (Domain Contacts)

    Domain contacts that can be used as owner, admin-c, tech-c or zone-c.

-   Primary key:
    -   alias
-   Foreign keys:
    1.  **Reference service entity**
        -   Columns:
            1.  service\_entity\_name →
            2.  service →
        -   Referenced columns:
            1.  [system.service\_entity.service\_entity\_name](#COLUMN-system.service_entity.service_entity_name)
            2.  [system.service\_entity.service](#COLUMN-system.service_entity.service)

    2.  **Reference subservice entity**
        -   Columns:
            1.  service\_entity\_name →
            2.  service →
            3.  subservice →
        -   Referenced columns:
            1.  [system.subservice\_entity.service\_entity\_name](#COLUMN-system.subservice_entity.service_entity_name)
            2.  [system.subservice\_entity.service](#COLUMN-system.subservice_entity.service)
            3.  [system.subservice\_entity.subservice](#COLUMN-system.subservice_entity.subservice)

#### Columns

##### service\_entity\_name

    Service entity name

-   Type: dns.t\_domain

##### service

    Service (e.g. email, jabber)

-   Type: commons.t\_key

##### subservice

    Subservice (e.g. account, alias)

-   Type: commons.t\_key

##### owner

    for ownage

-   Type: user.t\_user
-   References: [user.user.owner](#COLUMN-user.user.owner)

##### backend\_status

    Status of database entry in backend. NULL: nothing pending,
    'ins': entry not present on backend client, 'upd': update
    pending on backend client, 'del': deletion peding on
    backend client.

-   Type: backend.t\_status
-   Can be *NULL*
-   Default value: 'ins'

##### alias

    Free choosable alias

-   Type: varchar

##### id

    Internal id at reseller

-   Type: varchar
-   Can be *NULL*

##### fname

    First name

-   Type: varchar

##### lname

    Last name

-   Type: varchar

##### address

    Address

-   Type: varchar

##### pcode

    Postcode

-   Type: varchar

##### city

    City

-   Type: varchar

##### country

    Country

-   Type: varchar

##### state

    State

-   Type: varchar

##### email

    Email

-   Type: email.t\_address

##### phone

    Phone

-   Type: varchar

##### organization

    Organization

-   Type: varchar
-   Can be *NULL*

##### fax

    Fax

-   Type: varchar
-   Can be *NULL*

##### mobile\_phone

    Mobile phone

-   Type: varchar
-   Can be *NULL*

### Table "domain\_reseller"."registered"

    Addtional informations to those stored in dns.registered

-   Primary key:
    -   domain

#### Columns

##### domain

    Domain

-   Type: dns.t\_domain
-   References: [dns.registered.domain](#COLUMN-dns.registered.domain)
    -   On delete: CASCADE

##### registrant

    Registrant (Owner)

-   Type: varchar
-   References:
    [domain\_reseller.handle.alias](#COLUMN-domain_reseller.handle.alias)

##### admin\_c

    Admin-C

-   Type: varchar
-   References:
    [domain\_reseller.handle.alias](#COLUMN-domain_reseller.handle.alias)

##### tech\_c

    Tech-C

-   Type: varchar
-   Can be *NULL*
-   References:
    [domain\_reseller.handle.alias](#COLUMN-domain_reseller.handle.alias)

##### zone\_c

    Zone-C

-   Type: varchar
-   Can be *NULL*
-   References:
    [domain\_reseller.handle.alias](#COLUMN-domain_reseller.handle.alias)

##### payable

    Payable

-   Type: timestamp
-   Can be *NULL*

##### period

    Renewal period (years)

-   Type: integer
-   Can be *NULL*

##### registrar\_status

    Registrar status

-   Type: varchar
-   Can be *NULL*

##### registry\_status

    Registry status

-   Type: varchar
-   Can be *NULL*

##### last\_status

    Last update status

-   Type: varchar
-   Can be *NULL*

Functions
---------

### Function "domain\_reseller"."del\_handle"

    Deletes handle

-   Parameters:
    -   **p\_alias** *varchar*
-   Variables defined for body:
    -   **v\_service\_entity\_name** *dns.t\_domain*
    -   **v\_owner** *user.t\_user*
    -   **v\_login** *user.t\_user*
-   Returns: void
-   Execute privilege:
    -   [userlogin](#ROLE-userlogin)

### Function "domain\_reseller"."fwd\_handle\_id"

    Insert handle id

-   Parameters:
    -   **p\_alias** *varchar*
    -   **p\_id** *varchar*
    -   **p\_include\_inactive** *boolean*
-   Variables defined for body:
    -   **v\_machine** *dns.t\_domain*
-   Returns: void
-   Execute privilege:
    -   [backend](#ROLE-backend)

### Function "domain\_reseller"."fwd\_registered\_status"

    Update status

-   Parameters:
    -   **p\_domain** *dns.t\_domain*
    -   **p\_payable** *timestamp*
    -   **p\_period** *integer*
    -   **p\_registrar\_status** *varchar*
    -   **p\_registry\_status** *varchar*
    -   **p\_last\_status** *varchar*
    -   **p\_include\_inactive** *boolean*
-   Variables defined for body:
    -   **v\_machine** *dns.t\_domain*
-   Returns: void
-   Execute privilege:
    -   [backend](#ROLE-backend)

### Function "domain\_reseller"."ins\_handle"

    Inserts handle

-   Parameters:
    -   **p\_alias** *varchar*
    -   **p\_service\_entity\_name** *dns.t\_domain*
    -   **p\_fname** *varchar*
    -   **p\_lname** *varchar*
    -   **p\_address** *varchar*
    -   **p\_pcode** *varchar*
    -   **p\_city** *varchar*
    -   **p\_country** *varchar*
    -   **p\_state** *varchar*
    -   **p\_email** *email.t\_address*
    -   **p\_phone** *varchar*
    -   **p\_organization** *varchar*
    -   **p\_fax** *varchar*
    -   **p\_mobile\_phone** *varchar*
-   Variables defined for body:
    -   **v\_owner** *user.t\_user*
    -   **v\_login** *user.t\_user*
-   Returns: void
-   Execute privilege:
    -   [userlogin](#ROLE-userlogin)

### Function "domain\_reseller"."ins\_registered"

    Inserts details for registered domain

-   Parameters:
    -   **p\_domain** *dns.t\_domain*
    -   **p\_registrant** *varchar*
    -   **p\_admin\_c** *varchar*
-   Variables defined for body:
    -   **v\_owner** *user.t\_user*
    -   **v\_login** *user.t\_user*
-   Returns: void
-   Execute privilege:
    -   [userlogin](#ROLE-userlogin)

### Function "domain\_reseller"."sel\_handle"

    Selects handles

-   Parameters:
    -   **p\_hide\_foreign** *bool*
-   Variables defined for body:
    -   **v\_owner** *user.t\_user*
    -   **v\_login** *user.t\_user*
-   Returns: SETOF domain\_reseller."handle"
-   Execute privilege:
    -   [userlogin](#ROLE-userlogin)

### Function "domain\_reseller"."sel\_registered"

    Selects details for registered domains

-   Parameters: *non*
-   Variables defined for body:
    -   **v\_owner** *user.t\_user*
    -   **v\_login** *user.t\_user*
-   Returns: TABLE
-   Execute privilege:
    -   [userlogin](#ROLE-userlogin)

### Function "domain\_reseller"."sel\_reseller"

    Selects available resellers

-   Parameters: *non*
-   Variables defined for body:
    -   **v\_owner** *user.t\_user*
    -   **v\_login** *user.t\_user*
-   Returns: TABLE
-   Execute privilege:
    -   [userlogin](#ROLE-userlogin)

### Function "domain\_reseller"."srv\_handle"

    Serves handles

-   Parameters:
    -   **p\_include\_inactive** *boolean*
-   Variables defined for body:
    -   **v\_machine** *dns.t\_domain*
-   Returns: SETOF domain\_reseller."handle"
-   Execute privilege:
    -   [backend](#ROLE-backend)

### Function "domain\_reseller"."srv\_registered"

    Serves details for registered domains

-   Parameters:
    -   **p\_include\_inactive** *boolean*
-   Variables defined for body:
    -   **v\_machine** *dns.t\_domain*
-   Returns: TABLE
-   Execute privilege:
    -   [backend](#ROLE-backend)

### Function "domain\_reseller"."upd\_handle"

    Updates handle

-   Parameters:
    -   **p\_alias** *varchar*
    -   **p\_address** *varchar*
    -   **p\_pcode** *varchar*
    -   **p\_city** *varchar*
    -   **p\_country** *varchar*
    -   **p\_state** *varchar*
    -   **p\_email** *email.t\_address*
    -   **p\_phone** *varchar*
    -   **p\_organization** *varchar*
    -   **p\_fax** *varchar*
    -   **p\_mobile\_phone** *varchar*
-   Variables defined for body:
    -   **v\_service\_entity\_name** *dns.t\_domain*
    -   **v\_owner** *user.t\_user*
    -   **v\_login** *user.t\_user*
-   Returns: void
-   Execute privilege:
    -   [userlogin](#ROLE-userlogin)

### Function "domain\_reseller"."upd\_registered"

    Updates details for registered domain

-   Parameters:
    -   **p\_domain** *dns.t\_domain*
    -   **p\_admin\_c** *varchar*
-   Variables defined for body:
    -   **v\_nameserver** *dns.t\_domain*
    -   **v\_managed** *commons.t\_key*
    -   **v\_owner** *user.t\_user*
    -   **v\_login** *user.t\_user*
-   Returns: void
-   Execute privilege:
    -   [userlogin](#ROLE-userlogin)

Module "email"
==============

    Email and Mailing lists

    This module sends the following signals:
     - email/alias
     - email/list
     - email/mailbox
     - email/redirection

Tables
------

### Table "email"."address"

    Collection of all known addresses

-   Primary key:
    -   localpart
    -   domain
-   Foreign keys:
    1.  **reference dns (service)**
        -   Columns:
            1.  domain →
            2.  service →
            3.  service\_entity\_name →
        -   Referenced columns:
            1.  [dns.service.domain](#COLUMN-dns.service.domain)
            2.  [dns.service.service](#COLUMN-dns.service.service)
            3.  [dns.service.service\_entity\_name](#COLUMN-dns.service.service_entity_name)

    2.  **Reference subservice entity**
        -   Columns:
            1.  service\_entity\_name →
            2.  service →
            3.  subservice →
        -   Referenced columns:
            1.  [system.subservice\_entity.service\_entity\_name](#COLUMN-system.subservice_entity.service_entity_name)
            2.  [system.subservice\_entity.service](#COLUMN-system.subservice_entity.service)
            3.  [system.subservice\_entity.subservice](#COLUMN-system.subservice_entity.subservice)

#### Columns

##### domain

    Domain name

-   Type: dns.t\_domain

##### service

    Service

-   Type: commons.t\_key

##### service\_entity\_name

    ent. name

-   Type: dns.t\_domain

##### subservice

    Subservice (e.g. account, alias)

-   Type: commons.t\_key

##### localpart

    Local part

-   Type: email.t\_localpart

### Table "email"."alias"

    Aliases for e-mail mailboxes, owner is determined by mailbox.owner

-   Primary key:
    -   localpart
    -   domain
-   Foreign keys:
    1.  **reference dns (service)**
        -   Columns:
            1.  domain →
            2.  service →
            3.  service\_entity\_name →
        -   Referenced columns:
            1.  [dns.service.domain](#COLUMN-dns.service.domain)
            2.  [dns.service.service](#COLUMN-dns.service.service)
            3.  [dns.service.service\_entity\_name](#COLUMN-dns.service.service_entity_name)

    2.  **Reference subservice entity**
        -   Columns:
            1.  service\_entity\_name →
            2.  service →
            3.  subservice →
        -   Referenced columns:
            1.  [system.subservice\_entity.service\_entity\_name](#COLUMN-system.subservice_entity.service_entity_name)
            2.  [system.subservice\_entity.service](#COLUMN-system.subservice_entity.service)
            3.  [system.subservice\_entity.subservice](#COLUMN-system.subservice_entity.subservice)

    3.  **reference to a mailbox**
        -   Columns:
            1.  mailbox\_localpart →
            2.  mailbox\_domain →
        -   Referenced columns:
            1.  [email.mailbox.localpart](#COLUMN-email.mailbox.localpart)
            2.  [email.mailbox.domain](#COLUMN-email.mailbox.domain)

#### Columns

##### domain

    Domain name

-   Type: dns.t\_domain

##### service

    Service

-   Type: commons.t\_key

##### service\_entity\_name

    ent. name

-   Type: dns.t\_domain

##### subservice

    Subservice (e.g. account, alias)

-   Type: commons.t\_key

##### backend\_status

    Status of database entry in backend. NULL: nothing pending,
    'ins': entry not present on backend client, 'upd': update
    pending on backend client, 'del': deletion peding on
    backend client.

-   Type: backend.t\_status
-   Can be *NULL*
-   Default value: 'ins'

##### localpart

    Local part

-   Type: email.t\_localpart

##### mailbox\_localpart

    Mailbox to which the mails will be delivered

-   Type: email.t\_localpart

##### mailbox\_domain

    Mailbox to which the mails will be delivered

-   Type: dns.t\_domain

### Table "email"."list"

    Mailing lists

-   Primary key:
    -   localpart
    -   domain
-   Foreign keys:
    1.  **reference dns (service)**
        -   Columns:
            1.  domain →
            2.  service →
            3.  service\_entity\_name →
        -   Referenced columns:
            1.  [dns.service.domain](#COLUMN-dns.service.domain)
            2.  [dns.service.service](#COLUMN-dns.service.service)
            3.  [dns.service.service\_entity\_name](#COLUMN-dns.service.service_entity_name)

    2.  **Reference subservice entity**
        -   Columns:
            1.  service\_entity\_name →
            2.  service →
            3.  subservice →
        -   Referenced columns:
            1.  [system.subservice\_entity.service\_entity\_name](#COLUMN-system.subservice_entity.service_entity_name)
            2.  [system.subservice\_entity.service](#COLUMN-system.subservice_entity.service)
            3.  [system.subservice\_entity.subservice](#COLUMN-system.subservice_entity.subservice)

#### Columns

##### domain

    Domain name

-   Type: dns.t\_domain

##### service

    Service

-   Type: commons.t\_key

##### service\_entity\_name

    ent. name

-   Type: dns.t\_domain

##### subservice

    Subservice (e.g. account, alias)

-   Type: commons.t\_key

##### owner

    for ownage

-   Type: user.t\_user
-   References: [user.user.owner](#COLUMN-user.user.owner)

##### backend\_status

    Status of database entry in backend. NULL: nothing pending,
    'ins': entry not present on backend client, 'upd': update
    pending on backend client, 'del': deletion peding on
    backend client.

-   Type: backend.t\_status
-   Can be *NULL*
-   Default value: 'ins'

##### option

    Free options in JSON format

-   Type: jsonb
-   Default value: '{}'

##### localpart

    Local part of the email list address

-   Type: email.t\_localpart

##### admin

    Email address of the list admin

-   Type: email.t\_address

##### options

    Arbitrary options

-   Type: jsonb
-   Can be *NULL*

### Table "email"."list\_subscriber"

    list subscribers

-   Primary key:
    -   address
    -   list\_localpart
    -   list\_domain
-   Foreign keys:
    1.  **reference to a list**
        -   Columns:
            1.  list\_localpart →
            2.  list\_domain →
        -   Referenced columns:
            1.  [email.list.localpart](#COLUMN-email.list.localpart)
            2.  [email.list.domain](#COLUMN-email.list.domain)

#### Columns

##### backend\_status

    Status of database entry in backend. NULL: nothing pending,
    'ins': entry not present on backend client, 'upd': update
    pending on backend client, 'del': deletion peding on
    backend client.

-   Type: backend.t\_status
-   Can be *NULL*
-   Default value: 'ins'

##### option

    Free options in JSON format

-   Type: jsonb
-   Default value: '{}'

##### address

    Subscribers address

-   Type: email.t\_address

##### list\_localpart

    List

-   Type: email.t\_localpart

##### list\_domain

    List

-   Type: dns.t\_domain

### Table "email"."mailbox"

    E-mail mailboxs correspond to something a mail user can login into. Basically
    a mailbox represents a mailbox. A mailbox is bound to a specific address.
    Further addresses can be linked to mailboxs via aliases.

-   Primary key:
    -   localpart
    -   domain
-   Foreign keys:
    1.  **reference dns (service)**
        -   Columns:
            1.  domain →
            2.  service →
            3.  service\_entity\_name →
        -   Referenced columns:
            1.  [dns.service.domain](#COLUMN-dns.service.domain)
            2.  [dns.service.service](#COLUMN-dns.service.service)
            3.  [dns.service.service\_entity\_name](#COLUMN-dns.service.service_entity_name)

    2.  **Reference subservice entity**
        -   Columns:
            1.  service\_entity\_name →
            2.  service →
            3.  subservice →
        -   Referenced columns:
            1.  [system.subservice\_entity.service\_entity\_name](#COLUMN-system.subservice_entity.service_entity_name)
            2.  [system.subservice\_entity.service](#COLUMN-system.subservice_entity.service)
            3.  [system.subservice\_entity.subservice](#COLUMN-system.subservice_entity.subservice)

#### Columns

##### domain

    Domain name

-   Type: dns.t\_domain

##### service

    Service

-   Type: commons.t\_key

##### service\_entity\_name

    ent. name

-   Type: dns.t\_domain

##### subservice

    Subservice (e.g. account, alias)

-   Type: commons.t\_key

##### owner

    for ownage

-   Type: user.t\_user
-   References: [user.user.owner](#COLUMN-user.user.owner)

##### backend\_status

    Status of database entry in backend. NULL: nothing pending,
    'ins': entry not present on backend client, 'upd': update
    pending on backend client, 'del': deletion peding on
    backend client.

-   Type: backend.t\_status
-   Can be *NULL*
-   Default value: 'ins'

##### option

    Free options in JSON format

-   Type: jsonb
-   Default value: '{}'

##### localpart

    Local part

-   Type: email.t\_localpart

##### uid

    Unix user identifier

-   Type: SERIAL

##### password

    Unix shadow crypt format

-   Type: commons.t\_password

##### quota

    Quota for mailbox in MiB

-   Type: int
-   Can be *NULL*

### Table "email"."redirection"

    Redirections

-   Primary key:
    -   localpart
    -   domain
-   Foreign keys:
    1.  **reference dns (service)**
        -   Columns:
            1.  domain →
            2.  service →
            3.  service\_entity\_name →
        -   Referenced columns:
            1.  [dns.service.domain](#COLUMN-dns.service.domain)
            2.  [dns.service.service](#COLUMN-dns.service.service)
            3.  [dns.service.service\_entity\_name](#COLUMN-dns.service.service_entity_name)

    2.  **Reference subservice entity**
        -   Columns:
            1.  service\_entity\_name →
            2.  service →
            3.  subservice →
        -   Referenced columns:
            1.  [system.subservice\_entity.service\_entity\_name](#COLUMN-system.subservice_entity.service_entity_name)
            2.  [system.subservice\_entity.service](#COLUMN-system.subservice_entity.service)
            3.  [system.subservice\_entity.subservice](#COLUMN-system.subservice_entity.subservice)

#### Columns

##### domain

    Domain name

-   Type: dns.t\_domain

##### service

    Service

-   Type: commons.t\_key

##### service\_entity\_name

    ent. name

-   Type: dns.t\_domain

##### subservice

    Subservice (e.g. account, alias)

-   Type: commons.t\_key

##### owner

    for ownage

-   Type: user.t\_user
-   References: [user.user.owner](#COLUMN-user.user.owner)

##### backend\_status

    Status of database entry in backend. NULL: nothing pending,
    'ins': entry not present on backend client, 'upd': update
    pending on backend client, 'del': deletion peding on
    backend client.

-   Type: backend.t\_status
-   Can be *NULL*
-   Default value: 'ins'

##### localpart

    Local part

-   Type: email.t\_localpart

##### destination

    External address to which the mails will be delivered

-   Type: email.t\_address

Functions
---------

### Function "email"."\_address"

    List all addresses

-   Parameters: *non*
-   Returns: TABLE

### Function "email"."\_address\_valid"

    x

-   Parameters:
    -   **p\_localpart** *email.t\_localpart*
    -   **p\_domain** *dns.t\_domain*
-   Returns: void

### Function "email"."del\_alias"

    Delete Alias

-   Parameters:
    -   **p\_localpart** *email.t\_localpart*
    -   **p\_domain** *dns.t\_domain*
    -   **p\_mailbox\_localpart** *email.t\_localpart*
    -   **p\_mailbox\_domain** *dns.t\_domain*
-   Variables defined for body:
    -   **v\_owner** *user.t\_user*
    -   **v\_login** *user.t\_user*
-   Returns: void
-   Execute privilege:
    -   [userlogin](#ROLE-userlogin)

### Function "email"."del\_list"

    Delete mailing list

-   Parameters:
    -   **p\_domain** *dns.t\_domain*
    -   **p\_localpart** *email.t\_localpart*
-   Variables defined for body:
    -   **v\_owner** *user.t\_user*
    -   **v\_login** *user.t\_user*
-   Returns: void
-   Execute privilege:
    -   [userlogin](#ROLE-userlogin)

### Function "email"."del\_list\_subscriber"

    del

-   Parameters:
    -   **p\_list\_localpart** *email.t\_localpart*
    -   **p\_list\_domain** *dns.t\_domain*
    -   **p\_address** *email.t\_address*
-   Variables defined for body:
    -   **v\_owner** *user.t\_user*
    -   **v\_login** *user.t\_user*
-   Returns: void
-   Execute privilege:
    -   [userlogin](#ROLE-userlogin)

### Function "email"."del\_mailbox"

    Delete mailbox

-   Parameters:
    -   **p\_localpart** *email.t\_localpart*
    -   **p\_domain** *dns.t\_domain*
-   Variables defined for body:
    -   **v\_owner** *user.t\_user*
    -   **v\_login** *user.t\_user*
-   Returns: void
-   Execute privilege:
    -   [userlogin](#ROLE-userlogin)

### Function "email"."del\_redirection"

    Delete redirection

-   Parameters:
    -   **p\_localpart** *email.t\_localpart*
    -   **p\_domain** *dns.t\_domain*
-   Variables defined for body:
    -   **v\_owner** *user.t\_user*
    -   **v\_login** *user.t\_user*
-   Returns: void
-   Execute privilege:
    -   [userlogin](#ROLE-userlogin)

### Function "email"."ins\_alias"

    Create e-mail aliases

-   Parameters:
    -   **p\_localpart** *email.t\_localpart*
    -   **p\_domain** *dns.t\_domain*
    -   **p\_mailbox\_localpart** *email.t\_localpart*
    -   **p\_mailbox\_domain** *dns.t\_domain*
-   Variables defined for body:
    -   **v\_subservice** *commons.t\_key* (default: *'alias'*)
    -   **v\_num\_total** *int*
    -   **v\_num\_domain** *int*
    -   **v\_owner** *user.t\_user*
    -   **v\_login** *user.t\_user*
-   Returns: void
-   Execute privilege:
    -   [userlogin](#ROLE-userlogin)

### Function "email"."ins\_list"

    Creates a mailing list

-   Parameters:
    -   **p\_localpart** *email.t\_localpart*
    -   **p\_domain** *dns.t\_domain*
    -   **p\_admin** *email.t\_address*
-   Variables defined for body:
    -   **v\_subservice** *commons.t\_key* (default: *'list'*)
    -   **v\_num\_total** *int*
    -   **v\_num\_domain** *int*
    -   **v\_owner** *user.t\_user*
    -   **v\_login** *user.t\_user*
-   Returns: void
-   Execute privilege:
    -   [userlogin](#ROLE-userlogin)

### Function "email"."ins\_list\_subscriber"

    Adds a subscriber to a mailing list

-   Parameters:
    -   **p\_address** *email.t\_address*
    -   **p\_list\_localpart** *email.t\_localpart*
    -   **p\_list\_domain** *dns.t\_domain*
-   Variables defined for body:
    -   **v\_owner** *user.t\_user*
    -   **v\_login** *user.t\_user*
-   Returns: void
-   Execute privilege:
    -   [userlogin](#ROLE-userlogin)

### Function "email"."ins\_mailbox"

    Creates an email box

-   Parameters:
    -   **p\_localpart** *email.t\_localpart*
    -   **p\_domain** *dns.t\_domain*
    -   **p\_password** *commons.t\_password\_plaintext*
-   Variables defined for body:
    -   **v\_subservice** *commons.t\_key* (default: *'mailbox'*)
    -   **v\_num\_total** *int*
    -   **v\_num\_domain** *int*
    -   **v\_owner** *user.t\_user*
    -   **v\_login** *user.t\_user*
-   Returns: void
-   Execute privilege:
    -   [userlogin](#ROLE-userlogin)

### Function "email"."ins\_redirection"

    Creates a redirection

-   Parameters:
    -   **p\_localpart** *email.t\_localpart*
    -   **p\_domain** *dns.t\_domain*
    -   **p\_destination** *email.t\_address*
-   Variables defined for body:
    -   **v\_subservice** *commons.t\_key* (default: *'redirection'*)
    -   **v\_num\_total** *int*
    -   **v\_num\_domain** *int*
    -   **v\_owner** *user.t\_user*
    -   **v\_login** *user.t\_user*
-   Returns: void
-   Execute privilege:
    -   [userlogin](#ROLE-userlogin)

### Function "email"."sel\_alias"

    Select aliases

-   Parameters: *non*
-   Variables defined for body:
    -   **v\_owner** *user.t\_user*
    -   **v\_login** *user.t\_user*
-   Returns: TABLE
-   Execute privilege:
    -   [userlogin](#ROLE-userlogin)

### Function "email"."sel\_list"

    List all lists

-   Parameters: *non*
-   Variables defined for body:
    -   **v\_owner** *user.t\_user*
    -   **v\_login** *user.t\_user*
-   Returns: TABLE
-   Execute privilege:
    -   [userlogin](#ROLE-userlogin)

### Function "email"."sel\_list\_subscriber"

    a

-   Parameters: *non*
-   Variables defined for body:
    -   **v\_owner** *user.t\_user*
    -   **v\_login** *user.t\_user*
-   Returns: TABLE
-   Execute privilege:
    -   [userlogin](#ROLE-userlogin)

### Function "email"."sel\_mailbox"

    List all mailboxes

-   Parameters: *non*
-   Variables defined for body:
    -   **v\_owner** *user.t\_user*
    -   **v\_login** *user.t\_user*
-   Returns: TABLE
-   Execute privilege:
    -   [userlogin](#ROLE-userlogin)

### Function "email"."sel\_redirection"

    Lists all redirections

-   Parameters: *non*
-   Variables defined for body:
    -   **v\_owner** *user.t\_user*
    -   **v\_login** *user.t\_user*
-   Returns: TABLE
-   Execute privilege:
    -   [userlogin](#ROLE-userlogin)

### Function "email"."srv\_alias"

    Lists all email aliases

-   Parameters:
    -   **p\_include\_inactive** *boolean*
-   Variables defined for body:
    -   **v\_machine** *dns.t\_domain*
-   Returns: TABLE
-   Execute privilege:
    -   [backend](#ROLE-backend)

### Function "email"."srv\_list"

    Lists all mailinglists

-   Parameters:
    -   **p\_include\_inactive** *boolean*
-   Variables defined for body:
    -   **v\_machine** *dns.t\_domain*
-   Returns: TABLE
-   Execute privilege:
    -   [backend](#ROLE-backend)

### Function "email"."srv\_list\_subscriber"

    Lists all mailinglist subscribers

-   Parameters:
    -   **p\_include\_inactive** *boolean*
-   Variables defined for body:
    -   **v\_machine** *dns.t\_domain*
-   Returns: TABLE
-   Execute privilege:
    -   [backend](#ROLE-backend)

### Function "email"."srv\_mailbox"

    Lists all mailboxes

-   Parameters:
    -   **p\_include\_inactive** *boolean*
-   Variables defined for body:
    -   **v\_machine** *dns.t\_domain*
-   Returns: TABLE
-   Execute privilege:
    -   [backend](#ROLE-backend)

### Function "email"."srv\_redirection"

    Lists all mailinglists

-   Parameters:
    -   **p\_include\_inactive** *boolean*
-   Variables defined for body:
    -   **v\_machine** *dns.t\_domain*
-   Returns: TABLE
-   Execute privilege:
    -   [backend](#ROLE-backend)

### Function "email"."upd\_list"

    Change list admin

-   Parameters:
    -   **p\_localpart** *email.t\_localpart*
    -   **p\_domain** *dns.t\_domain*
    -   **p\_admin** *email.t\_address*
-   Variables defined for body:
    -   **v\_owner** *user.t\_user*
    -   **v\_login** *user.t\_user*
-   Returns: void
-   Execute privilege:
    -   [userlogin](#ROLE-userlogin)

### Function "email"."upd\_mailbox"

    Change mailbox password

-   Parameters:
    -   **p\_localpart** *email.t\_localpart*
    -   **p\_domain** *dns.t\_domain*
    -   **p\_password** *commons.t\_password\_plaintext*
-   Variables defined for body:
    -   **v\_owner** *user.t\_user*
    -   **v\_login** *user.t\_user*
-   Returns: void
-   Execute privilege:
    -   [userlogin](#ROLE-userlogin)

Domains
-------

### Domain "email"."t\_localpart"

    Local part of an email address, the thing in front of the @

### Domain "email"."t\_address"

    Email address, TODO validity checks

Module "jabber"
===============

    Jabber (XMPP)

    This module sends the following signals:
     - jabber/account

Tables
------

### Table "jabber"."account"

    Jabber accounts

-   Primary key:
    -   node
    -   domain
-   Foreign keys:
    1.  **reference dns (service)**
        -   Columns:
            1.  domain →
            2.  service →
            3.  service\_entity\_name →
        -   Referenced columns:
            1.  [dns.service.domain](#COLUMN-dns.service.domain)
            2.  [dns.service.service](#COLUMN-dns.service.service)
            3.  [dns.service.service\_entity\_name](#COLUMN-dns.service.service_entity_name)

    2.  **Reference subservice entity**
        -   Columns:
            1.  service\_entity\_name →
            2.  service →
            3.  subservice →
        -   Referenced columns:
            1.  [system.subservice\_entity.service\_entity\_name](#COLUMN-system.subservice_entity.service_entity_name)
            2.  [system.subservice\_entity.service](#COLUMN-system.subservice_entity.service)
            3.  [system.subservice\_entity.subservice](#COLUMN-system.subservice_entity.subservice)

#### Columns

##### domain

    Domain name

-   Type: dns.t\_domain

##### service

    Service

-   Type: commons.t\_key

##### service\_entity\_name

    ent. name

-   Type: dns.t\_domain

##### subservice

    Subservice (e.g. account, alias)

-   Type: commons.t\_key

##### owner

    for ownage

-   Type: user.t\_user
-   References: [user.user.owner](#COLUMN-user.user.owner)

##### backend\_status

    Status of database entry in backend. NULL: nothing pending,
    'ins': entry not present on backend client, 'upd': update
    pending on backend client, 'del': deletion peding on
    backend client.

-   Type: backend.t\_status
-   Can be *NULL*
-   Default value: 'ins'

##### node

    part in front of the @ in account name

-   Type: email.t\_localpart

##### password

    Unix shadow crypt format

-   Type: commons.t\_password

Functions
---------

### Function "jabber"."del\_account"

    Delete jabber account

-   Parameters:
    -   **p\_node** *email.t\_localpart*
    -   **p\_domain** *dns.t\_domain*
-   Variables defined for body:
    -   **v\_owner** *user.t\_user*
    -   **v\_login** *user.t\_user*
-   Returns: void
-   Execute privilege:
    -   [userlogin](#ROLE-userlogin)

### Function "jabber"."ins\_account"

    Insert jabber account

-   Parameters:
    -   **p\_node** *email.t\_localpart*
    -   **p\_domain** *dns.t\_domain*
    -   **p\_password** *commons.t\_password\_plaintext*
-   Variables defined for body:
    -   **v\_num\_total** *integer*
    -   **v\_num\_domain** *integer*
    -   **v\_owner** *user.t\_user*
    -   **v\_login** *user.t\_user*
-   Returns: void
-   Execute privilege:
    -   [userlogin](#ROLE-userlogin)

### Function "jabber"."sel\_account"

    Select jabber accounts

-   Parameters: *non*
-   Variables defined for body:
    -   **v\_owner** *user.t\_user*
    -   **v\_login** *user.t\_user*
-   Returns: TABLE
-   Execute privilege:
    -   [userlogin](#ROLE-userlogin)

### Function "jabber"."srv\_account"

    Lists all jabber accounts

-   Parameters:
    -   **p\_include\_inactive** *boolean*
-   Variables defined for body:
    -   **v\_machine** *dns.t\_domain*
-   Returns: TABLE
-   Execute privilege:
    -   [backend](#ROLE-backend)

### Function "jabber"."upd\_account"

    Change jabber account password

-   Parameters:
    -   **p\_node** *email.t\_localpart*
    -   **p\_domain** *dns.t\_domain*
    -   **p\_password** *commons.t\_password\_plaintext*
-   Variables defined for body:
    -   **v\_owner** *user.t\_user*
    -   **v\_login** *user.t\_user*
-   Returns: void
-   Execute privilege:
    -   [userlogin](#ROLE-userlogin)

Module "server\_access"
=======================

    Server Access

    Explicit passwd entries for shell acounts and sftp.

    This module sends the following signals:
     - server_access/sftp
     - server_access/ssh

Tables
------

### Table "server\_access"."user"

    unix user

-   Primary key:
    -   user
-   Foreign keys:
    1.  **Reference service entity**
        -   Columns:
            1.  service\_entity\_name →
            2.  service →
        -   Referenced columns:
            1.  [system.service\_entity.service\_entity\_name](#COLUMN-system.service_entity.service_entity_name)
            2.  [system.service\_entity.service](#COLUMN-system.service_entity.service)

    2.  **Reference subservice entity**
        -   Columns:
            1.  service\_entity\_name →
            2.  service →
            3.  subservice →
        -   Referenced columns:
            1.  [system.subservice\_entity.service\_entity\_name](#COLUMN-system.subservice_entity.service_entity_name)
            2.  [system.subservice\_entity.service](#COLUMN-system.subservice_entity.service)
            3.  [system.subservice\_entity.subservice](#COLUMN-system.subservice_entity.subservice)

#### Columns

##### service\_entity\_name

    Service entity name

-   Type: dns.t\_domain

##### service

    Service (e.g. email, jabber)

-   Type: commons.t\_key

##### subservice

    Subservice (e.g. account, alias)

-   Type: commons.t\_key

##### backend\_status

    Status of database entry in backend. NULL: nothing pending,
    'ins': entry not present on backend client, 'upd': update
    pending on backend client, 'del': deletion peding on
    backend client.

-   Type: backend.t\_status
-   Can be *NULL*
-   Default value: 'ins'

##### owner

    for ownage

-   Type: user.t\_user
-   References: [user.user.owner](#COLUMN-user.user.owner)

##### uid

    Unix user identifier

-   Type: SERIAL

##### user

    User

-   Type: server\_access.t\_user

##### password

    Unix shadow crypt format

-   Type: commons.t\_password
-   Can be *NULL*

Functions
---------

### Function "server\_access"."del\_user"

    delete

-   Parameters:
    -   **p\_user** *server\_access.t\_user*
    -   **p\_service\_entity\_name** *dns.t\_domain*
-   Variables defined for body:
    -   **v\_subservice** *commons.t\_key*
    -   **v\_owner** *user.t\_user*
    -   **v\_login** *user.t\_user*
-   Returns: void
-   Execute privilege:
    -   [userlogin](#ROLE-userlogin)

### Function "server\_access"."ins\_user"

    ins user

-   Parameters:
    -   **p\_user** *server\_access.t\_user*
    -   **p\_service\_entity\_name** *dns.t\_domain*
    -   **p\_subservice** *commons.t\_key*
    -   **p\_password** *commons.t\_password\_plaintext*
-   Variables defined for body:
    -   **v\_password** *commons.t\_password*
    -   **v\_owner** *user.t\_user*
    -   **v\_login** *user.t\_user*
-   Returns: void
-   Execute privilege:
    -   [userlogin](#ROLE-userlogin)

### Function "server\_access"."sel\_user"

    sel user

-   Parameters: *non*
-   Variables defined for body:
    -   **v\_owner** *user.t\_user*
    -   **v\_login** *user.t\_user*
-   Returns: TABLE
-   Execute privilege:
    -   [userlogin](#ROLE-userlogin)

### Function "server\_access"."srv\_user"

    backend server_access.user

-   Parameters:
    -   **p\_include\_inactive** *boolean*
-   Variables defined for body:
    -   **v\_machine** *dns.t\_domain*
-   Returns: TABLE
-   Execute privilege:
    -   [backend](#ROLE-backend)

### Function "server\_access"."upd\_user"

    passwd user

-   Parameters:
    -   **p\_user** *server\_access.t\_user*
    -   **p\_service\_entity\_name** *dns.t\_domain*
    -   **p\_password** *commons.t\_password\_plaintext*
-   Variables defined for body:
    -   **v\_password** *commons.t\_password* (default: *NULL*)
    -   **v\_subservice** *commons.t\_key*
    -   **v\_owner** *user.t\_user*
    -   **v\_login** *user.t\_user*
-   Returns: void
-   Execute privilege:
    -   [userlogin](#ROLE-userlogin)

Domains
-------

### Domain "server\_access"."t\_user"

    Unix user. This type only allows a subset of those names allowed by POSIX.

Module "system"
===============

    Carnivora System

    Manages services, service entities and contingents.

Tables
------

### Table "system"."inherit\_contingent"

    x

-   Primary key:
    -   owner
    -   priority

#### Columns

##### owner

    for ownage

-   Type: user.t\_user
-   References: [user.user.owner](#COLUMN-user.user.owner)

##### donor

    Donor

-   Type: user.t\_user

##### priority

    Priority, higher values take precedence

-   Type: int

### Table "system"."service"

    Services

    Just a list of services that exist. Modules do register their services here.
    Use system._setup_register_service(, ) to insert into this
    table.

-   Primary key:
    -   service

#### Columns

##### service

    Service name

-   Type: commons.t\_key

##### module

    Module name, just to keep track who uses this name

-   Type: commons.t\_key

### Table "system"."service\_entity"

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

-   Primary key:
    -   service\_entity\_name
    -   service

#### Columns

##### service\_entity\_name

    Host name

-   Type: dns.t\_domain

##### service

    email, ssh, ...

-   Type: commons.t\_key
-   References: [system.service.service](#COLUMN-system.service.service)

### Table "system"."service\_entity\_dns"

    Service Entity DNS

    Resource records that have to be present to use a service. The records
    in this table can be understood as 'templates'. The table does not
    contain a name (domain) for the records. Rather for every domain that
    uses this service, all appropriate records are created for this domain
    based on this table. The assignment from domain to services can
    be found in dns.service.

-   Primary key:
    -   id
-   Foreign keys:
    1.  **Reference service entity**
        -   Columns:
            1.  service\_entity\_name →
            2.  service →
        -   Referenced columns:
            1.  [system.service\_entity.service\_entity\_name](#COLUMN-system.service_entity.service_entity_name)
            2.  [system.service\_entity.service](#COLUMN-system.service_entity.service)

#### Columns

##### service\_entity\_name

    Service entity name

-   Type: dns.t\_domain

##### service

    Service (e.g. email, jabber)

-   Type: commons.t\_key

##### type

    Type (?) like MX, A, AAAA, ...

-   Type: dns.t\_type

##### rdata

    fancy rdata storage

-   Type: dns.t\_rdata

##### ttl

    Time to live, NULL indicates default value

-   Type: dns.t\_ttl
-   Can be *NULL*

##### id

    uuid serial number to identify database elements uniquely
    The default value is generated using uuid_generate_v4().

-   Type: uuid
-   Default value: uuid\_generate\_v4()

##### domain\_prefix

    Domain prefix

-   Type: varchar
-   Can be *NULL*

### Table "system"."service\_entity\_machine"

    Service Entity Machine

    List of machines that provice a certain service. This information is
    used to provide these machines access to the data they need to provide
    the service. See also the module 'backend'.

-   Primary key:
    -   machine\_name
    -   service\_entity\_name
    -   service
-   Foreign keys:
    1.  **Reference service entity**
        -   Columns:
            1.  service\_entity\_name →
            2.  service →
        -   Referenced columns:
            1.  [system.service\_entity.service\_entity\_name](#COLUMN-system.service_entity.service_entity_name)
            2.  [system.service\_entity.service](#COLUMN-system.service_entity.service)

#### Columns

##### service\_entity\_name

    Service entity name

-   Type: dns.t\_domain

##### service

    Service (e.g. email, jabber)

-   Type: commons.t\_key

##### machine\_name

    Assigns machine

-   Type: dns.t\_domain
-   References: [backend.machine.name](#COLUMN-backend.machine.name)

### Table "system"."subservice"

    Subservices

-   Primary key:
    -   service
    -   subservice

#### Columns

##### service

    Service

-   Type: commons.t\_key
-   References: [system.service.service](#COLUMN-system.service.service)

##### subservice

    Subservice (concretization the service)

-   Type: commons.t\_key

### Table "system"."subservice\_entity"

    Subservice Entity

    Names under which subservices are made available.

    See also: Table system.service_entity

-   Primary key:
    -   service\_entity\_name
    -   service
    -   subservice
-   Foreign keys:
    1.  **service ent**
        -   Columns:
            1.  service\_entity\_name →
            2.  service →
        -   Referenced columns:
            1.  [system.service\_entity.service\_entity\_name](#COLUMN-system.service_entity.service_entity_name)
            2.  [system.service\_entity.service](#COLUMN-system.service_entity.service)

    2.  **subservice**
        -   Columns:
            1.  service →
            2.  subservice →
        -   Referenced columns:
            1.  [system.subservice.service](#COLUMN-system.subservice.service)
            2.  [system.subservice.subservice](#COLUMN-system.subservice.subservice)

#### Columns

##### service\_entity\_name

    Service entity name

-   Type: dns.t\_domain

##### service

    Service name

-   Type: commons.t\_key

##### subservice

    account, alias, ...

-   Type: commons.t\_key

### Table "system"."subservice\_entity\_contingent"

    Subservice entity contingent

-   Primary key:
    -   service
    -   subservice
    -   service\_entity\_name
    -   owner
-   Foreign keys:
    1.  **Reference service entity**
        -   Columns:
            1.  service\_entity\_name →
            2.  service →
        -   Referenced columns:
            1.  [system.service\_entity.service\_entity\_name](#COLUMN-system.service_entity.service_entity_name)
            2.  [system.service\_entity.service](#COLUMN-system.service_entity.service)

    2.  **Reference subservice entity**
        -   Columns:
            1.  service\_entity\_name →
            2.  service →
            3.  subservice →
        -   Referenced columns:
            1.  [system.subservice\_entity.service\_entity\_name](#COLUMN-system.subservice_entity.service_entity_name)
            2.  [system.subservice\_entity.service](#COLUMN-system.subservice_entity.service)
            3.  [system.subservice\_entity.subservice](#COLUMN-system.subservice_entity.subservice)

#### Columns

##### service\_entity\_name

    Service entity name

-   Type: dns.t\_domain

##### service

    Service (e.g. email, jabber)

-   Type: commons.t\_key

##### subservice

    Subservice (e.g. account, alias)

-   Type: commons.t\_key

##### owner

    for ownage

-   Type: user.t\_user
-   References: [user.user.owner](#COLUMN-user.user.owner)

##### domain\_contingent

    Limit per domain

-   Type: integer

##### total\_contingent

    Limit on the total

-   Type: integer

### Table "system"."subservice\_entity\_domain\_contingent"

    Subservice entity per domain contingent

-   Primary key:
    -   service
    -   subservice
    -   service\_entity\_name
    -   domain
    -   owner
-   Foreign keys:
    1.  **Reference service entity**
        -   Columns:
            1.  service\_entity\_name →
            2.  service →
        -   Referenced columns:
            1.  [system.service\_entity.service\_entity\_name](#COLUMN-system.service_entity.service_entity_name)
            2.  [system.service\_entity.service](#COLUMN-system.service_entity.service)

    2.  **Reference subservice entity**
        -   Columns:
            1.  service\_entity\_name →
            2.  service →
            3.  subservice →
        -   Referenced columns:
            1.  [system.subservice\_entity.service\_entity\_name](#COLUMN-system.subservice_entity.service_entity_name)
            2.  [system.subservice\_entity.service](#COLUMN-system.subservice_entity.service)
            3.  [system.subservice\_entity.subservice](#COLUMN-system.subservice_entity.subservice)

#### Columns

##### service\_entity\_name

    Service entity name

-   Type: dns.t\_domain

##### service

    Service (e.g. email, jabber)

-   Type: commons.t\_key

##### subservice

    Subservice (e.g. account, alias)

-   Type: commons.t\_key

##### owner

    for ownage

-   Type: user.t\_user
-   References: [user.user.owner](#COLUMN-user.user.owner)

##### domain

    Specific domain for which the access is granted

-   Type: dns.t\_domain

##### domain\_contingent

    Limit per domain

-   Type: integer

Functions
---------

### Function "system"."\_contingent\_ensure"

    Throws exceptions if the contingent is exceeded

-   Parameters:
    -   **p\_owner** *user.t\_user*
    -   **p\_service** *commons.t\_key*
    -   **p\_subservice** *commons.t\_key*
    -   **p\_domain** *dns.t\_domain*
    -   **p\_current\_quantity\_total** *integer*
    -   **p\_current\_quantity\_domain** *integer*
-   Variables defined for body:
    -   **v\_remaining** *integer*
    -   **v\_total\_contingent** *integer*
    -   **v\_domain\_contingent** *integer*
    -   **v\_domain\_contingent\_default** *integer*
    -   **v\_domain\_contingent\_specific** *integer*
    -   **v\_service\_entity\_name** *dns.t\_domain*
    -   **v\_domain\_owner** *user.t\_user*
-   Returns: void

### Function "system"."\_contingent\_total"

    Contingent

-   Parameters:
    -   **p\_owner** *user.t\_user*
    -   **p\_service** *commons.t\_key*
    -   **p\_service\_entity\_name** *dns.t\_domain*
-   Variables defined for body:
    -   **v\_user** *integer*
    -   **v\_default** *integer*
-   Returns: integer

### Function "system"."\_effective\_contingent"

    contingent

-   Parameters: *non*
-   Returns: TABLE

### Function "system"."\_effective\_contingent\_domain"

    contingent

-   Parameters: *non*
-   Returns: TABLE

### Function "system"."\_inherit\_contingent\_donor"

    Returns all contingent donors for a given user with their priority.

-   Parameters:
    -   **p\_owner** *user.t\_user*
-   Returns: TABLE

### Function "system"."\_setup\_register\_service"

    Allows modules to register their services during setup.
    Returns the total number of service names registered
    for this module.

-   Parameters:
    -   **p\_module** *commons.t\_key*
    -   **p\_service** *commons.t\_key*
-   Returns: integer

### Function "system"."\_setup\_register\_subservice"

    Allows modules to register their services during setup.
    Returns the total number of service names registered
    for this module.

-   Parameters:
    -   **p\_service** *commons.t\_key*
    -   **p\_subservice** *commons.t\_key*
-   Returns: integer

### Function "system"."sel\_inherit\_contingent"

    Select inherit contingent

-   Parameters: *non*
-   Variables defined for body:
    -   **v\_owner** *user.t\_user*
    -   **v\_login** *user.t\_user*
-   Returns: TABLE
-   Execute privilege:
    -   [userlogin](#ROLE-userlogin)

### Function "system"."sel\_usable\_host"

    Usable hosts

-   Parameters:
    -   **p\_service** *commons.t\_key*
-   Variables defined for body:
    -   **v\_owner** *user.t\_user*
    -   **v\_login** *user.t\_user*
-   Returns: TABLE
-   Execute privilege:
    -   [userlogin](#ROLE-userlogin)

Module "user"
=============

    Carnivora Users: Users own things objects in the DB,
    and they can login into frontends (edentata)

Tables
------

### Table "user"."deputy"

    Deputies for users

-   Primary key:
    -   deputy
    -   represented

#### Columns

##### deputy

    Deputy

-   Type: user.t\_user
-   References: [user.user.owner](#COLUMN-user.user.owner)
    -   On delete: CASCADE

##### represented

    User for which the deputy can act

-   Type: user.t\_user
-   References: [user.user.owner](#COLUMN-user.user.owner)
    -   On delete: CASCADE

### Table "user"."session"

    User login sessions

-   Primary key:
    -   id

#### Columns

##### id

    Session id

-   Type: varchar
-   Default value: "user".\_session\_id()

##### owner

    for ownage

-   Type: user.t\_user
-   References: [user.user.owner](#COLUMN-user.user.owner)

##### act\_as

    Act as

-   Type: user.t\_user

##### started

    Session started at this time

-   Type: timestamp
-   Default value: CURRENT\_TIMESTAMP

### Table "user"."user"

    User

-   Primary key:
    -   owner

#### Columns

##### owner

    User name

-   Type: user.t\_user

##### password

    Unix shadow crypt format

-   Type: commons.t\_password
-   Can be *NULL*

##### login

    Login enabled

-   Type: bool

##### contact\_email

    Optional contact email address

-   Type: email.t\_address
-   Can be *NULL*

Functions
---------

### Function "user"."\_get\_login"

    Shows informations for the current user login.
    Throws an exception if no login is associated to the
    current database connection.

-   Parameters: *non*
-   Returns: TABLE

### Function "user"."\_session\_id"

    Gives an id for the database connection that is unique over all database connections.
    It is used to identify user logins.

    Not sure if this stays unique with distributed infrastructure!

-   Parameters: *non*
-   Returns: varchar

### Function "user"."ins\_deputy"

    Act as deputy

-   Parameters:
    -   **p\_act\_as** *user.t\_user*
-   Variables defined for body:
    -   **v\_owner** *user.t\_user*
    -   **v\_login** *user.t\_user*
-   Returns: void
-   Execute privilege:
    -   [userlogin](#ROLE-userlogin)

### Function "user"."ins\_login"

    Try to bind database connection to new user session.
    Returns valid if sueccessfull, invalid otherwise.

-   Parameters:
    -   **p\_owner** *commons.t\_key*
    -   **p\_password** *commons.t\_password\_plaintext*
-   Returns: boolean
-   Execute privilege:
    -   [userlogin](#ROLE-userlogin)

### Function "user"."sel\_deputy"

    sel deputy

-   Parameters: *non*
-   Variables defined for body:
    -   **v\_owner** *user.t\_user*
    -   **v\_login** *user.t\_user*
-   Returns: TABLE
-   Execute privilege:
    -   [userlogin](#ROLE-userlogin)

### Function "user"."upd\_user"

    change user passwd

-   Parameters:
    -   **p\_password** *commons.t\_password\_plaintext*
-   Variables defined for body:
    -   **v\_owner** *user.t\_user*
    -   **v\_login** *user.t\_user*
-   Returns: void
-   Execute privilege:
    -   [userlogin](#ROLE-userlogin)

Domains
-------

### Domain "user"."t\_user"

    Username

Roles
-----

### Role "userlogin"

Do user actions via this group

-   Login:

### Role "system"

Highly priviledged user

-   Login:

Module "web"
============

    Websites

    This module sends the following signals:
     - web/alias
     - web/site

Tables
------

### Table "web"."alias"

    Aliases

-   Primary key:
    -   domain
    -   site\_port
-   Foreign keys:
    1.  **reference dns (service)**
        -   Columns:
            1.  domain →
            2.  service →
            3.  service\_entity\_name →
        -   Referenced columns:
            1.  [dns.service.domain](#COLUMN-dns.service.domain)
            2.  [dns.service.service](#COLUMN-dns.service.service)
            3.  [dns.service.service\_entity\_name](#COLUMN-dns.service.service_entity_name)

    2.  **Reference subservice entity**
        -   Columns:
            1.  service\_entity\_name →
            2.  service →
            3.  subservice →
        -   Referenced columns:
            1.  [system.subservice\_entity.service\_entity\_name](#COLUMN-system.subservice_entity.service_entity_name)
            2.  [system.subservice\_entity.service](#COLUMN-system.subservice_entity.service)
            3.  [system.subservice\_entity.subservice](#COLUMN-system.subservice_entity.subservice)

    3.  **site**
        -   Columns:
            1.  site →
            2.  service\_entity\_name →
            3.  site\_port →
        -   Referenced columns:
            1.  [web.site.domain](#COLUMN-web.site.domain)
            2.  [web.site.service\_entity\_name](#COLUMN-web.site.service_entity_name)
            3.  [web.site.port](#COLUMN-web.site.port)

    4.  **dns**
        -   Columns:
            1.  domain →
            2.  service →
            3.  service\_entity\_name →
        -   Referenced columns:
            1.  [dns.service.domain](#COLUMN-dns.service.domain)
            2.  [dns.service.service](#COLUMN-dns.service.service)
            3.  [dns.service.service\_entity\_name](#COLUMN-dns.service.service_entity_name)

#### Columns

##### domain

    Domain name

-   Type: dns.t\_domain

##### service

    Service

-   Type: commons.t\_key

##### service\_entity\_name

    ent. name

-   Type: dns.t\_domain

##### subservice

    Subservice (e.g. account, alias)

-   Type: commons.t\_key

##### backend\_status

    Status of database entry in backend. NULL: nothing pending,
    'ins': entry not present on backend client, 'upd': update
    pending on backend client, 'del': deletion peding on
    backend client.

-   Type: backend.t\_status
-   Can be *NULL*
-   Default value: 'ins'

##### site

    Site

-   Type: dns.t\_domain

##### site\_port

    port

-   Type: commons.t\_port
-   Default value: 80

### Table "web"."https"

    stores https information

-   Primary key:
    -   identifier
    -   domain
    -   port
-   Foreign keys:
    1.  **site**
        -   Columns:
            1.  domain →
            2.  port →
        -   Referenced columns:
            1.  [web.site.domain](#COLUMN-web.site.domain)
            2.  [web.site.port](#COLUMN-web.site.port)

#### Columns

##### backend\_status

    Status of database entry in backend. NULL: nothing pending,
    'ins': entry not present on backend client, 'upd': update
    pending on backend client, 'del': deletion peding on
    backend client.

-   Type: backend.t\_status
-   Can be *NULL*
-   Default value: 'ins'

##### identifier

    PK

-   Type: commons.t\_key

##### domain

    Domain

-   Type: dns.t\_domain

##### port

    Port

-   Type: commons.t\_port

##### x509\_request

    Certificate request

-   Type: web.t\_cert
-   Can be *NULL*

##### x509\_certificate

    Certificate

-   Type: web.t\_cert
-   Can be *NULL*

##### authority\_key\_identifier

    Identifier of the certificate that has signed this cert.
    The Authority Key Identifier allows to build the chain of trust.
    See .
    Hopefully there exists an entry in web.intermediate_cert
    or a root certificate with an equal subjectKeyIdentifier.

    Is NULL whenever x509_certificate is NULL.

-   Type: varchar
-   Can be *NULL*

### Table "web"."intermediate\_cert"

    Intermediate certificates

-   Primary key:
    -   subject\_key\_identifier

#### Columns

##### subject\_key\_identifier

    Identifies this certificate

-   Type: varchar

##### authority\_key\_identifier

    Subject key identifier of the cert that has signed this cert.
    NULL is not allowed, since self signed cert do not belong into intermediate
    certs.

-   Type: varchar

##### x509\_certificate

    Intermediate certificate

-   Type: web.t\_cert

### Table "web"."intermediate\_chain"

    xxx

-   Primary key:
    -   domain
    -   port
    -   identifier
    -   subject\_key\_identifier
-   Foreign keys:
    1.  **https cert**
        -   Columns:
            1.  domain →
            2.  port →
            3.  identifier →
        -   Referenced columns:
            1.  [web.https.domain](#COLUMN-web.https.domain)
            2.  [web.https.port](#COLUMN-web.https.port)
            3.  [web.https.identifier](#COLUMN-web.https.identifier)

#### Columns

##### domain

    Domain

-   Type: dns.t\_domain

##### port

    Port

-   Type: commons.t\_port

##### identifier

    Identifier

-   Type: commons.t\_key

##### order

    Ordering from leaf to root

-   Type: integer

##### subject\_key\_identifier

    SubjectKeyIdentifier

-   Type: varchar
-   References:
    [web.intermediate\_cert.subject\_key\_identifier](#COLUMN-web.intermediate_cert.subject_key_identifier)

### Table "web"."site"

    Website

-   Primary key:
    -   domain
    -   port
-   Foreign keys:
    1.  **reference dns (service)**
        -   Columns:
            1.  domain →
            2.  service →
            3.  service\_entity\_name →
        -   Referenced columns:
            1.  [dns.service.domain](#COLUMN-dns.service.domain)
            2.  [dns.service.service](#COLUMN-dns.service.service)
            3.  [dns.service.service\_entity\_name](#COLUMN-dns.service.service_entity_name)

    2.  **Reference subservice entity**
        -   Columns:
            1.  service\_entity\_name →
            2.  service →
            3.  subservice →
        -   Referenced columns:
            1.  [system.subservice\_entity.service\_entity\_name](#COLUMN-system.subservice_entity.service_entity_name)
            2.  [system.subservice\_entity.service](#COLUMN-system.subservice_entity.service)
            3.  [system.subservice\_entity.subservice](#COLUMN-system.subservice_entity.subservice)

    3.  **https**
        -   Columns:
            1.  domain →
            2.  port →
            3.  https →
        -   Referenced columns:
            1.  [web.https.domain](#COLUMN-web.https.domain)
            2.  [web.https.port](#COLUMN-web.https.port)
            3.  [web.https.identifier](#COLUMN-web.https.identifier)

    4.  **server\_access**
        -   Columns:
            1.  user →
            2.  service\_entity\_name →
        -   Referenced columns:
            1.  [server\_access.user.user](#COLUMN-server_access.user.user)
            2.  [server\_access.user.service\_entity\_name](#COLUMN-server_access.user.service_entity_name)

#### Columns

##### domain

    Domain name

-   Type: dns.t\_domain

##### service

    Service

-   Type: commons.t\_key

##### service\_entity\_name

    ent. name

-   Type: dns.t\_domain

##### subservice

    Subservice (e.g. account, alias)

-   Type: commons.t\_key

##### backend\_status

    Status of database entry in backend. NULL: nothing pending,
    'ins': entry not present on backend client, 'upd': update
    pending on backend client, 'del': deletion peding on
    backend client.

-   Type: backend.t\_status
-   Can be *NULL*
-   Default value: 'ins'

##### option

    Free options in JSON format

-   Type: jsonb
-   Default value: '{}'

##### port

    Port

-   Type: commons.t\_port

##### user

    Server account under which the htdocs reside

-   Type: server\_access.t\_user

##### https

    If null, HTTPS is deactivated

-   Type: commons.t\_key
-   Can be *NULL*

Functions
---------

### Function "web"."del\_alias"

    del

-   Parameters:
    -   **p\_domain** *dns.t\_domain*
    -   **p\_site\_port** *commons.t\_port*
-   Variables defined for body:
    -   **v\_owner** *user.t\_user*
    -   **v\_login** *user.t\_user*
-   Returns: void
-   Execute privilege:
    -   [userlogin](#ROLE-userlogin)

### Function "web"."del\_intermediate\_chain"

    sdf

-   Parameters:
    -   **p\_domain** *dns.t\_domain*
    -   **p\_port** *commons.t\_port*
    -   **p\_identifier** *commons.t\_key*
-   Variables defined for body:
    -   **v\_owner** *user.t\_user*
    -   **v\_login** *user.t\_user*
-   Returns: void
-   Execute privilege:
    -   [userlogin](#ROLE-userlogin)

### Function "web"."del\_site"

    del

-   Parameters:
    -   **p\_domain** *dns.t\_domain*
    -   **p\_port** *commons.t\_port*
-   Variables defined for body:
    -   **v\_owner** *user.t\_user*
    -   **v\_login** *user.t\_user*
-   Returns: void
-   Execute privilege:
    -   [userlogin](#ROLE-userlogin)

### Function "web"."fwd\_x509\_request"

    x509 request

-   Parameters:
    -   **p\_domain** *dns.t\_domain*
    -   **p\_port** *commons.t\_port*
    -   **p\_identifier** *commons.t\_key*
    -   **p\_x509\_request** *web.t\_cert*
    -   **p\_include\_inactive** *boolean*
-   Variables defined for body:
    -   **v\_machine** *dns.t\_domain*
-   Returns: void
-   Execute privilege:
    -   [backend](#ROLE-backend)

### Function "web"."ins\_alias"

    Insert alias

-   Parameters:
    -   **p\_domain** *dns.t\_domain*
    -   **p\_site** *dns.t\_domain*
    -   **p\_site\_port** *commons.t\_port*
-   Variables defined for body:
    -   **v\_owner** *user.t\_user*
    -   **v\_login** *user.t\_user*
-   Returns: void
-   Execute privilege:
    -   [userlogin](#ROLE-userlogin)

### Function "web"."ins\_https"

    Ins HTTPS

-   Parameters:
    -   **p\_domain** *dns.t\_domain*
    -   **p\_port** *commons.t\_port*
    -   **p\_identifier** *commons.t\_key*
-   Variables defined for body:
    -   **v\_owner** *user.t\_user*
    -   **v\_login** *user.t\_user*
-   Returns: void
-   Execute privilege:
    -   [userlogin](#ROLE-userlogin)

### Function "web"."ins\_intermediate\_cert"

    Xxx

-   Parameters:
    -   **p\_subject\_key\_identifier** *varchar*
    -   **p\_authority\_key\_identifier** *varchar*
    -   **p\_x509\_certificate** *web.t\_cert*
-   Variables defined for body:
    -   **v\_owner** *user.t\_user*
    -   **v\_login** *user.t\_user*
-   Returns: void
-   Execute privilege:
    -   [userlogin](#ROLE-userlogin)

### Function "web"."ins\_intermediate\_chain"

    sdf

-   Parameters:
    -   **p\_domain** *dns.t\_domain*
    -   **p\_port** *commons.t\_port*
    -   **p\_identifier** *commons.t\_key*
    -   **p\_order** *integer*
    -   **p\_subject\_key\_identifier** *varchar*
-   Variables defined for body:
    -   **v\_owner** *user.t\_user*
    -   **v\_login** *user.t\_user*
-   Returns: void
-   Execute privilege:
    -   [userlogin](#ROLE-userlogin)

### Function "web"."ins\_site"

    Insert site
    TODO: check owner and contingent

-   Parameters:
    -   **p\_domain** *dns.t\_domain*
    -   **p\_port** *commons.t\_port*
    -   **p\_user** *server\_access.t\_user*
    -   **p\_service\_entity\_name** *dns.t\_domain*
-   Variables defined for body:
    -   **v\_owner** *user.t\_user*
    -   **v\_login** *user.t\_user*
-   Returns: void
-   Execute privilege:
    -   [userlogin](#ROLE-userlogin)

### Function "web"."sel\_alias"

    Select alias

-   Parameters: *non*
-   Variables defined for body:
    -   **v\_owner** *user.t\_user*
    -   **v\_login** *user.t\_user*
-   Returns: TABLE
-   Execute privilege:
    -   [userlogin](#ROLE-userlogin)

### Function "web"."sel\_https"

    sel https

-   Parameters: *non*
-   Variables defined for body:
    -   **v\_owner** *user.t\_user*
    -   **v\_login** *user.t\_user*
-   Returns: TABLE
-   Execute privilege:
    -   [userlogin](#ROLE-userlogin)

### Function "web"."sel\_intermediate\_cert"

    int

-   Parameters:
    -   **p\_subject\_key\_identifier** *varchar*
-   Variables defined for body:
    -   **v\_owner** *user.t\_user*
    -   **v\_login** *user.t\_user*
-   Returns: TABLE
-   Execute privilege:
    -   [userlogin](#ROLE-userlogin)

### Function "web"."sel\_intermediate\_chain"

    sel

-   Parameters: *non*
-   Variables defined for body:
    -   **v\_owner** *user.t\_user*
    -   **v\_login** *user.t\_user*
-   Returns: TABLE
-   Execute privilege:
    -   [userlogin](#ROLE-userlogin)

### Function "web"."sel\_site"

    Owner defined via server_access

-   Parameters: *non*
-   Variables defined for body:
    -   **v\_owner** *user.t\_user*
    -   **v\_login** *user.t\_user*
-   Returns: TABLE
-   Execute privilege:
    -   [userlogin](#ROLE-userlogin)

### Function "web"."srv\_alias"

    backend web.alias

-   Parameters:
    -   **p\_include\_inactive** *boolean*
-   Variables defined for body:
    -   **v\_machine** *dns.t\_domain*
-   Returns: TABLE
-   Execute privilege:
    -   [backend](#ROLE-backend)

### Function "web"."srv\_https"

    Certs

-   Parameters:
    -   **p\_include\_inactive** *boolean*
-   Variables defined for body:
    -   **v\_machine** *dns.t\_domain*
-   Returns: TABLE
-   Execute privilege:
    -   [backend](#ROLE-backend)

### Function "web"."srv\_site"

    backend web.site

-   Parameters:
    -   **p\_include\_inactive** *boolean*
-   Variables defined for body:
    -   **v\_machine** *dns.t\_domain*
-   Returns: TABLE
-   Execute privilege:
    -   [backend](#ROLE-backend)

### Function "web"."upd\_https"

    upd https

-   Parameters:
    -   **p\_domain** *dns.t\_domain*
    -   **p\_port** *commons.t\_port*
    -   **p\_identifier** *commons.t\_key*
    -   **p\_x509\_certificate** *web.t\_cert*
    -   **p\_authority\_key\_identifier** *varchar*
-   Variables defined for body:
    -   **v\_owner** *user.t\_user*
    -   **v\_login** *user.t\_user*
-   Returns: void
-   Execute privilege:
    -   [userlogin](#ROLE-userlogin)

### Function "web"."upd\_site"

    set https identif.

-   Parameters:
    -   **p\_domain** *dns.t\_domain*
    -   **p\_port** *commons.t\_port*
    -   **p\_identifier** *commons.t\_key*
-   Variables defined for body:
    -   **v\_owner** *user.t\_user*
    -   **v\_login** *user.t\_user*
-   Returns: void
-   Execute privilege:
    -   [userlogin](#ROLE-userlogin)

Domains
-------

### Domain "web"."t\_cert"

    PEM cert
