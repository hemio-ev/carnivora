-   [backend](#MODULE-backend)
    -   Tables
        -   [auth](#TABLE-backend.auth)
        -   [machine](#TABLE-backend.machine)
    -   Functions
        -   [\_active](#FUNCTION-backend._active)
        -   [\_conditional\_notify](#FUNCTION-backend._conditional_notify)
        -   [\_conditional\_notify\_service\_name](#FUNCTION-backend._conditional_notify_service_name)
        -   [\_deleted](#FUNCTION-backend._deleted)
        -   [\_get\_login](#FUNCTION-backend._get_login)
        -   [\_machine\_priviledged](#FUNCTION-backend._machine_priviledged)
        -   [\_machine\_priviledged\_service](#FUNCTION-backend._machine_priviledged_service)
        -   [\_notify](#FUNCTION-backend._notify)
        -   [\_notify\_domain](#FUNCTION-backend._notify_domain)
        -   [\_notify\_service\_name](#FUNCTION-backend._notify_service_name)
    -   Domains
        -   [t\_status](#DOMAIN-backend.)
    -   Roles
        -   [backend](#ROLE-backend)
-   [commons](#MODULE-commons)
    -   Functions
        -   [\_hash\_password](#FUNCTION-commons._hash_password)
        -   [\_idn](#FUNCTION-commons._idn)
        -   [\_passwords\_equal](#FUNCTION-commons._passwords_equal)
        -   [\_raise\_inaccessible\_or\_missing](#FUNCTION-commons._raise_inaccessible_or_missing)
        -   [\_uuid](#FUNCTION-commons._uuid)
    -   Domains
        -   [t\_port](#DOMAIN-commons.)
        -   [t\_password](#DOMAIN-commons.)
        -   [t\_password\_plaintext](#DOMAIN-commons.)
        -   [t\_key](#DOMAIN-commons.)
-   [dns](#MODULE-dns)
    -   Tables
        -   [custom](#TABLE-dns.custom)
        -   [registered](#TABLE-dns.registered)
        -   [service](#TABLE-dns.service)
    -   Functions
        -   [del\_custom](#FUNCTION-dns.del_custom)
        -   [del\_service](#FUNCTION-dns.del_service)
        -   [ins\_custom](#FUNCTION-dns.ins_custom)
        -   [ins\_registered](#FUNCTION-dns.ins_registered)
        -   [ins\_service](#FUNCTION-dns.ins_service)
        -   [sel\_activatable\_service](#FUNCTION-dns.sel_activatable_service)
        -   [sel\_available\_service](#FUNCTION-dns.sel_available_service)
        -   [sel\_custom](#FUNCTION-dns.sel_custom)
        -   [sel\_registered](#FUNCTION-dns.sel_registered)
        -   [sel\_service](#FUNCTION-dns.sel_service)
        -   [srv\_all](#FUNCTION-dns.srv_all)
        -   [upd\_custom](#FUNCTION-dns.upd_custom)
    -   Domains
        -   [t\_domain](#DOMAIN-dns.)
        -   [t\_type](#DOMAIN-dns.)
        -   [t\_rdata](#DOMAIN-dns.)
        -   [t\_ttl](#DOMAIN-dns.)
-   [domain\_reseller](#MODULE-domain_reseller)
    -   Tables
        -   [handle](#TABLE-domain_reseller.handle)
        -   [registered](#TABLE-domain_reseller.registered)
    -   Functions
        -   [del\_handle](#FUNCTION-domain_reseller.del_handle)
        -   [ins\_handle](#FUNCTION-domain_reseller.ins_handle)
        -   [ins\_registered](#FUNCTION-domain_reseller.ins_registered)
        -   [sel\_handle](#FUNCTION-domain_reseller.sel_handle)
        -   [sel\_registered](#FUNCTION-domain_reseller.sel_registered)
        -   [upd\_handle](#FUNCTION-domain_reseller.upd_handle)
        -   [upd\_registered](#FUNCTION-domain_reseller.upd_registered)
-   [email](#MODULE-email)
    -   Tables
        -   [address](#TABLE-email.address)
        -   [alias](#TABLE-email.alias)
        -   [list](#TABLE-email.list)
        -   [list\_subscriber](#TABLE-email.list_subscriber)
        -   [mailbox](#TABLE-email.mailbox)
        -   [redirection](#TABLE-email.redirection)
    -   Functions
        -   [\_address](#FUNCTION-email._address)
        -   [\_address\_valid](#FUNCTION-email._address_valid)
        -   [del\_alias](#FUNCTION-email.del_alias)
        -   [del\_list](#FUNCTION-email.del_list)
        -   [del\_list\_subscriber](#FUNCTION-email.del_list_subscriber)
        -   [del\_mailbox](#FUNCTION-email.del_mailbox)
        -   [del\_redirection](#FUNCTION-email.del_redirection)
        -   [ins\_alias](#FUNCTION-email.ins_alias)
        -   [ins\_list](#FUNCTION-email.ins_list)
        -   [ins\_list\_subscriber](#FUNCTION-email.ins_list_subscriber)
        -   [ins\_mailbox](#FUNCTION-email.ins_mailbox)
        -   [ins\_redirection](#FUNCTION-email.ins_redirection)
        -   [sel\_alias](#FUNCTION-email.sel_alias)
        -   [sel\_list](#FUNCTION-email.sel_list)
        -   [sel\_list\_subscriber](#FUNCTION-email.sel_list_subscriber)
        -   [sel\_mailbox](#FUNCTION-email.sel_mailbox)
        -   [sel\_redirection](#FUNCTION-email.sel_redirection)
        -   [srv\_alias](#FUNCTION-email.srv_alias)
        -   [srv\_list](#FUNCTION-email.srv_list)
        -   [srv\_list\_subscriber](#FUNCTION-email.srv_list_subscriber)
        -   [srv\_mailbox](#FUNCTION-email.srv_mailbox)
        -   [srv\_redirection](#FUNCTION-email.srv_redirection)
        -   [upd\_list](#FUNCTION-email.upd_list)
        -   [upd\_mailbox](#FUNCTION-email.upd_mailbox)
    -   Domains
        -   [t\_localpart](#DOMAIN-email.)
        -   [t\_address](#DOMAIN-email.)
-   [jabber](#MODULE-jabber)
    -   Tables
        -   [account](#TABLE-jabber.account)
    -   Functions
        -   [del\_account](#FUNCTION-jabber.del_account)
        -   [ins\_account](#FUNCTION-jabber.ins_account)
        -   [sel\_account](#FUNCTION-jabber.sel_account)
        -   [srv\_account](#FUNCTION-jabber.srv_account)
        -   [upd\_account](#FUNCTION-jabber.upd_account)
-   [server\_access](#MODULE-server_access)
    -   Tables
        -   [user](#TABLE-server_access.user)
    -   Functions
        -   [del\_user](#FUNCTION-server_access.del_user)
        -   [ins\_user](#FUNCTION-server_access.ins_user)
        -   [sel\_user](#FUNCTION-server_access.sel_user)
        -   [srv\_user](#FUNCTION-server_access.srv_user)
        -   [upd\_user](#FUNCTION-server_access.upd_user)
    -   Domains
        -   [t\_user](#DOMAIN-server_access.)
-   [system](#MODULE-system)
    -   Tables
        -   [contingent\_default\_domain](#TABLE-system.contingent_default_domain)
        -   [contingent\_default\_total](#TABLE-system.contingent_default_total)
        -   [contingent\_domain](#TABLE-system.contingent_domain)
        -   [contingent\_total](#TABLE-system.contingent_total)
        -   [service](#TABLE-system.service)
        -   [service\_dns](#TABLE-system.service_dns)
        -   [service\_index](#TABLE-system.service_index)
        -   [service\_machine](#TABLE-system.service_machine)
    -   Functions
        -   [\_contingent\_domain](#FUNCTION-system._contingent_domain)
        -   [\_contingent\_ensure](#FUNCTION-system._contingent_ensure)
        -   [\_contingent\_total](#FUNCTION-system._contingent_total)
        -   [\_setup\_register\_service](#FUNCTION-system._setup_register_service)
    -   Domains
        -   [t\_service](#DOMAIN-system.)
-   [user](#MODULE-user)
    -   Tables
        -   [deputy](#TABLE-user.deputy)
        -   [session](#TABLE-user.session)
        -   [user](#TABLE-user.user)
    -   Functions
        -   [\_get\_login](#FUNCTION-user._get_login)
        -   [\_session\_id](#FUNCTION-user._session_id)
        -   [ins\_deputy](#FUNCTION-user.ins_deputy)
        -   [ins\_login](#FUNCTION-user.ins_login)
        -   [sel\_deputy](#FUNCTION-user.sel_deputy)
        -   [upd\_user](#FUNCTION-user.upd_user)
    -   Domains
        -   [t\_user](#DOMAIN-user.)
    -   Roles
        -   [userlogin](#ROLE-userlogin)
        -   [system](#ROLE-system)
-   [web](#MODULE-web)
    -   Tables
        -   [alias](#TABLE-web.alias)
        -   [https](#TABLE-web.https)
        -   [intermediate\_cert](#TABLE-web.intermediate_cert)
        -   [intermediate\_chain](#TABLE-web.intermediate_chain)
        -   [site](#TABLE-web.site)
    -   Functions
        -   [del\_alias](#FUNCTION-web.del_alias)
        -   [del\_intermediate\_chain](#FUNCTION-web.del_intermediate_chain)
        -   [del\_site](#FUNCTION-web.del_site)
        -   [fwd\_x509\_request](#FUNCTION-web.fwd_x509_request)
        -   [ins\_alias](#FUNCTION-web.ins_alias)
        -   [ins\_https](#FUNCTION-web.ins_https)
        -   [ins\_intermediate\_cert](#FUNCTION-web.ins_intermediate_cert)
        -   [ins\_intermediate\_chain](#FUNCTION-web.ins_intermediate_chain)
        -   [ins\_site](#FUNCTION-web.ins_site)
        -   [sel\_alias](#FUNCTION-web.sel_alias)
        -   [sel\_https](#FUNCTION-web.sel_https)
        -   [sel\_intermediate\_cert](#FUNCTION-web.sel_intermediate_cert)
        -   [sel\_intermediate\_chain](#FUNCTION-web.sel_intermediate_chain)
        -   [sel\_site](#FUNCTION-web.sel_site)
        -   [srv\_alias](#FUNCTION-web.srv_alias)
        -   [srv\_https](#FUNCTION-web.srv_https)
        -   [srv\_site](#FUNCTION-web.srv_site)
        -   [upd\_https](#FUNCTION-web.upd_https)
        -   [upd\_site](#FUNCTION-web.upd_site)
    -   Domains
        -   [t\_cert](#DOMAIN-web.)

backend
=======

    Carnivora Backend:
    The backend module provides everything required for the backend API.
    The backend API delivers content required for building configs etc.
    to clients, called machines.

Sources: `./modules/backend`

Tables
------

### auth

    Grants rights to backend API clients based on SQL roles.

Source: ``

-   Primary key:
    -   role

#### role

Grantee for right to access the backend date for the defined machine. A
role is basically a user or a user group on the SQL server.

-   Type: commons.t\_key

#### machine

Machine for which the rights are granted.

-   Type: dns.t\_domain
-   References: [backend.machine.name](#COLUMN-backend.machine.name)
    -   On delete: CASCADE

### machine

    Physical or virtual machines that hosts services.

Source: ``

-   Primary key:
    -   name

#### name

Machine name

-   Type: dns.t\_domain

Functions
---------

### \_active

    Is not 'del'

Source: ``

-   Parameters:
    -   **backend\_status** *backend.t\_status*
-   Returns: boolean

Body:

    RETURN backend_status IS NULL OR backend_status <> 'del';

### \_conditional\_notify

    Notifies if first argument is true. Throws inaccessible otherwise.

Source: ``

-   Parameters:
    -   **p\_condition** *boolean*
    -   **p\_service** *system.t\_service*
    -   **p\_domain** *dns.t\_domain*
-   Returns: void

Body:

    IF p_condition THEN
        PERFORM backend._notify_domain(p_service, p_domain);
    ELSE
        PERFORM commons._raise_inaccessible_or_missing();
    END IF;

### \_conditional\_notify\_service\_name

    Notifies if first argument is true. Throws inaccessible otherwise.

Source: ``

-   Parameters:
    -   **p\_condition** *boolean*
    -   **p\_service** *system.t\_service*
    -   **p\_service\_name** *dns.t\_domain*
-   Returns: void

Body:

    IF p_condition THEN
        PERFORM backend._notify_service_name(p_service, p_service_name);
    ELSE
        PERFORM commons._raise_inaccessible_or_missing();
    END IF;

### \_deleted

    Is 'del'

Source: ``

-   Parameters:
    -   **backend\_status** *backend.t\_status*
-   Returns: boolean

Body:

    RETURN backend_status IS NOT NULL AND backend_status = 'del';

### \_get\_login

    Shows informations for the current backend login.
    Throws an error if the current user is not a grantee
    for a machine.

Source: ``

-   Parameters: *non*
-   Returns: TABLE

Body:

    IF (SELECT TRUE FROM "backend"."auth"
       WHERE "role"=session_user)
    THEN
       RETURN QUERY SELECT backend.auth.machine FROM backend.auth
           WHERE "role"=session_user;
    ELSE
       RAISE 'Connected role `%` is not a grantee for a machine.', session_user;
    END IF;

### \_machine\_priviledged

    Checks if a currently connected machine is priviledged to obtain data for
    a certain service for a certain domain name.

    WARNING: The parameter p_domain must be a domain, which means an entry in
    the column dns.service.domain. It must not be confused with a service_name.

Source: ``

-   Parameters:
    -   **p\_service** *system.t\_service*
    -   **p\_domain** *dns.t\_domain*
    -   **p\_include\_inactive** *boolean*
-   Variables defined for body:
    -   **v\_machine** *dns.t\_domain*
-   Returns: boolean
-   Execute privilege:
    -   [backend](#ROLE-backend)

Body:

    v_machine := (SELECT "machine" FROM "backend"._get_login());

    RETURN COALESCE(
        (
        SELECT TRUE FROM system.service_machine AS t
            JOIN dns.service AS s
            ON
                s.service = p_service AND
                s.domain = p_domain

            WHERE
                t.service = p_service AND
                t.service_name = s.service_name AND
                t.machine_name = v_machine
        )
    , FALSE);

### \_machine\_priviledged\_service

    Checks if a currently connected machine is priviledged to obtain data for
    a certain service for a certain servicee name.

    WARNING: The parameter p_server_name must be a service name. It must not be
    confused with a domain.

Source: ``

-   Parameters:
    -   **p\_service** *system.t\_service*
    -   **p\_service\_name** *dns.t\_domain*
    -   **p\_include\_inactive** *boolean*
-   Variables defined for body:
    -   **v\_machine** *dns.t\_domain*
-   Returns: boolean
-   Execute privilege:
    -   [backend](#ROLE-backend)

Body:

    v_machine := (SELECT "machine" FROM "backend"._get_login());

    RETURN COALESCE(
        (
        SELECT TRUE FROM system.service_machine AS t
            WHERE
                t.service = p_service AND
                t.service_name = p_service_name AND
                t.machine_name = v_machine
        )
    , FALSE);

### \_notify

    Informs all machines about changes.

Source: ``

-   Parameters:
    -   **p\_machine** *dns.t\_domain*
    -   **p\_service** *system.t\_service*
    -   **p\_service\_name** *dns.t\_domain*
-   Returns: void

Body:

    PERFORM
        pg_notify(
            'carnivora,' || p_machine,
             p_service || ',' || p_service_name
            ),
        pg_notify(
            'carnivora,' || p_machine,
             '*,' || p_service_name
            ),
        pg_notify(
            'carnivora,' || p_machine,
             p_service || ',*'
            );

### \_notify\_domain

    Informs all machines about changes.

    WARNING: The parameter p_domain must be a domain, which means an entry in
    the column dns.service.domain. It must not be confused with a service_name.

Source: ``

-   Parameters:
    -   **p\_service** *system.t\_service*
    -   **p\_domain** *dns.t\_domain*
-   Returns: void

Body:

    PERFORM
        backend._notify(machine_name, p_service, s.service_name)

    FROM system.service_machine AS t
        JOIN dns.service AS s
        ON
            s.service = p_service AND
            s.domain = p_domain

        WHERE
            t.service = p_service AND
            t.service_name = s.service_name
    ;

### \_notify\_service\_name

    Informs all machines about changes.

    WARNING: The parameter p_service_name must be a servcie name. It must not be
    confused with a domain.

Source: ``

-   Parameters:
    -   **p\_service** *system.t\_service*
    -   **p\_service\_name** *dns.t\_domain*
-   Returns: void

Body:

    PERFORM
        backend._notify(machine_name, p_service, p_service_name)

    FROM system.service_machine AS t
        WHERE
            t.service = p_service AND
            t.service_name = p_service_name
    ;

Domains
-------

### t\_status

    Backend status

Roles
-----

### backend

vms

-   Login:

commons
=======

    Carnivora Commons: Usefull templates and types

Sources: `./modules/commons`

Functions
---------

### \_hash\_password

    SHA512 hash of the password with 16 charcters random salt.
    The returned format is the traditional 'crypt(3)' format.

Source: ``

-   Parameters:
    -   **p\_password** *commons.t\_password\_plaintext*
-   Language: plpython3u
-   Returns: commons.t\_password

Body:

    import crypt

    return crypt.crypt(p_password, crypt.METHOD_SHA512)

### \_idn

    Converts a unicode domain name to IDN (ASCII)

Source: ``

-   Parameters:
    -   **p\_domain** *varchar*
-   Language: plpython3u
-   Returns: varchar
-   Execute privilege:
    -   [userlogin](#ROLE-userlogin)
    -   [backend](#ROLE-backend)

Body:

    if p_domain is None:
       return None

    if p_domain.lower() != p_domain:
        raise plpy.Error('Only lower case IDNs are allowed and can be handled.')

    return p_domain.encode('idna').decode()

### \_passwords\_equal

    Compares a plaintext password with an arbitrary 'crypt(3)' hashed password.

Source: ``

-   Parameters:
    -   **p\_password\_plaintext** *commons.t\_password\_plaintext*
    -   **p\_password\_hash** *commons.t\_password*
-   Language: plpython3u
-   Returns: boolean

Body:

    import crypt
    from hmac import compare_digest as compare_hash

    # Giving crypt.crypt the full hash as second argument fixes the use of the 
    # right salt and algorithm. Using compare_hash to avoid timing attacks.
    return compare_hash(crypt.crypt(p_password_plaintext, p_password_hash), p_password_hash)

### \_raise\_inaccessible\_or\_missing

    Raised whenever a operation on an object failes because it is not owned by
    the user or it is not found.

Source: ``

-   Parameters:
    -   **p\_raise** *boolean* Controls if the exception is raised
-   Returns: void

Body:

    IF NOT COALESCE(p_raise, FALSE) THEN
        RAISE 'Object inaccessible or missing'
            USING DETAIL = '$carnivora:commons:inaccessible_or_missing$';
    END IF;

### \_uuid

    Returns new uuid

Source: ``

-   Parameters: *non*
-   Returns: uuid

Body:

    RETURN uuid_generate_v4();

Domains
-------

### t\_port

    Port

### t\_password

    unix hash thingy - todo: propper checking of format

### t\_password\_plaintext

    Password in plaintext

### t\_key

    Key

dns
===

    DNS

Sources: `./modules/dns`

Tables
------

### custom

    Direct name server entries.

Source: ``

-   Primary key:
    -   id

#### type

Type (?) like MX, A, AAAA, ...

-   Type: dns.t\_type

#### rdata

fancy rdata storage

-   Type: dns.t\_rdata

#### ttl

Time to live, NULL indicates default value

-   Type: dns.t\_ttl
-   Can be *NULL*

#### backend\_status

Status of database entry in backend. NULL: nothing pending, 'ins': entry
not present on backend client, 'upd': update pending on backend client,
'del': deletion peding on backend client.

-   Type: backend.t\_status
-   Can be *NULL*
-   Default value: 'ins'

#### registered

Registered domain of which domain is a sub domain

-   Type: dns.t\_domain
-   References: [dns.registered.domain](#COLUMN-dns.registered.domain)

#### domain

domain of entry

-   Type: dns.t\_domain

#### id

uuid serial number to identify database elements uniquely The default
value is generated using uuid\_generate\_v4().

-   Type: uuid
-   Default value: uuid\_generate\_v4()

### registered

    Domains registered under a public suffix.

Source: ``

-   Primary key:
    -   domain

#### owner

for ownage

-   Type: user.t\_user
-   References: [user.user.owner](#COLUMN-user.user.owner)

#### backend\_status

Status of database entry in backend. NULL: nothing pending, 'ins': entry
not present on backend client, 'upd': update pending on backend client,
'del': deletion peding on backend client.

-   Type: backend.t\_status
-   Can be *NULL*
-   Default value: 'ins'

#### domain

Domain

-   Type: dns.t\_domain

#### public\_suffix

Public Suffix

-   Type: varchar

#### managed

Managed via this system

-   Type: boolean
-   Default value: TRUE

### service

    Name server entries based on system.service (i.e. system.service_dns)

Source: ``

-   Primary key:
    -   domain
    -   service
-   Foreign keys:
    1.  **reference service**
        -   Columns:
            1.  service\_name →
            2.  service →
        -   Referenced columns:
            1.  [system.service.service\_name](#COLUMN-system.service.service_name)
            2.  [system.service.service](#COLUMN-system.service.service)

#### service\_name

Host name

-   Type: dns.t\_domain

#### service

email, ssh, ...

-   Type: system.t\_service

#### backend\_status

Status of database entry in backend. NULL: nothing pending, 'ins': entry
not present on backend client, 'upd': update pending on backend client,
'del': deletion peding on backend client.

-   Type: backend.t\_status
-   Can be *NULL*
-   Default value: 'ins'

#### registered

Registered domain of which domain is a sub domain

-   Type: dns.t\_domain
-   References: [dns.registered.domain](#COLUMN-dns.registered.domain)

#### domain

domain for which the entries should be created

-   Type: dns.t\_domain

Functions
---------

### del\_custom

    Delete Custom

Source: ``

-   Parameters:
    -   **p\_id** *uuid*
-   Variables defined for body:
    -   **v\_owner** *user.t\_user*
    -   **v\_login** *user.t\_user*
-   Returns: void
-   Execute privilege:
    -   [userlogin](#ROLE-userlogin)

Body:

    -- begin userlogin prelude
    v_login := (SELECT t.owner FROM "user"._get_login() AS t);
    v_owner := (SELECT t.act_as FROM "user"._get_login() AS t);
    -- end userlogin prelude


    UPDATE dns.custom AS t
           SET backend_status = 'del'
    FROM dns.registered AS s
    WHERE
        s.domain = t.registered AND

        t.id = p_id AND
        s.owner = v_owner;

    PERFORM backend._conditional_notify_service_name(
        FOUND, 'dns', 'example.com'
    );

### del\_service

    deletes all service entries of a specific domain

Source: ``

-   Parameters:
    -   **p\_domain** *dns.t\_domain*
    -   **p\_service** *system.t\_service*
-   Variables defined for body:
    -   **v\_owner** *user.t\_user*
    -   **v\_login** *user.t\_user*
-   Returns: void
-   Execute privilege:
    -   [userlogin](#ROLE-userlogin)

Body:

    -- begin userlogin prelude
    v_login := (SELECT t.owner FROM "user"._get_login() AS t);
    v_owner := (SELECT t.act_as FROM "user"._get_login() AS t);
    -- end userlogin prelude


    BEGIN
        -- perform DELETE to trigger potential foreign key errors
        DELETE FROM dns.service AS t
        USING dns.registered AS s
        WHERE
            s.domain = t.registered AND

            t.domain = p_domain AND
            t.service = p_service AND
            s.owner = v_owner;

        -- if not failed yet, emulate rollback of DELETE
        RAISE transaction_rollback;
    EXCEPTION
        WHEN transaction_rollback THEN
            UPDATE dns.service AS t
                   SET backend_status = 'del'
            FROM dns.registered AS s
            WHERE
                s.domain = t.registered AND

                t.domain = p_domain AND
                t.service = p_service AND
                s.owner = v_owner;

            PERFORM backend._conditional_notify(
                FOUND, 'dns', p_domain
            );

    END;

### ins\_custom

    Ins Custom

Source: ``

-   Parameters:
    -   **p\_registered** *dns.t\_domain*
    -   **p\_domain** *dns.t\_domain*
    -   **p\_type** *dns.t\_type*
    -   **p\_rdata** *dns.t\_rdata*
    -   **p\_ttl** *integer*
-   Variables defined for body:
    -   **v\_owner** *user.t\_user*
    -   **v\_login** *user.t\_user*
-   Returns: void
-   Execute privilege:
    -   [userlogin](#ROLE-userlogin)

Body:

    -- begin userlogin prelude
    v_login := (SELECT t.owner FROM "user"._get_login() AS t);
    v_owner := (SELECT t.act_as FROM "user"._get_login() AS t);
    -- end userlogin prelude


    INSERT INTO dns.custom
    (registered, domain, type, rdata, ttl)
    VALUES
    (p_registered, p_domain, p_type, p_rdata, p_ttl);

### ins\_registered

    registeres new domain

Source: ``

-   Parameters:
    -   **p\_domain** *dns.t\_domain*
    -   **p\_public\_suffix** *varchar*
-   Variables defined for body:
    -   **v\_owner** *user.t\_user*
    -   **v\_login** *user.t\_user*
-   Returns: void
-   Execute privilege:
    -   [userlogin](#ROLE-userlogin)

Body:

    -- begin userlogin prelude
    v_login := (SELECT t.owner FROM "user"._get_login() AS t);
    v_owner := (SELECT t.act_as FROM "user"._get_login() AS t);
    -- end userlogin prelude

    INSERT INTO dns.registered
    (domain, public_suffix, owner)
    VALUES
    (p_domain, p_public_suffix, v_owner);

### ins\_service

    Creates service dns entry

Source: ``

-   Parameters:
    -   **p\_registered** *dns.t\_domain*
    -   **p\_domain** *dns.t\_domain*
    -   **p\_service\_name** *dns.t\_domain*
    -   **p\_service** *system.t\_service*
-   Variables defined for body:
    -   **v\_owner** *user.t\_user*
    -   **v\_login** *user.t\_user*
-   Returns: void
-   Execute privilege:
    -   [userlogin](#ROLE-userlogin)

Body:

    -- begin userlogin prelude
    v_login := (SELECT t.owner FROM "user"._get_login() AS t);
    v_owner := (SELECT t.act_as FROM "user"._get_login() AS t);
    -- end userlogin prelude

    IF NOT EXISTS(
        SELECT TRUE FROM dns.registered
        WHERE
            domain = p_registered AND
            owner = v_owner
    ) THEN
        PERFORM commons._raise_inaccessible_or_missing();
    END IF;

    UPDATE dns.service
        SET service_name = p_service_name
    WHERE
        registered = p_registered AND
        domain = p_domain AND
        service = p_service;

    IF NOT FOUND THEN
        INSERT INTO dns.service (registered, domain, service_name, service)
             VALUES (p_registered, p_domain, p_service_name, p_service);
    END IF;

    PERFORM backend._notify_domain('dns', p_domain);

### sel\_activatable\_service

    Preliminary implementation

Source: ``

-   Parameters: *non*
-   Variables defined for body:
    -   **v\_owner** *user.t\_user*
    -   **v\_login** *user.t\_user*
-   Returns: TABLE
-   Execute privilege:
    -   [userlogin](#ROLE-userlogin)

Body:

    -- begin userlogin prelude
    v_login := (SELECT t.owner FROM "user"._get_login() AS t);
    v_owner := (SELECT t.act_as FROM "user"._get_login() AS t);
    -- end userlogin prelude

    RETURN QUERY
        SELECT
            t.service,
            t.service_name
        FROM system.service AS t
        ORDER BY t.service, t.service_name;

### sel\_available\_service

    List all domains that have a service entry in dns with their service.
    This is particularly usefull since these domains are ready for use with
    this service. Usually this means that accounts etc. can be created for this
    domain.

Source: ``

-   Parameters: *non*
-   Variables defined for body:
    -   **v\_owner** *user.t\_user*
    -   **v\_login** *user.t\_user*
-   Returns: TABLE
-   Execute privilege:
    -   [userlogin](#ROLE-userlogin)

Body:

    -- begin userlogin prelude
    v_login := (SELECT t.owner FROM "user"._get_login() AS t);
    v_owner := (SELECT t.act_as FROM "user"._get_login() AS t);
    -- end userlogin prelude

    RETURN QUERY
        SELECT t.domain, t.service FROM dns.service AS t
        JOIN dns.registered AS s
            ON s.domain = t.registered
        WHERE
            (
                s.owner = v_owner AND

                    system._contingent_total(
                        p_owner := s.owner,
                        p_service := t.service,
                        p_service_name := t.service_name
                ) IS NOT NULL
            ) OR
            system._contingent_domain(
                        p_owner := s.owner,
                        p_service := t.service,
                        p_service_name := t.service_name,
                        p_domain := t.domain
                ) IS NOT NULL
        ORDER BY t.service
    ;

### sel\_custom

    sel custom

Source: ``

-   Parameters: *non*
-   Variables defined for body:
    -   **v\_owner** *user.t\_user*
    -   **v\_login** *user.t\_user*
-   Returns: TABLE
-   Execute privilege:
    -   [userlogin](#ROLE-userlogin)

Body:

    -- begin userlogin prelude
    v_login := (SELECT t.owner FROM "user"._get_login() AS t);
    v_owner := (SELECT t.act_as FROM "user"._get_login() AS t);
    -- end userlogin prelude

    RETURN QUERY
        SELECT
            t.id,
            t.registered,
            t.domain,
            t.type,
            t.rdata,
            t.ttl,
            t.backend_status
        FROM dns.custom AS t
        JOIN dns.registered AS s
            ON s.domain = t.registered
        WHERE
            s.owner = v_owner
        ORDER BY backend_status, registered, domain;

### sel\_registered

    List registered domains

Source: ``

-   Parameters: *non*
-   Variables defined for body:
    -   **v\_owner** *user.t\_user*
    -   **v\_login** *user.t\_user*
-   Returns: TABLE
-   Execute privilege:
    -   [userlogin](#ROLE-userlogin)

Body:

    -- begin userlogin prelude
    v_login := (SELECT t.owner FROM "user"._get_login() AS t);
    v_owner := (SELECT t.act_as FROM "user"._get_login() AS t);
    -- end userlogin prelude

    RETURN QUERY
        SELECT t.domain, t.public_suffix, t.backend_status
        FROM dns.registered AS t
        WHERE
            t.owner = v_owner
        ORDER BY backend_status, domain;

### sel\_service

    Select service based dns entries

Source: ``

-   Parameters: *non*
-   Variables defined for body:
    -   **v\_owner** *user.t\_user*
    -   **v\_login** *user.t\_user*
-   Returns: TABLE
-   Execute privilege:
    -   [userlogin](#ROLE-userlogin)

Body:

    -- begin userlogin prelude
    v_login := (SELECT t.owner FROM "user"._get_login() AS t);
    v_owner := (SELECT t.act_as FROM "user"._get_login() AS t);
    -- end userlogin prelude

    RETURN QUERY
        SELECT
            t.registered,
            t.domain,
            t.service,
            t.service_name,
            t.backend_status
        FROM dns.service AS t
        JOIN dns.registered AS s
            ON s.domain = t.registered
        WHERE
            s.owner = v_owner
        ORDER BY backend_status, registered, domain, service, service_name;

### srv\_all

    srv all

Source: ``

-   Parameters:
    -   **p\_include\_inactive** *boolean*
-   Variables defined for body:
    -   **v\_machine** *dns.t\_domain*
-   Returns: TABLE
-   Execute privilege:
    -   [backend](#ROLE-backend)

Body:

    v_machine := (SELECT "machine" FROM "backend"._get_login());


    RETURN QUERY
        SELECT
            t.registered,
            COALESCE(s.domain_prefix || t.domain, t.domain)::dns.t_domain,
            s.type,
            s.rdata,
            s.ttl,
            u.managed,
            t.backend_status
        FROM dns.service AS t
        JOIN system.service_dns AS s
            USING (service, service_name)
        JOIN dns.registered AS u
            ON t.registered = u.domain

        UNION ALL

        SELECT
            t.registered,
            t.domain,
            t.type,
            t.rdata,
            t.ttl,
            u.managed,
            t.backend_status
        FROM dns.custom AS t
        JOIN dns.registered AS u
            ON t.registered = u.domain
        ;

### upd\_custom

    Ins Custom

Source: ``

-   Parameters:
    -   **p\_id** *uuid*
    -   **p\_rdata** *dns.t\_rdata*
    -   **p\_ttl** *integer*
-   Variables defined for body:
    -   **v\_owner** *user.t\_user*
    -   **v\_login** *user.t\_user*
-   Returns: void
-   Execute privilege:
    -   [userlogin](#ROLE-userlogin)

Body:

    -- begin userlogin prelude
    v_login := (SELECT t.owner FROM "user"._get_login() AS t);
    v_owner := (SELECT t.act_as FROM "user"._get_login() AS t);
    -- end userlogin prelude


    UPDATE dns.custom AS t
        SET rdata = p_rdata, ttl = p_ttl
    FROM dns.registered AS s

    WHERE
        s.domain = t.registered AND

        t.id = p_id AND
        s.owner = v_owner;

Domains
-------

### t\_domain

    Domain name unicode (not IDN)

### t\_type

    Resource record type

### t\_rdata

    record entry

### t\_ttl

    time to live

domain\_reseller
================

    Domains from reseller

Sources: `./modules/domain_reseller`

Tables
------

### handle

    Domain Handles (Contacts)

Source: ``

-   Primary key:
    -   alias

#### owner

for ownage

-   Type: user.t\_user
-   References: [user.user.owner](#COLUMN-user.user.owner)

#### backend\_status

Status of database entry in backend. NULL: nothing pending, 'ins': entry
not present on backend client, 'upd': update pending on backend client,
'del': deletion peding on backend client.

-   Type: backend.t\_status
-   Can be *NULL*
-   Default value: 'ins'

#### alias

Free choosable alias

-   Type: varchar

#### id

Internal id at reseller

-   Type: varchar
-   Can be *NULL*

#### fname

First name

-   Type: varchar

#### lname

Last name

-   Type: varchar

#### address

Address

-   Type: varchar

#### pcode

Postcode

-   Type: varchar

#### city

City

-   Type: varchar

#### country

Country

-   Type: varchar

#### state

State

-   Type: varchar

#### email

Email

-   Type: email.t\_address

#### phone

Phone

-   Type: varchar

#### fax

Fax

-   Type: varchar
-   Can be *NULL*

#### mobile\_phone

Mobile phone

-   Type: varchar
-   Can be *NULL*

### registered

    Addtional informations to dns.registered

Source: ``

-   Primary key:
    -   domain

#### backend\_status

Status of database entry in backend. NULL: nothing pending, 'ins': entry
not present on backend client, 'upd': update pending on backend client,
'del': deletion peding on backend client.

-   Type: backend.t\_status
-   Can be *NULL*
-   Default value: 'ins'

#### domain

Domain

-   Type: dns.t\_domain
-   References: [dns.registered.domain](#COLUMN-dns.registered.domain)

#### registrant

Registrant (Owner)

-   Type: varchar
-   References:
    [domain\_reseller.handle.alias](#COLUMN-domain_reseller.handle.alias)

#### admin\_c

Admin-C

-   Type: varchar
-   References:
    [domain\_reseller.handle.alias](#COLUMN-domain_reseller.handle.alias)

#### tech\_c

Tech-C

-   Type: varchar
-   Can be *NULL*
-   References:
    [domain\_reseller.handle.alias](#COLUMN-domain_reseller.handle.alias)

#### zone\_c

Zone-C

-   Type: varchar
-   Can be *NULL*
-   References:
    [domain\_reseller.handle.alias](#COLUMN-domain_reseller.handle.alias)

Functions
---------

### del\_handle

    Delete Handle

Source: ``

-   Parameters:
    -   **p\_alias** *varchar*
-   Variables defined for body:
    -   **v\_owner** *user.t\_user*
    -   **v\_login** *user.t\_user*
-   Returns: void
-   Execute privilege:
    -   [userlogin](#ROLE-userlogin)

Body:

    -- begin userlogin prelude
    v_login := (SELECT t.owner FROM "user"._get_login() AS t);
    v_owner := (SELECT t.act_as FROM "user"._get_login() AS t);
    -- end userlogin prelude


    BEGIN
        -- perform DELETE to trigger potential foreign key errors
        DELETE FROM domain_reseller.handle
        WHERE
            alias = p_alias AND
            owner = v_owner;

        -- if not failed yet, emulate rollback of DELETE
        RAISE transaction_rollback;
    EXCEPTION
        WHEN transaction_rollback THEN
            UPDATE domain_reseller.handle
                   SET backend_status = 'del'
            WHERE
                alias = p_alias AND
                owner = v_owner;

            PERFORM backend._conditional_notify(
                FOUND, 'domain_reseller', 'example.org'
            );

    END;

### ins\_handle

    Insert Handle

Source: ``

-   Parameters:
    -   **p\_alias** *varchar*
    -   **p\_fname** *varchar*
    -   **p\_lname** *varchar*
    -   **p\_address** *varchar*
    -   **p\_pcode** *varchar*
    -   **p\_city** *varchar*
    -   **p\_country** *varchar*
    -   **p\_state** *varchar*
    -   **p\_email** *email.t\_address*
    -   **p\_phone** *varchar*
    -   **p\_fax** *varchar*
    -   **p\_mobile\_phone** *varchar*
-   Variables defined for body:
    -   **v\_owner** *user.t\_user*
    -   **v\_login** *user.t\_user*
-   Returns: void
-   Execute privilege:
    -   [userlogin](#ROLE-userlogin)

Body:

    -- begin userlogin prelude
    v_login := (SELECT t.owner FROM "user"._get_login() AS t);
    v_owner := (SELECT t.act_as FROM "user"._get_login() AS t);
    -- end userlogin prelude


    INSERT INTO domain_reseller.handle
    (
      owner,
      alias,
      fname,
      lname,
      address,
      pcode,
      city,
      country,
      state,
      email,
      phone,
      fax,
      mobile_phone
    )
    VALUES
    (
      v_owner,
      p_alias,
      p_fname,
      p_lname,
      p_address,
      p_pcode,
      p_city,
      p_country,
      p_state,
      p_email,
      p_phone,
      p_fax,
      p_mobile_phone
    );

### ins\_registered

    Insert Registered

Source: ``

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

Body:

    -- begin userlogin prelude
    v_login := (SELECT t.owner FROM "user"._get_login() AS t);
    v_owner := (SELECT t.act_as FROM "user"._get_login() AS t);
    -- end userlogin prelude


    INSERT INTO domain_reseller.registered
        (domain, registrant, admin_c)
    VALUES
        (p_domain, p_registrant, p_admin_c);

### sel\_handle

    Select Handle

Source: ``

-   Parameters: *non*
-   Variables defined for body:
    -   **v\_owner** *user.t\_user*
    -   **v\_login** *user.t\_user*
-   Returns: SETOF domain\_reseller."handle"
-   Execute privilege:
    -   [userlogin](#ROLE-userlogin)

Body:

    -- begin userlogin prelude
    v_login := (SELECT t.owner FROM "user"._get_login() AS t);
    v_owner := (SELECT t.act_as FROM "user"._get_login() AS t);
    -- end userlogin prelude


    RETURN QUERY
        SELECT * FROM domain_reseller.handle
    WHERE
        owner=v_owner
    ORDER BY backend_status, fname, lname, alias;

### sel\_registered

    Select Registered

Source: ``

-   Parameters: *non*
-   Variables defined for body:
    -   **v\_owner** *user.t\_user*
    -   **v\_login** *user.t\_user*
-   Returns: TABLE
-   Execute privilege:
    -   [userlogin](#ROLE-userlogin)

Body:

    -- begin userlogin prelude
    v_login := (SELECT t.owner FROM "user"._get_login() AS t);
    v_owner := (SELECT t.act_as FROM "user"._get_login() AS t);
    -- end userlogin prelude

    RETURN QUERY
        SELECT
            t.domain,
            t.registrant,
            t.admin_c,
            t.tech_c,
            t.zone_c,
            t.backend_status
        FROM domain_reseller.registered AS t
        JOIN dns.registered AS s
            USING (domain)
        WHERE
            s.owner = v_owner;

### upd\_handle

    Update Handle

Source: ``

-   Parameters:
    -   **p\_alias** *varchar*
    -   **p\_address** *varchar*
    -   **p\_pcode** *varchar*
    -   **p\_city** *varchar*
    -   **p\_country** *varchar*
    -   **p\_state** *varchar*
    -   **p\_email** *email.t\_address*
    -   **p\_phone** *varchar*
    -   **p\_fax** *varchar*
    -   **p\_mobile\_phone** *varchar*
-   Variables defined for body:
    -   **v\_owner** *user.t\_user*
    -   **v\_login** *user.t\_user*
-   Returns: void
-   Execute privilege:
    -   [userlogin](#ROLE-userlogin)

Body:

    -- begin userlogin prelude
    v_login := (SELECT t.owner FROM "user"._get_login() AS t);
    v_owner := (SELECT t.act_as FROM "user"._get_login() AS t);
    -- end userlogin prelude


    UPDATE domain_reseller.handle
        SET
            backend_status = 'upd',
            address = p_address,
            pcode = p_pcode,
            city = p_city,
            country = p_country,
            state = p_state,
            email = p_email,
            phone = p_phone,
            fax = p_fax,
            mobile_phone = p_mobile_phone

    WHERE
        alias = p_alias AND
        owner = v_owner;

### upd\_registered

    Update Registered

Source: ``

-   Parameters:
    -   **p\_domain** *dns.t\_domain*
    -   **p\_admin\_c** *varchar*
-   Variables defined for body:
    -   **v\_owner** *user.t\_user*
    -   **v\_login** *user.t\_user*
-   Returns: void
-   Execute privilege:
    -   [userlogin](#ROLE-userlogin)

Body:

    -- begin userlogin prelude
    v_login := (SELECT t.owner FROM "user"._get_login() AS t);
    v_owner := (SELECT t.act_as FROM "user"._get_login() AS t);
    -- end userlogin prelude

    UPDATE domain_reseller.registered AS t
        SET
            admin_c = p_admin_c,
            backend_status = 'upd'
    FROM dns.registered AS s
    WHERE
        s.domain = t.domain AND
        s.owner = v_owner AND

        t.domain = p_domain;

email
=====

    E-Mail and Mailing lists ✉

Sources: `./modules/email`

Tables
------

### address

    Collection of all known addresses

Source: ``

-   Primary key:
    -   localpart
    -   domain

#### localpart

Local part

-   Type: email.t\_localpart

#### domain

Domain

-   Type: dns.t\_domain

### alias

    Aliases for e-mail mailboxes, owner is determined by mailbox.owner

Source: ``

-   Primary key:
    -   localpart
    -   domain
-   Foreign keys:
    1.  **reference dns (service)**
        -   Columns:
            1.  domain →
            2.  service →
        -   Referenced columns:
            1.  [dns.service.domain](#COLUMN-dns.service.domain)
            2.  [dns.service.service](#COLUMN-dns.service.service)

    2.  **reference to a mailbox**
        -   Columns:
            1.  mailbox\_localpart →
            2.  mailbox\_domain →
        -   Referenced columns:
            1.  [email.mailbox.localpart](#COLUMN-email.mailbox.localpart)
            2.  [email.mailbox.domain](#COLUMN-email.mailbox.domain)

#### domain

Domain name

-   Type: dns.t\_domain

#### service

Enforce service type in dns.service

-   Type: system.t\_service
-   Default value: 'email'

#### localpart

Local part of the address

-   Type: email.t\_localpart

#### backend\_status

Status of database entry in backend. NULL: nothing pending, 'ins': entry
not present on backend client, 'upd': update pending on backend client,
'del': deletion peding on backend client.

-   Type: backend.t\_status
-   Can be *NULL*
-   Default value: 'ins'

#### mailbox\_localpart

Mailbox to which the mails will be delivered

-   Type: email.t\_localpart

#### mailbox\_domain

Mailbox to which the mails will be delivered

-   Type: dns.t\_domain

### list

    Mailing lists

Source: ``

-   Primary key:
    -   localpart
    -   domain
-   Foreign keys:
    1.  **reference dns (service)**
        -   Columns:
            1.  domain →
            2.  service →
        -   Referenced columns:
            1.  [dns.service.domain](#COLUMN-dns.service.domain)
            2.  [dns.service.service](#COLUMN-dns.service.service)

#### domain

Domain name

-   Type: dns.t\_domain

#### owner

for ownage

-   Type: user.t\_user
-   References: [user.user.owner](#COLUMN-user.user.owner)

#### backend\_status

Status of database entry in backend. NULL: nothing pending, 'ins': entry
not present on backend client, 'upd': update pending on backend client,
'del': deletion peding on backend client.

-   Type: backend.t\_status
-   Can be *NULL*
-   Default value: 'ins'

#### service

Enforce service type in dns.service

-   Type: system.t\_service
-   Default value: 'email'

#### localpart

Local part of the address

-   Type: email.t\_localpart

#### admin

Email address of the list admin

-   Type: email.t\_address

#### options

Arbitrary options

-   Type: jsonb
-   Can be *NULL*

### list\_subscriber

    list subscribers

Source: ``

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

#### backend\_status

Status of database entry in backend. NULL: nothing pending, 'ins': entry
not present on backend client, 'upd': update pending on backend client,
'del': deletion peding on backend client.

-   Type: backend.t\_status
-   Can be *NULL*
-   Default value: 'ins'

#### address

Subscribers address

-   Type: email.t\_address

#### list\_localpart

List

-   Type: email.t\_localpart

#### list\_domain

List

-   Type: dns.t\_domain

### mailbox

    E-mail mailboxs correspond to something a mail user can login into. Basically 
    a mailbox represents a mailbox. A mailbox is bound to a specific address. 
    Further addresses can be linked to mailboxs via aliases.

Source: ``

-   Primary key:
    -   localpart
    -   domain
-   Foreign keys:
    1.  **reference dns (service)**
        -   Columns:
            1.  domain →
            2.  service →
        -   Referenced columns:
            1.  [dns.service.domain](#COLUMN-dns.service.domain)
            2.  [dns.service.service](#COLUMN-dns.service.service)

#### domain

Domain name

-   Type: dns.t\_domain

#### service

Enforce service type in dns.service

-   Type: system.t\_service
-   Default value: 'email'

#### localpart

Local part of the address

-   Type: email.t\_localpart

#### owner

for ownage

-   Type: user.t\_user
-   References: [user.user.owner](#COLUMN-user.user.owner)

#### backend\_status

Status of database entry in backend. NULL: nothing pending, 'ins': entry
not present on backend client, 'upd': update pending on backend client,
'del': deletion peding on backend client.

-   Type: backend.t\_status
-   Can be *NULL*
-   Default value: 'ins'

#### uid

Unix user identifier

-   Type: SERIAL

#### password

Unix shadow crypt format

-   Type: commons.t\_password

#### quota

Quota for mailbox in MiB

-   Type: int
-   Can be *NULL*

### redirection

    Redirections

Source: ``

-   Primary key:
    -   localpart
    -   domain
-   Foreign keys:
    1.  **reference dns (service)**
        -   Columns:
            1.  domain →
            2.  service →
        -   Referenced columns:
            1.  [dns.service.domain](#COLUMN-dns.service.domain)
            2.  [dns.service.service](#COLUMN-dns.service.service)

#### domain

Domain name

-   Type: dns.t\_domain

#### service

Enforce service type in dns.service

-   Type: system.t\_service
-   Default value: 'email'

#### localpart

Local part of the address

-   Type: email.t\_localpart

#### owner

for ownage

-   Type: user.t\_user
-   References: [user.user.owner](#COLUMN-user.user.owner)

#### backend\_status

Status of database entry in backend. NULL: nothing pending, 'ins': entry
not present on backend client, 'upd': update pending on backend client,
'del': deletion peding on backend client.

-   Type: backend.t\_status
-   Can be *NULL*
-   Default value: 'ins'

#### destination

External address to which the mails will be delivered

-   Type: email.t\_address

Functions
---------

### \_address

    List all addresses

Source: ``

-   Parameters: *non*
-   Returns: TABLE

Body:

    RETURN QUERY (
     SELECT t.localpart, t.domain, t.owner FROM email.mailbox AS t
     UNION ALL
     SELECT t.localpart, t.domain, t.owner FROM email.redirection AS t
     UNION ALL
     SELECT t.localpart, t.domain, s.owner FROM email.alias AS t
      LEFT JOIN email.mailbox AS s
       ON
        t.mailbox_localpart = s.localpart AND
        t.mailbox_domain = s.domain
     UNION ALL
     SELECT t.localpart, t.domain, t.owner FROM email.list AS t
    );

### \_address\_valid

    x

Source: ``

-   Parameters:
    -   **p\_localpart** *email.t\_localpart*
    -   **p\_domain** *dns.t\_domain*
-   Returns: void

Body:

    IF (
        SELECT TRUE FROM email._address()
        WHERE
            localpart = p_localpart AND
            domain = p_domain
    ) THEN
        RAISE 'Email address already exists.'
            USING DETAIL = '$carnivora:email:address_already_exists$';
    END IF;

### del\_alias

    Delete Alias

Source: ``

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

Body:

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

    PERFORM backend._conditional_notify(FOUND, 'email', p_domain);

### del\_list

    Delete mailing list

Source: ``

-   Parameters:
    -   **p\_domain** *dns.t\_domain*
    -   **p\_localpart** *email.t\_localpart*
-   Variables defined for body:
    -   **v\_owner** *user.t\_user*
    -   **v\_login** *user.t\_user*
-   Returns: void
-   Execute privilege:
    -   [userlogin](#ROLE-userlogin)

Body:

    -- begin userlogin prelude
    v_login := (SELECT t.owner FROM "user"._get_login() AS t);
    v_owner := (SELECT t.act_as FROM "user"._get_login() AS t);
    -- end userlogin prelude

    DELETE FROM email.list
    WHERE
        domain = p_domain AND
        localpart = p_localpart AND
        owner = v_owner;

    PERFORM backend._conditional_notify(FOUND, 'email__list', p_domain);

### del\_list\_subscriber

    del

Source: ``

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

Body:

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

    PERFORM backend._conditional_notify(FOUND, 'email', p_list_domain);

### del\_mailbox

    Delete mailbox

Source: ``

-   Parameters:
    -   **p\_localpart** *email.t\_localpart*
    -   **p\_domain** *dns.t\_domain*
-   Variables defined for body:
    -   **v\_owner** *user.t\_user*
    -   **v\_login** *user.t\_user*
-   Returns: void
-   Execute privilege:
    -   [userlogin](#ROLE-userlogin)

Body:

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

    PERFORM backend._conditional_notify(FOUND, 'email', p_domain);

### del\_redirection

    Delete redirection

Source: ``

-   Parameters:
    -   **p\_localpart** *email.t\_localpart*
    -   **p\_domain** *dns.t\_domain*
-   Variables defined for body:
    -   **v\_owner** *user.t\_user*
    -   **v\_login** *user.t\_user*
-   Returns: void
-   Execute privilege:
    -   [userlogin](#ROLE-userlogin)

Body:

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

    PERFORM backend._conditional_notify(FOUND, 'email', p_domain);

### ins\_alias

    Create e-mail aliases

Source: ``

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

Body:

    -- begin userlogin prelude
    v_login := (SELECT t.owner FROM "user"._get_login() AS t);
    v_owner := (SELECT t.act_as FROM "user"._get_login() AS t);
    -- end userlogin prelude


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
        (localpart, domain, mailbox_localpart, mailbox_domain)
    VALUES
        (p_localpart, p_domain, p_mailbox_localpart, p_mailbox_domain);

    PERFORM backend._notify_domain('email', p_domain);

### ins\_list

    Creates a mailing list

Source: ``

-   Parameters:
    -   **p\_localpart** *email.t\_localpart*
    -   **p\_domain** *dns.t\_domain*
    -   **p\_admin** *email.t\_address*
-   Variables defined for body:
    -   **v\_num\_total** *int*
    -   **v\_num\_domain** *int*
    -   **v\_owner** *user.t\_user*
    -   **v\_login** *user.t\_user*
-   Returns: void
-   Execute privilege:
    -   [userlogin](#ROLE-userlogin)

Body:

    -- begin userlogin prelude
    v_login := (SELECT t.owner FROM "user"._get_login() AS t);
    v_owner := (SELECT t.act_as FROM "user"._get_login() AS t);
    -- end userlogin prelude


    v_num_total := (SELECT COUNT(*) FROM email.list AS t WHERE t.owner=v_owner);
    v_num_domain := (SELECT COUNT(*) FROM email.list AS t WHERE t.owner=v_owner AND t.domain = p_domain);

    PERFORM system._contingent_ensure(
        p_owner:=v_owner,
        p_domain:=p_domain,
        p_service:='email__list',
        p_current_quantity_total:=v_num_total,
        p_current_quantity_domain:=v_num_domain);

    PERFORM email._address_valid(p_localpart, p_domain);

    INSERT INTO email.list
        (localpart, domain, owner, admin) VALUES
        (p_localpart, p_domain, v_owner, p_admin);

    PERFORM backend._notify_domain('email__list', p_domain);

### ins\_list\_subscriber

    Adds a subscriber to a mailing list

Source: ``

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

Body:

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

    PERFORM backend._notify_domain('email__list', p_list_domain);

### ins\_mailbox

    Creates an email box

Source: ``

-   Parameters:
    -   **p\_localpart** *email.t\_localpart*
    -   **p\_domain** *dns.t\_domain*
    -   **p\_password** *commons.t\_password\_plaintext*
-   Variables defined for body:
    -   **v\_num\_total** *int*
    -   **v\_num\_domain** *int*
    -   **v\_owner** *user.t\_user*
    -   **v\_login** *user.t\_user*
-   Returns: void
-   Execute privilege:
    -   [userlogin](#ROLE-userlogin)

Body:

    -- begin userlogin prelude
    v_login := (SELECT t.owner FROM "user"._get_login() AS t);
    v_owner := (SELECT t.act_as FROM "user"._get_login() AS t);
    -- end userlogin prelude

    v_num_total := (SELECT COUNT(*) FROM email._address() AS t WHERE t.owner=v_owner);
    v_num_domain := (SELECT COUNT(*) FROM email._address() AS t WHERE t.owner=v_owner AND t.domain = p_domain);

    PERFORM system._contingent_ensure(
        p_owner:=v_owner,
        p_domain:=p_domain,
        p_service:='email',
        p_current_quantity_total:=v_num_total,
        p_current_quantity_domain:=v_num_domain);


    PERFORM email._address_valid(p_localpart, p_domain);

    INSERT INTO email.mailbox
        (localpart, domain, owner, password) VALUES
        (p_localpart, p_domain, v_owner, commons._hash_password(p_password));

    PERFORM backend._notify_domain('email', p_domain);

### ins\_redirection

    Creates a redirection

Source: ``

-   Parameters:
    -   **p\_localpart** *email.t\_localpart*
    -   **p\_domain** *dns.t\_domain*
    -   **p\_destination** *email.t\_address*
-   Variables defined for body:
    -   **v\_num\_total** *int*
    -   **v\_num\_domain** *int*
    -   **v\_owner** *user.t\_user*
    -   **v\_login** *user.t\_user*
-   Returns: void
-   Execute privilege:
    -   [userlogin](#ROLE-userlogin)

Body:

    -- begin userlogin prelude
    v_login := (SELECT t.owner FROM "user"._get_login() AS t);
    v_owner := (SELECT t.act_as FROM "user"._get_login() AS t);
    -- end userlogin prelude

    v_num_total := (SELECT COUNT(*) FROM email._address() AS t WHERE t.owner=v_owner);
    v_num_domain := (SELECT COUNT(*) FROM email._address() AS t WHERE t.owner=v_owner AND t.domain = p_domain);

    PERFORM system._contingent_ensure(
        p_owner:=v_owner,
        p_domain:=p_domain,
        p_service:='email',
        p_current_quantity_total:=v_num_total,
        p_current_quantity_domain:=v_num_domain);


    PERFORM email._address_valid(p_localpart, p_domain);

    INSERT INTO email.redirection
        (localpart, domain, destination, owner) VALUES
        (p_localpart, p_domain, p_destination, v_owner);

    PERFORM backend._notify_domain('email', p_domain);

### sel\_alias

    Select aliases

Source: ``

-   Parameters: *non*
-   Variables defined for body:
    -   **v\_owner** *user.t\_user*
    -   **v\_login** *user.t\_user*
-   Returns: TABLE
-   Execute privilege:
    -   [userlogin](#ROLE-userlogin)

Body:

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

### sel\_list

    List all lists

Source: ``

-   Parameters: *non*
-   Variables defined for body:
    -   **v\_owner** *user.t\_user*
    -   **v\_login** *user.t\_user*
-   Returns: TABLE
-   Execute privilege:
    -   [userlogin](#ROLE-userlogin)

Body:

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
            t.backend_status
        FROM
            email.list AS t
        WHERE
            t.owner = v_owner;

### sel\_list\_subscriber

    a

Source: ``

-   Parameters: *non*
-   Variables defined for body:
    -   **v\_owner** *user.t\_user*
    -   **v\_login** *user.t\_user*
-   Returns: TABLE
-   Execute privilege:
    -   [userlogin](#ROLE-userlogin)

Body:

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

### sel\_mailbox

    List all mailboxes

Source: ``

-   Parameters: *non*
-   Variables defined for body:
    -   **v\_owner** *user.t\_user*
    -   **v\_login** *user.t\_user*
-   Returns: TABLE
-   Execute privilege:
    -   [userlogin](#ROLE-userlogin)

Body:

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

### sel\_redirection

    Lists all redirections

Source: ``

-   Parameters: *non*
-   Variables defined for body:
    -   **v\_owner** *user.t\_user*
    -   **v\_login** *user.t\_user*
-   Returns: TABLE
-   Execute privilege:
    -   [userlogin](#ROLE-userlogin)

Body:

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

### srv\_alias

    Lists all email aliases

Source: ``

-   Parameters:
    -   **p\_include\_inactive** *boolean*
-   Variables defined for body:
    -   **v\_machine** *dns.t\_domain*
-   Returns: TABLE
-   Execute privilege:
    -   [backend](#ROLE-backend)

Body:

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

### srv\_list

    Lists all mailinglists

Source: ``

-   Parameters:
    -   **p\_include\_inactive** *boolean*
-   Variables defined for body:
    -   **v\_machine** *dns.t\_domain*
-   Returns: TABLE
-   Execute privilege:
    -   [backend](#ROLE-backend)

Body:

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

### srv\_list\_subscriber

    Lists all mailinglist subscribers

Source: ``

-   Parameters:
    -   **p\_include\_inactive** *boolean*
-   Variables defined for body:
    -   **v\_machine** *dns.t\_domain*
-   Returns: TABLE
-   Execute privilege:
    -   [backend](#ROLE-backend)

Body:

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

### srv\_mailbox

    Lists all mailboxes

Source: ``

-   Parameters:
    -   **p\_include\_inactive** *boolean*
-   Variables defined for body:
    -   **v\_machine** *dns.t\_domain*
-   Returns: TABLE
-   Execute privilege:
    -   [backend](#ROLE-backend)

Body:

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
            t.backend_status
        FROM email.mailbox AS t

        WHERE
            backend._machine_priviledged(t.service, t.domain) AND
            (backend._active(t.backend_status) OR p_include_inactive);

### srv\_redirection

    Lists all mailinglists

Source: ``

-   Parameters:
    -   **p\_include\_inactive** *boolean*
-   Variables defined for body:
    -   **v\_machine** *dns.t\_domain*
-   Returns: TABLE
-   Execute privilege:
    -   [backend](#ROLE-backend)

Body:

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

### upd\_list

    Change list admin

Source: ``

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

Body:

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

    PERFORM backend._conditional_notify(FOUND, 'email__list', p_domain);

### upd\_mailbox

    Change mailbox password

Source: ``

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

Body:

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

    PERFORM backend._conditional_notify(FOUND, 'email', p_domain);

Domains
-------

### t\_localpart

    Local part of an email address, the thing in front of the @

### t\_address

    Email address, TODO validity checks

jabber
======

    Jabber (XMPP)

Sources: `./modules/jabber`

Tables
------

### account

    Jabber accounts

Source: ``

-   Primary key:
    -   node
    -   domain
-   Foreign keys:
    1.  **reference dns (service)**
        -   Columns:
            1.  domain →
            2.  service →
        -   Referenced columns:
            1.  [dns.service.domain](#COLUMN-dns.service.domain)
            2.  [dns.service.service](#COLUMN-dns.service.service)

#### domain

Domain name

-   Type: dns.t\_domain

#### owner

for ownage

-   Type: user.t\_user
-   References: [user.user.owner](#COLUMN-user.user.owner)

#### backend\_status

Status of database entry in backend. NULL: nothing pending, 'ins': entry
not present on backend client, 'upd': update pending on backend client,
'del': deletion peding on backend client.

-   Type: backend.t\_status
-   Can be *NULL*
-   Default value: 'ins'

#### node

part in front of the @ in account name

-   Type: email.t\_localpart

#### password

Unix shadow crypt format

-   Type: commons.t\_password

#### service

Ensures that referenced domain is jabber enabled.

-   Type: varchar
-   Default value: 'jabber'

Functions
---------

### del\_account

    Delete jabber account

Source: ``

-   Parameters:
    -   **p\_node** *email.t\_localpart*
    -   **p\_domain** *dns.t\_domain*
-   Variables defined for body:
    -   **v\_owner** *user.t\_user*
    -   **v\_login** *user.t\_user*
-   Returns: void
-   Execute privilege:
    -   [userlogin](#ROLE-userlogin)

Body:

    -- begin userlogin prelude
    v_login := (SELECT t.owner FROM "user"._get_login() AS t);
    v_owner := (SELECT t.act_as FROM "user"._get_login() AS t);
    -- end userlogin prelude

    DELETE FROM jabber.account
    WHERE
        node = p_node AND
        domain = p_domain AND
        owner = v_owner;

    PERFORM backend._conditional_notify(FOUND, 'jabber', p_domain);

### ins\_account

    Insert jabber account

Source: ``

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

Body:

    -- begin userlogin prelude
    v_login := (SELECT t.owner FROM "user"._get_login() AS t);
    v_owner := (SELECT t.act_as FROM "user"._get_login() AS t);
    -- end userlogin prelude

    v_num_total := (SELECT COUNT(*) FROM jabber.account AS t WHERE t.owner=v_owner);
    v_num_domain := (SELECT COUNT(*) FROM jabber.account AS t WHERE t.owner=v_owner AND t.domain = p_domain);

    PERFORM system._contingent_ensure(
        p_owner:=v_owner,
        p_domain:=p_domain,
        p_service:='jabber',
        p_current_quantity_total:=v_num_total,
        p_current_quantity_domain:=v_num_domain);

    INSERT INTO jabber.account
        (node, domain, owner, password) VALUES
        (p_node, p_domain, v_owner, commons._hash_password(p_password));

    PERFORM backend._notify_domain('jabber', p_domain);

### sel\_account

    Select jabber accounts

Source: ``

-   Parameters: *non*
-   Variables defined for body:
    -   **v\_owner** *user.t\_user*
    -   **v\_login** *user.t\_user*
-   Returns: TABLE
-   Execute privilege:
    -   [userlogin](#ROLE-userlogin)

Body:

    -- begin userlogin prelude
    v_login := (SELECT t.owner FROM "user"._get_login() AS t);
    v_owner := (SELECT t.act_as FROM "user"._get_login() AS t);
    -- end userlogin prelude

    RETURN QUERY
        SELECT
            t.node,
            t.domain,
            t.backend_status
        FROM jabber.account AS t
        WHERE
            t.owner = v_owner
        ORDER BY t.backend_status, t.node, t.domain;

### srv\_account

    Lists all jabber accounts

Source: ``

-   Parameters:
    -   **p\_include\_inactive** *boolean*
-   Variables defined for body:
    -   **v\_machine** *dns.t\_domain*
-   Returns: TABLE
-   Execute privilege:
    -   [backend](#ROLE-backend)

Body:

    v_machine := (SELECT "machine" FROM "backend"._get_login());

    RETURN QUERY
        WITH

        -- DELETE
        d AS (
            DELETE FROM jabber.account AS t
            WHERE
                backend._deleted(t.backend_status) AND
                backend._machine_priviledged(t.service, t.domain)
        ),

        -- UPDATE
        s AS (
            UPDATE jabber.account AS t
                SET backend_status = NULL
            WHERE
                backend._machine_priviledged(t.service, t.domain) AND
                backend._active(t.backend_status)
        )

        -- SELECT
        SELECT
            t.node,
            t.domain,
            t.password,
            t.backend_status
        FROM jabber.account AS t

        WHERE
            backend._machine_priviledged(t.service, t.domain) AND
            (backend._active(t.backend_status) OR p_include_inactive);

### upd\_account

    Change jabber account password

Source: ``

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

Body:

    -- begin userlogin prelude
    v_login := (SELECT t.owner FROM "user"._get_login() AS t);
    v_owner := (SELECT t.act_as FROM "user"._get_login() AS t);
    -- end userlogin prelude

    UPDATE jabber.account
        SET
            password = commons._hash_password(p_password)
    WHERE
        node = p_node AND
        domain = p_domain AND
        owner = v_owner;

    PERFORM backend._conditional_notify(FOUND, 'jabber', p_domain);

server\_access
==============

    Explicit passwd entriesfor shell acounts, sftp etc.

Sources: `./modules/server_access`

Tables
------

### user

    unix user

Source: ``

-   Primary key:
    -   user
-   Foreign keys:
    1.  **reference service**
        -   Columns:
            1.  service\_name →
            2.  service →
        -   Referenced columns:
            1.  [system.service.service\_name](#COLUMN-system.service.service_name)
            2.  [system.service.service](#COLUMN-system.service.service)

#### service\_name

Host name

-   Type: dns.t\_domain

#### service

email, ssh, ...

-   Type: system.t\_service

#### backend\_status

Status of database entry in backend. NULL: nothing pending, 'ins': entry
not present on backend client, 'upd': update pending on backend client,
'del': deletion peding on backend client.

-   Type: backend.t\_status
-   Can be *NULL*
-   Default value: 'ins'

#### owner

for ownage

-   Type: user.t\_user
-   References: [user.user.owner](#COLUMN-user.user.owner)

#### uid

Unix user identifier

-   Type: SERIAL

#### user

User

-   Type: server\_access.t\_user

#### password

Unix shadow crypt format

-   Type: commons.t\_password
-   Can be *NULL*

Functions
---------

### del\_user

    delete

Source: ``

-   Parameters:
    -   **p\_user** *server\_access.t\_user*
    -   **p\_service\_name** *system.t\_service*
-   Variables defined for body:
    -   **v\_owner** *user.t\_user*
    -   **v\_login** *user.t\_user*
-   Returns: void
-   Execute privilege:
    -   [userlogin](#ROLE-userlogin)

Body:

    -- begin userlogin prelude
    v_login := (SELECT t.owner FROM "user"._get_login() AS t);
    v_owner := (SELECT t.act_as FROM "user"._get_login() AS t);
    -- end userlogin prelude

    BEGIN
        -- perform DELETE to trigger potential foreign key errors
        DELETE FROM server_access.user
        WHERE
            "user" = p_user AND
            service_name = p_service_name AND
            owner = v_owner;

        -- if not failed yet, emulate rollback of DELETE
        RAISE transaction_rollback;
    EXCEPTION
        WHEN transaction_rollback THEN
            UPDATE server_access.user
                SET backend_status = 'del'
            WHERE
                "user" = p_user AND
                service_name = p_service_name AND
                owner = v_owner;

            PERFORM backend._conditional_notify_service_name(
                 FOUND, 'server_access', p_service_name
             );

    END;

### ins\_user

    ins user

Source: ``

-   Parameters:
    -   **p\_user** *server\_access.t\_user*
    -   **p\_service\_name** *dns.t\_domain*
    -   **p\_service** *system.t\_service*
    -   **p\_password** *commons.t\_password\_plaintext*
-   Variables defined for body:
    -   **v\_password** *commons.t\_password*
    -   **v\_owner** *user.t\_user*
    -   **v\_login** *user.t\_user*
-   Returns: void
-   Execute privilege:
    -   [userlogin](#ROLE-userlogin)

Body:

    -- begin userlogin prelude
    v_login := (SELECT t.owner FROM "user"._get_login() AS t);
    v_owner := (SELECT t.act_as FROM "user"._get_login() AS t);
    -- end userlogin prelude

    IF p_password IS NULL THEN
        v_password := NULL;
    ELSE
        v_password := commons._hash_password(p_password);
    END IF;

    INSERT INTO server_access.user
        (service, service_name, "user", password, owner)
    VALUES
        (p_service, p_service_name, p_user, v_password, v_owner);

    PERFORM backend._notify_service_name('server_access', p_service_name);

### sel\_user

    sel user

Source: ``

-   Parameters: *non*
-   Variables defined for body:
    -   **v\_owner** *user.t\_user*
    -   **v\_login** *user.t\_user*
-   Returns: TABLE
-   Execute privilege:
    -   [userlogin](#ROLE-userlogin)

Body:

    -- begin userlogin prelude
    v_login := (SELECT t.owner FROM "user"._get_login() AS t);
    v_owner := (SELECT t.act_as FROM "user"._get_login() AS t);
    -- end userlogin prelude

    RETURN QUERY
        SELECT
            t.user,
            t.password IS NOT NULL,
            t.service,
            t.service_name,
            t.backend_status
        FROM
            server_access.user AS t
        WHERE
            owner = v_owner
        ORDER BY backend_status, "user";

### srv\_user

    backend server_access.user

Source: ``

-   Parameters:
    -   **p\_include\_inactive** *boolean*
-   Variables defined for body:
    -   **v\_machine** *dns.t\_domain*
-   Returns: TABLE
-   Execute privilege:
    -   [backend](#ROLE-backend)

Body:

    v_machine := (SELECT "machine" FROM "backend"._get_login());

    RETURN QUERY
        WITH

        -- DELETE
        d AS (
            DELETE FROM server_access.user AS t
            WHERE
                backend._deleted(t.backend_status) AND
                backend._machine_priviledged_service(t.service, t.service_name)
        ),

        -- UPDATE
        s AS (
            UPDATE server_access.user AS t
                SET backend_status = NULL
            WHERE
                backend._machine_priviledged_service(t.service, t.service_name) AND
                backend._active(t.backend_status)
        )

        -- SELECT
        SELECT
            t.user,
            t.password,
            t.service,
            t.service_name,
            t.backend_status
        FROM server_access.user AS t

        WHERE
            backend._machine_priviledged_service(t.service, t.service_name) AND
            (backend._active(t.backend_status) OR p_include_inactive);

### upd\_user

    passwd user

Source: ``

-   Parameters:
    -   **p\_user** *server\_access.t\_user*
    -   **p\_service\_name** *dns.t\_domain*
    -   **p\_password** *commons.t\_password\_plaintext*
-   Variables defined for body:
    -   **v\_password** *commons.t\_password* (default: *NULL*)
    -   **v\_owner** *user.t\_user*
    -   **v\_login** *user.t\_user*
-   Returns: void
-   Execute privilege:
    -   [userlogin](#ROLE-userlogin)

Body:

    -- begin userlogin prelude
    v_login := (SELECT t.owner FROM "user"._get_login() AS t);
    v_owner := (SELECT t.act_as FROM "user"._get_login() AS t);
    -- end userlogin prelude

    IF p_password IS NOT NULL THEN
        v_password := commons._hash_password(p_password);
    END IF;

    UPDATE server_access.user
    SET
        password = v_password,
        backend_status = 'upd'
    WHERE
        "user" = p_user AND
        service_name = p_service_name;

    PERFORM backend._conditional_notify_service_name(
        FOUND, 'server_access', p_service_name
    );

Domains
-------

### t\_user

    Unix user. This type only allows a subset of those names allowed by POSIX.

system
======

    Carnivora System: Central module

Sources: `./modules/system`

Tables
------

### contingent\_default\_domain

    Number of times the service can be used by a user per domain.
    The exact interpretation depends on the module.

Source: ``

-   Primary key:
    -   service
    -   domain
-   Foreign keys:
    1.  **reference service**
        -   Columns:
            1.  service\_name →
            2.  service →
        -   Referenced columns:
            1.  [system.service.service\_name](#COLUMN-system.service.service_name)
            2.  [system.service.service](#COLUMN-system.service.service)

#### service\_name

Host name

-   Type: dns.t\_domain

#### service

email, ssh, ...

-   Type: system.t\_service

#### quantity

Quantity

-   Type: integer
-   Default value: 0

#### domain

Domain for which the contingent holds

-   Type: dns.t\_domain

### contingent\_default\_total

    Number of times the service can be used by a user in total.
    The exact interpretation depends on the module.

Source: ``

-   Primary key:
    -   service
    -   service\_name
-   Foreign keys:
    1.  **reference service**
        -   Columns:
            1.  service\_name →
            2.  service →
        -   Referenced columns:
            1.  [system.service.service\_name](#COLUMN-system.service.service_name)
            2.  [system.service.service](#COLUMN-system.service.service)

#### service\_name

Host name

-   Type: dns.t\_domain

#### service

email, ssh, ...

-   Type: system.t\_service

#### quantity

Quantity

-   Type: integer
-   Default value: 0

### contingent\_domain

    Number of times the service can be used by a user per domain.
    The exact interpretation depends on the module.

Source: ``

-   Primary key:
    -   service
    -   service\_name
    -   domain
    -   owner
-   Foreign keys:
    1.  **reference service**
        -   Columns:
            1.  service\_name →
            2.  service →
        -   Referenced columns:
            1.  [system.service.service\_name](#COLUMN-system.service.service_name)
            2.  [system.service.service](#COLUMN-system.service.service)

#### service\_name

Host name

-   Type: dns.t\_domain

#### service

email, ssh, ...

-   Type: system.t\_service

#### quantity

Quantity

-   Type: integer
-   Default value: 0

#### owner

for ownage

-   Type: user.t\_user
-   References: [user.user.owner](#COLUMN-user.user.owner)

#### domain

Domain for which the contingent holds

-   Type: dns.t\_domain

### contingent\_total

    Number of times the service can be used by a user in total.
    The exact interpretation depends on the module.

Source: ``

-   Primary key:
    -   service
    -   service\_name
    -   owner
-   Foreign keys:
    1.  **reference service**
        -   Columns:
            1.  service\_name →
            2.  service →
        -   Referenced columns:
            1.  [system.service.service\_name](#COLUMN-system.service.service_name)
            2.  [system.service.service](#COLUMN-system.service.service)

#### service\_name

Host name

-   Type: dns.t\_domain

#### service

email, ssh, ...

-   Type: system.t\_service

#### quantity

Quantity

-   Type: integer
-   Default value: 0

#### owner

for ownage

-   Type: user.t\_user
-   References: [user.user.owner](#COLUMN-user.user.owner)

### service

    Names under which services are made available. For example (mail.example.org, email)
    could be a mail-server system referred to as mail.example.org by carnivora.
    Such a system can consist of multiple physical or virtual machines. The corresponding
    machines are listed in system.service_machine. A core feature of services is the
    definition of 'templates' for dns records that have to be present for every domain 
    that uses this service. Such 'templates' have can be defined in system.service_dns.
    Domain names can be enabled for services in dns.service. Service enabled domains
    are automatically equipped with the required dns entries accorting to the existing
    'templates'.

    The service_name might be exposed to users as the address of this service. For
    example as SMTP or SSH server etc. The exact interpretation of the service_name
    depends on the module and the frontend.

Source: ``

-   Primary key:
    -   service\_name
    -   service

#### service\_name

Host name

-   Type: dns.t\_domain

#### service

email, ssh, ...

-   Type: system.t\_service
-   References:
    [system.service\_index.service](#COLUMN-system.service_index.service)

### service\_dns

    Resource records that have to be present to use a service. The records
    in this table can be understood as 'templates'. The table does not
    contain a name (domain) for the records. Rather for every domain that
    uses this service, all appropriate records are created for this domain
    based on this table. The assignment from domain to services can
    be found in dns.service.

Source: ``

-   Primary key:
    -   id
-   Foreign keys:
    1.  **reference service**
        -   Columns:
            1.  service\_name →
            2.  service →
        -   Referenced columns:
            1.  [system.service.service\_name](#COLUMN-system.service.service_name)
            2.  [system.service.service](#COLUMN-system.service.service)

#### service\_name

Host name

-   Type: dns.t\_domain

#### service

email, ssh, ...

-   Type: system.t\_service

#### type

Type (?) like MX, A, AAAA, ...

-   Type: dns.t\_type

#### rdata

fancy rdata storage

-   Type: dns.t\_rdata

#### ttl

Time to live, NULL indicates default value

-   Type: dns.t\_ttl
-   Can be *NULL*

#### id

uuid serial number to identify database elements uniquely The default
value is generated using uuid\_generate\_v4().

-   Type: uuid
-   Default value: uuid\_generate\_v4()

#### domain\_prefix

Prefix

-   Type: varchar
-   Can be *NULL*

### service\_index

    Just a list of services that exist. Modules do register their names
    here. A name must be prefixed with '__' (example: email__)
    or consist of the module name only.

    Use system.setup_register_service(...) to insert into this table.

Source: ``

-   Primary key:
    -   service

#### service

service name

-   Type: system.t\_service

#### module

Module name, just to keep track who uses this name

-   Type: commons.t\_key

### service\_machine

    List of machines that provice a certain service. This information is
    used to provide these machines access to the data they need to provide
    the service. See also the module 'backend'.

Source: ``

-   Primary key:
    -   machine\_name
    -   service\_name
    -   service
-   Foreign keys:
    1.  **reference service**
        -   Columns:
            1.  service\_name →
            2.  service →
        -   Referenced columns:
            1.  [system.service.service\_name](#COLUMN-system.service.service_name)
            2.  [system.service.service](#COLUMN-system.service.service)

#### service\_name

Host name

-   Type: dns.t\_domain

#### service

email, ssh, ...

-   Type: system.t\_service

#### machine\_name

Assigns machine

-   Type: dns.t\_domain
-   References: [backend.machine.name](#COLUMN-backend.machine.name)

Functions
---------

### \_contingent\_domain

    Contingent

Source: ``

-   Parameters:
    -   **p\_owner** *user.t\_user*
    -   **p\_service** *system.t\_service*
    -   **p\_service\_name** *dns.t\_domain*
    -   **p\_domain** *dns.t\_domain*
-   Variables defined for body:
    -   **v\_user** *integer*
    -   **v\_default** *integer*
-   Returns: integer

Body:

    v_user := (
        SELECT t.quantity
        FROM system.contingent_domain AS t
        WHERE
            t.owner = p_owner AND
            t.service = p_service AND
            t.service_name = p_service_name AND
            t.domain = p_domain
    );

    v_default := (
        SELECT t.quantity
        FROM system.contingent_default_domain AS t
        WHERE
            t.service = p_service AND
            t.service_name = p_service_name AND
            t.domain = p_domain
    );

    RETURN COALESCE(v_user, v_default);

### \_contingent\_ensure

    Throws exceptions if the contingent is exceeded

Source: ``

-   Parameters:
    -   **p\_owner** *user.t\_user*
    -   **p\_service** *system.t\_service*
    -   **p\_domain** *dns.t\_domain*
    -   **p\_current\_quantity\_total** *integer*
    -   **p\_current\_quantity\_domain** *integer*
-   Variables defined for body:
    -   **v\_remaining** *integer*
    -   **v\_contingent\_total** *integer*
    -   **v\_contingent\_domain** *integer*
    -   **v\_service\_name** *dns.t\_domain*
    -   **v\_the\_owner** *user.t\_user*
-   Returns: void

Body:

    IF p_owner IS NULL
    THEN
        RAISE 'Owner argument must not be NULL.';
    END IF;

    SELECT
        t.service_name,
        s.owner
    INTO v_service_name, v_the_owner
    FROM dns.service AS t
    JOIN dns.registered AS s
        ON s.domain = t.registered

    WHERE
        t.domain = p_domain AND
        t.service = p_service;

    -- check dns.service entry
    IF v_the_owner IS NULL
    THEN
        RAISE 'Contingent check impossible, since dns.service entry missing.'
            USING
                DETAIL = '$carnivora:system:no_contingent$',
                HINT = (p_owner, p_service, p_domain);
    END IF;

    v_contingent_total := (
            SELECT system._contingent_total
                (
                    p_owner := p_owner,
                    p_service := p_service,
                    p_service_name := v_service_name
                )
        );

    v_contingent_domain := (
            SELECT system._contingent_domain
                (
                    p_owner := p_owner,
                    p_service := p_service,
                    p_service_name := v_service_name,
                    p_domain := p_domain
                )
        );

    IF
        v_contingent_total IS NULL AND
        v_contingent_domain IS NULL
    THEN
        RAISE 'You do no have a contingent'
            USING
                DETAIL = '$carnivora:system:no_contingent$',
                HINT = (p_owner, p_service, v_service_name);
    END IF;

    IF v_contingent_domain IS NULL AND p_owner <> v_the_owner
    THEN
        RAISE 'You are not the owner of dns.service'
            USING
                DETAIL = '$carnivora:system:contingent_not_owner$',
                HINT = (p_owner, p_service, v_service_name);
    END IF;

    IF v_contingent_total <= p_current_quantity_total
    THEN
        RAISE 'Total contingent exceeded'
            USING
                DETAIL = '$carnivora:system:contingent_total_exceeded$',
                HINT = (p_owner, p_service, p_domain, v_contingent_total);
    END IF;

    IF v_contingent_domain <= p_current_quantity_domain
    THEN
        RAISE 'Domain contingent exceeded'
            USING
                DETAIL = '$carnivora:system:contingent_domain_exceeded$',
                HINT = (p_owner, p_service, p_domain, v_contingent_domain);
    END IF;

### \_contingent\_total

    Contingent

Source: ``

-   Parameters:
    -   **p\_owner** *user.t\_user*
    -   **p\_service** *system.t\_service*
    -   **p\_service\_name** *dns.t\_domain*
-   Variables defined for body:
    -   **v\_user** *integer*
    -   **v\_default** *integer*
-   Returns: integer

Body:

    v_user := (
        SELECT t.quantity
        FROM system.contingent_total AS t
        WHERE
            t.owner = p_owner AND
            t.service = p_service AND
            t.service_name = p_service_name
    );

    v_default := (
        SELECT t.quantity
        FROM system.contingent_default_total AS t
        WHERE
            t.service = p_service AND
            t.service_name = p_service_name
    );

    RETURN COALESCE(v_user, v_default);

### \_setup\_register\_service

    Allows modules to register their services during setup.
    Returns the total number of service names registered
    for this module.

Source: ``

-   Parameters:
    -   **p\_module** *commons.t\_key*
    -   **p\_service** *commons.t\_key*
-   Returns: integer

Body:

    INSERT INTO system.service_index
     (module, service) VALUES (p_module, p_service);
    RETURN (SELECT COUNT(*) FROM system.service_index AS s WHERE s.module=p_module);

Domains
-------

### t\_service

    Service

user
====

    Carnivora Users: Users own things objects in the DB,
    and they can login into frontends (edentata)

Sources: `./modules/user`

Tables
------

### deputy

    Deputies for users

Source: ``

-   Primary key:
    -   deputy
    -   represented

#### deputy

Deputy

-   Type: user.t\_user
-   References: [user.user.owner](#COLUMN-user.user.owner)
    -   On delete: CASCADE

#### represented

User for which the deputy can act

-   Type: user.t\_user
-   References: [user.user.owner](#COLUMN-user.user.owner)
    -   On delete: CASCADE

### session

    User login sessions

Source: ``

-   Primary key:
    -   id

#### id

Session id

-   Type: varchar
-   Default value: "user".\_session\_id()

#### owner

for ownage

-   Type: user.t\_user
-   References: [user.user.owner](#COLUMN-user.user.owner)

#### act\_as

Act as

-   Type: user.t\_user

#### started

Session started at this time

-   Type: timestamp
-   Default value: CURRENT\_TIMESTAMP

### user

    User

Source: ``

-   Primary key:
    -   owner

#### owner

User name

-   Type: commons.t\_key

#### password

Unix shadow crypt format

-   Type: commons.t\_password

#### login

Login enabled

-   Type: bool

Functions
---------

### \_get\_login

    Shows informations for the current user login.
    Throws an exception if no login is associated to the
    current database connection.

Source: ``

-   Parameters: *non*
-   Returns: TABLE

Body:

    IF (SELECT TRUE FROM "user"."session"
       WHERE "id"="user"._session_id())
    THEN
       RETURN QUERY SELECT t.owner, t.act_as FROM "user"."session" AS t
           WHERE "id"="user"._session_id();
    ELSE
       RAISE 'Database connection is not associated to a user login.'
           USING HINT := 'Use user.login(...) first.';
    END IF;

### \_session\_id

    Gives an id for the database connection that is unique over all database connections.
    It is used to identify user logins.

    Not sure if this stays unique with distributed infrastructure!

Source: ``

-   Parameters: *non*
-   Returns: varchar

Body:

    RETURN
     session_user || '.' ||
     pg_backend_pid() || '.' ||
     COALESCE((SELECT backend_start FROM pg_stat_get_activity(pg_backend_pid()))::varchar, 'xxx') || '.' ||
     pg_conf_load_time();

### ins\_deputy

    Act as deputy

Source: ``

-   Parameters:
    -   **p\_act\_as** *user.t\_user*
-   Variables defined for body:
    -   **v\_owner** *user.t\_user*
    -   **v\_login** *user.t\_user*
-   Returns: void
-   Execute privilege:
    -   [userlogin](#ROLE-userlogin)

Body:

    -- begin userlogin prelude
    v_login := (SELECT t.owner FROM "user"._get_login() AS t);
    v_owner := (SELECT t.act_as FROM "user"._get_login() AS t);
    -- end userlogin prelude

    UPDATE "user".session AS t
        SET act_as = p_act_as
        FROM "user".deputy AS s
        WHERE
            s.deputy = t.owner AND
            s.represented = p_act_as AND
            t.id = "user"._session_id();

### ins\_login

    Try to bind database connection to new user session.
    Returns valid if sueccessfull, invalid otherwise.

Source: ``

-   Parameters:
    -   **p\_owner** *commons.t\_key*
    -   **p\_password** *commons.t\_password\_plaintext*
-   Returns: boolean
-   Execute privilege:
    -   [userlogin](#ROLE-userlogin)

Body:

    IF
       (SELECT TRUE FROM "user"."user" AS t
           WHERE
               owner = p_owner AND
               commons._passwords_equal(p_password, t.password) AND
               t.login
       )
    THEN
       INSERT INTO "user"."session" (owner, act_as) VALUES (p_owner, p_owner);
       RETURN TRUE;
    ELSE
       RAISE 'Carnivora: invalid user login'
        USING DETAIL = '$carnivora:user:login_invalid$';
       RETURN FALSE;
    END IF;

### sel\_deputy

    sel deputy

Source: ``

-   Parameters: *non*
-   Variables defined for body:
    -   **v\_owner** *user.t\_user*
    -   **v\_login** *user.t\_user*
-   Returns: TABLE
-   Execute privilege:
    -   [userlogin](#ROLE-userlogin)

Body:

    -- begin userlogin prelude
    v_login := (SELECT t.owner FROM "user"._get_login() AS t);
    v_owner := (SELECT t.act_as FROM "user"._get_login() AS t);
    -- end userlogin prelude

    RETURN QUERY
        SELECT t.represented FROM "user".deputy AS t
        WHERE t.deputy = v_login;

### upd\_user

    change user passwd

Source: ``

-   Parameters:
    -   **p\_password** *commons.t\_password\_plaintext*
-   Variables defined for body:
    -   **v\_owner** *user.t\_user*
    -   **v\_login** *user.t\_user*
-   Returns: void
-   Execute privilege:
    -   [userlogin](#ROLE-userlogin)

Body:

    -- begin userlogin prelude
    v_login := (SELECT t.owner FROM "user"._get_login() AS t);
    v_owner := (SELECT t.act_as FROM "user"._get_login() AS t);
    -- end userlogin prelude

    UPDATE "user".user
        SET password = commons._hash_password(p_password)

    WHERE
        owner = v_login;

Domains
-------

### t\_user

    Username

Roles
-----

### userlogin

Do user actions via this group

-   Login:

### system

Highly priviledged user

-   Login:

web
===

    Web

Sources: `./modules/web`

Tables
------

### alias

    Aliases

Source: ``

-   Primary key:
    -   domain
    -   site\_port
-   Foreign keys:
    1.  **reference dns (service)**
        -   Columns:
            1.  domain →
            2.  service →
        -   Referenced columns:
            1.  [dns.service.domain](#COLUMN-dns.service.domain)
            2.  [dns.service.service](#COLUMN-dns.service.service)

    2.  **site**
        -   Columns:
            1.  site →
            2.  service\_name →
            3.  site\_port →
        -   Referenced columns:
            1.  [web.site.domain](#COLUMN-web.site.domain)
            2.  [web.site.service\_name](#COLUMN-web.site.service_name)
            3.  [web.site.port](#COLUMN-web.site.port)

    3.  **dns**
        -   Columns:
            1.  domain →
            2.  service →
            3.  service\_name →
        -   Referenced columns:
            1.  [dns.service.domain](#COLUMN-dns.service.domain)
            2.  [dns.service.service](#COLUMN-dns.service.service)
            3.  [dns.service.service\_name](#COLUMN-dns.service.service_name)

#### domain

Domain name

-   Type: dns.t\_domain

#### backend\_status

Status of database entry in backend. NULL: nothing pending, 'ins': entry
not present on backend client, 'upd': update pending on backend client,
'del': deletion peding on backend client.

-   Type: backend.t\_status
-   Can be *NULL*
-   Default value: 'ins'

#### service

Ensure correct service type

-   Type: system.t\_service
-   Default value: 'web'

#### site

Site

-   Type: dns.t\_domain

#### site\_port

port

-   Type: commons.t\_port
-   Default value: 80

#### service\_name

x

-   Type: dns.t\_domain

### https

    stores https information

Source: ``

-   Primary key:
    -   identifier
    -   domain
-   Foreign keys:
    1.  **site**
        -   Columns:
            1.  domain →
            2.  port →
        -   Referenced columns:
            1.  [web.site.domain](#COLUMN-web.site.domain)
            2.  [web.site.port](#COLUMN-web.site.port)

#### backend\_status

Status of database entry in backend. NULL: nothing pending, 'ins': entry
not present on backend client, 'upd': update pending on backend client,
'del': deletion peding on backend client.

-   Type: backend.t\_status
-   Can be *NULL*
-   Default value: 'ins'

#### identifier

PK

-   Type: commons.t\_key

#### domain

Domain

-   Type: dns.t\_domain

#### port

Port

-   Type: commons.t\_port

#### x509\_request

Certificate request

-   Type: web.t\_cert
-   Can be *NULL*

#### x509\_certificate

Certificate

-   Type: web.t\_cert
-   Can be *NULL*

#### authority\_key\_identifier

Identifier of the certificate that has signed this cert. The Authority
Key Identifier allows to build the chain of trust. See . Hopefully there
exists an entry in web.intermediate\_cert or a root certificate with an
equal subjectKeyIdentifier. Is NULL whenever x509\_certificate is NULL.

-   Type: varchar
-   Can be *NULL*

### intermediate\_cert

    Intermediate certificates

Source: ``

-   Primary key:
    -   subject\_key\_identifier

#### subject\_key\_identifier

Identifies this certificate

-   Type: varchar

#### authority\_key\_identifier

Subject key identifier of the cert that has signed this cert. NULL is
not allowed, since self signed cert do not belong into intermediate
certs.

-   Type: varchar

#### x509\_certificate

Intermediate certificate

-   Type: web.t\_cert

### intermediate\_chain

    xxx

Source: ``

-   Primary key:
    -   domain
    -   identifier
    -   subject\_key\_identifier
-   Foreign keys:
    1.  **https cert**
        -   Columns:
            1.  domain →
            2.  identifier →
        -   Referenced columns:
            1.  [web.https.domain](#COLUMN-web.https.domain)
            2.  [web.https.identifier](#COLUMN-web.https.identifier)

#### domain

Domain

-   Type: dns.t\_domain

#### port

Port

-   Type: commons.t\_port

#### identifier

Identifier

-   Type: commons.t\_key

#### order

Ordering from leaf to root

-   Type: integer

#### subject\_key\_identifier

SubjectKeyIdentifier

-   Type: varchar
-   References:
    [web.intermediate\_cert.subject\_key\_identifier](#COLUMN-web.intermediate_cert.subject_key_identifier)

### site

    Website

Source: ``

-   Primary key:
    -   domain
    -   port
-   Foreign keys:
    1.  **reference dns (service)**
        -   Columns:
            1.  domain →
            2.  service →
        -   Referenced columns:
            1.  [dns.service.domain](#COLUMN-dns.service.domain)
            2.  [dns.service.service](#COLUMN-dns.service.service)

    2.  **https**
        -   Columns:
            1.  domain →
            2.  https →
        -   Referenced columns:
            1.  [web.https.domain](#COLUMN-web.https.domain)
            2.  [web.https.identifier](#COLUMN-web.https.identifier)

    3.  **server\_access**
        -   Columns:
            1.  user →
            2.  service\_name →
        -   Referenced columns:
            1.  [server\_access.user.user](#COLUMN-server_access.user.user)
            2.  [server\_access.user.service\_name](#COLUMN-server_access.user.service_name)

    4.  **dns**
        -   Columns:
            1.  domain →
            2.  service →
            3.  service\_name →
        -   Referenced columns:
            1.  [dns.service.domain](#COLUMN-dns.service.domain)
            2.  [dns.service.service](#COLUMN-dns.service.service)
            3.  [dns.service.service\_name](#COLUMN-dns.service.service_name)

#### domain

Domain name

-   Type: dns.t\_domain

#### backend\_status

Status of database entry in backend. NULL: nothing pending, 'ins': entry
not present on backend client, 'upd': update pending on backend client,
'del': deletion peding on backend client.

-   Type: backend.t\_status
-   Can be *NULL*
-   Default value: 'ins'

#### port

Port

-   Type: commons.t\_port
-   Default value: 80

#### user

Server account under which the htdocs reside

-   Type: server\_access.t\_user

#### service

Ensure correct service type

-   Type: system.t\_service
-   Default value: 'web'

#### service\_name

Service Name

-   Type: dns.t\_domain

#### https

If null, HTTPS is deactivated

-   Type: commons.t\_key
-   Can be *NULL*

Functions
---------

### del\_alias

    del

Source: ``

-   Parameters:
    -   **p\_domain** *dns.t\_domain*
    -   **p\_site\_port** *commons.t\_port*
-   Variables defined for body:
    -   **v\_owner** *user.t\_user*
    -   **v\_login** *user.t\_user*
-   Returns: void
-   Execute privilege:
    -   [userlogin](#ROLE-userlogin)

Body:

    -- begin userlogin prelude
    v_login := (SELECT t.owner FROM "user"._get_login() AS t);
    v_owner := (SELECT t.act_as FROM "user"._get_login() AS t);
    -- end userlogin prelude


    UPDATE web.alias AS t
        SET backend_status = 'del'
    FROM web.site AS s, server_access.user AS u
    WHERE
        -- JOIN web.site
        s.domain = t.site AND

        -- JOIN server_access.user
        u.service_name = t.service_name AND
        u.user = s.user AND

        u.owner = v_owner AND
        t.domain = p_domain AND
        t.site_port = p_site_port;

    PERFORM backend._conditional_notify(FOUND, 'web', p_domain);

### del\_intermediate\_chain

    sdf

Source: ``

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

Body:

    -- begin userlogin prelude
    v_login := (SELECT t.owner FROM "user"._get_login() AS t);
    v_owner := (SELECT t.act_as FROM "user"._get_login() AS t);
    -- end userlogin prelude

    DELETE FROM web.intermediate_chain
    WHERE
        domain = p_domain AND
        port = p_port AND
        identifier = p_identifier;

### del\_site

    del

Source: ``

-   Parameters:
    -   **p\_domain** *dns.t\_domain*
    -   **p\_port** *commons.t\_port*
-   Variables defined for body:
    -   **v\_owner** *user.t\_user*
    -   **v\_login** *user.t\_user*
-   Returns: void
-   Execute privilege:
    -   [userlogin](#ROLE-userlogin)

Body:

    -- begin userlogin prelude
    v_login := (SELECT t.owner FROM "user"._get_login() AS t);
    v_owner := (SELECT t.act_as FROM "user"._get_login() AS t);
    -- end userlogin prelude

    UPDATE web.site AS t
        SET backend_status = 'del'
    FROM server_access.user AS s
    WHERE
        -- JOIN server_access.user
        s.user = t.user AND
        s.service_name = t.service_name AND

        t.domain = p_domain AND
        t.port = p_port AND
        s.owner = v_owner;

    PERFORM backend._conditional_notify(FOUND, 'web', p_domain);

### fwd\_x509\_request

    x509 request

Source: ``

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

Body:

    v_machine := (SELECT "machine" FROM "backend"._get_login());

    UPDATE web.https
        SET x509_request = p_x509_request
    WHERE
        domain = p_domain AND
        port = p_port AND
        identifier = p_identifier;

### ins\_alias

    Insert alias

Source: ``

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

Body:

    -- begin userlogin prelude
    v_login := (SELECT t.owner FROM "user"._get_login() AS t);
    v_owner := (SELECT t.act_as FROM "user"._get_login() AS t);
    -- end userlogin prelude


    PERFORM commons._raise_inaccessible_or_missing(
        EXISTS(
            SELECT TRUE FROM web.site AS t
            JOIN server_access.user AS s
                USING ("user", service_name)
            WHERE
                t.domain = p_site AND
                t.port = p_site_port AND
                s.owner = v_owner
        )
    );

    INSERT INTO web.alias
        (domain, site, site_port, service_name)
    VALUES
        (
            p_domain,
            p_site,
            p_site_port,
            (SELECT service_name FROM web.site WHERE domain = p_site AND port = p_site_port)
        );

    PERFORM backend._notify_domain('web', p_domain);

### ins\_https

    Ins HTTPS

Source: ``

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

Body:

    -- begin userlogin prelude
    v_login := (SELECT t.owner FROM "user"._get_login() AS t);
    v_owner := (SELECT t.act_as FROM "user"._get_login() AS t);
    -- end userlogin prelude

    INSERT INTO web.https
    (domain, port, identifier)
    VALUES
    (p_domain, p_port, p_identifier);

### ins\_intermediate\_cert

    Xxx

Source: ``

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

Body:

    -- begin userlogin prelude
    v_login := (SELECT t.owner FROM "user"._get_login() AS t);
    v_owner := (SELECT t.act_as FROM "user"._get_login() AS t);
    -- end userlogin prelude

    INSERT INTO web.intermediate_cert
        (subject_key_identifier, authority_key_identifier, x509_certificate)
        VALUES
        (p_subject_key_identifier, p_authority_key_identifier, p_x509_certificate);

### ins\_intermediate\_chain

    sdf

Source: ``

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

Body:

    -- begin userlogin prelude
    v_login := (SELECT t.owner FROM "user"._get_login() AS t);
    v_owner := (SELECT t.act_as FROM "user"._get_login() AS t);
    -- end userlogin prelude

    INSERT INTO web.intermediate_chain
    (domain, port, identifier, "order", subject_key_identifier)
    VALUES
    (p_domain, p_port, p_identifier, p_order, p_subject_key_identifier);

### ins\_site

    Insert site
    TODO: check owner and contingent

Source: ``

-   Parameters:
    -   **p\_domain** *dns.t\_domain*
    -   **p\_port** *commons.t\_port*
    -   **p\_user** *server\_access.t\_user*
    -   **p\_service\_name** *dns.t\_domain*
-   Variables defined for body:
    -   **v\_owner** *user.t\_user*
    -   **v\_login** *user.t\_user*
-   Returns: void
-   Execute privilege:
    -   [userlogin](#ROLE-userlogin)

Body:

    -- begin userlogin prelude
    v_login := (SELECT t.owner FROM "user"._get_login() AS t);
    v_owner := (SELECT t.act_as FROM "user"._get_login() AS t);
    -- end userlogin prelude


    INSERT INTO web.site
    (domain, port, "user", service_name)
    VALUES
    (p_domain, p_port, p_user, p_service_name);

    PERFORM backend._notify_domain('web', p_domain);

### sel\_alias

    Select alias

Source: ``

-   Parameters: *non*
-   Variables defined for body:
    -   **v\_owner** *user.t\_user*
    -   **v\_login** *user.t\_user*
-   Returns: TABLE
-   Execute privilege:
    -   [userlogin](#ROLE-userlogin)

Body:

    -- begin userlogin prelude
    v_login := (SELECT t.owner FROM "user"._get_login() AS t);
    v_owner := (SELECT t.act_as FROM "user"._get_login() AS t);
    -- end userlogin prelude

    RETURN QUERY
        SELECT
            t.domain,
            t.site,
            t.site_port,
            t.backend_status
        FROM web.alias AS t

        JOIN web.site AS u
            ON
                u.domain = t.site AND
                u.port = t.site_port

        JOIN server_access.user AS s
            ON
                u.user = s.user AND
                s.service_name = t.service_name

        WHERE s.owner = v_owner
        ORDER BY t.backend_status, t.domain;

### sel\_https

    sel https

Source: ``

-   Parameters: *non*
-   Variables defined for body:
    -   **v\_owner** *user.t\_user*
    -   **v\_login** *user.t\_user*
-   Returns: TABLE
-   Execute privilege:
    -   [userlogin](#ROLE-userlogin)

Body:

    -- begin userlogin prelude
    v_login := (SELECT t.owner FROM "user"._get_login() AS t);
    v_owner := (SELECT t.act_as FROM "user"._get_login() AS t);
    -- end userlogin prelude

    RETURN QUERY
        SELECT
            t.identifier,
            t.domain,
            t.port,
            t.x509_request,
            t.x509_certificate,
            t.authority_key_identifier,
            t.backend_status
        FROM web.https AS t
        ORDER BY t.backend_status, t.identifier;

### sel\_intermediate\_cert

    int

Source: ``

-   Parameters:
    -   **p\_subject\_key\_identifier** *varchar*
-   Variables defined for body:
    -   **v\_owner** *user.t\_user*
    -   **v\_login** *user.t\_user*
-   Returns: TABLE
-   Execute privilege:
    -   [userlogin](#ROLE-userlogin)

Body:

    -- begin userlogin prelude
    v_login := (SELECT t.owner FROM "user"._get_login() AS t);
    v_owner := (SELECT t.act_as FROM "user"._get_login() AS t);
    -- end userlogin prelude

    RETURN QUERY
        SELECT
            t.subject_key_identifier,
            t.authority_key_identifier,
            t.x509_certificate
        FROM web.intermediate_cert AS t
        WHERE
            t.subject_key_identifier = p_subject_key_identifier;

### sel\_intermediate\_chain

    sel

Source: ``

-   Parameters: *non*
-   Variables defined for body:
    -   **v\_owner** *user.t\_user*
    -   **v\_login** *user.t\_user*
-   Returns: TABLE
-   Execute privilege:
    -   [userlogin](#ROLE-userlogin)

Body:

    -- begin userlogin prelude
    v_login := (SELECT t.owner FROM "user"._get_login() AS t);
    v_owner := (SELECT t.act_as FROM "user"._get_login() AS t);
    -- end userlogin prelude

    RETURN QUERY
        SELECT
            t.domain,
            t.port,
            t.identifier,
            t.subject_key_identifier,
            s.x509_certificate,
            t.order
        FROM web.intermediate_chain AS t
        JOIN web.intermediate_cert AS s
            USING (subject_key_identifier)
        ORDER BY t.order;

### sel\_site

    Owner defined via server_access

Source: ``

-   Parameters: *non*
-   Variables defined for body:
    -   **v\_owner** *user.t\_user*
    -   **v\_login** *user.t\_user*
-   Returns: TABLE
-   Execute privilege:
    -   [userlogin](#ROLE-userlogin)

Body:

    -- begin userlogin prelude
    v_login := (SELECT t.owner FROM "user"._get_login() AS t);
    v_owner := (SELECT t.act_as FROM "user"._get_login() AS t);
    -- end userlogin prelude

    RETURN QUERY
        SELECT
            t.domain,
            t.port,
            t.user,
            t.service_name,
            t.https,
            t.backend_status
        FROM web.site AS t
        JOIN server_access.user AS s
            USING ("user", service_name)
        WHERE
            s.owner = v_owner
        ORDER BY t.backend_status, t.domain, t.port;

### srv\_alias

    backend web.alias

Source: ``

-   Parameters:
    -   **p\_include\_inactive** *boolean*
-   Variables defined for body:
    -   **v\_machine** *dns.t\_domain*
-   Returns: TABLE
-   Execute privilege:
    -   [backend](#ROLE-backend)

Body:

    v_machine := (SELECT "machine" FROM "backend"._get_login());

    RETURN QUERY
        WITH

        -- DELETE
        d AS (
            DELETE FROM web.alias AS t
            WHERE
                backend._deleted(t.backend_status) AND
                backend._machine_priviledged(t.service, t.domain)
        ),

        -- UPDATE
        s AS (
            UPDATE web.alias AS t
                SET backend_status = NULL
            WHERE
                backend._machine_priviledged(t.service, t.domain) AND
                backend._active(t.backend_status)
        )

        -- SELECT
        SELECT
            t.domain,
            t.site,
            t.site_port,
            t.backend_status
        FROM web.alias AS t

        WHERE
            backend._machine_priviledged(t.service, t.domain) AND
            (backend._active(t.backend_status) OR p_include_inactive);

### srv\_https

    Certs

Source: ``

-   Parameters:
    -   **p\_include\_inactive** *boolean*
-   Variables defined for body:
    -   **v\_machine** *dns.t\_domain*
-   Returns: TABLE
-   Execute privilege:
    -   [backend](#ROLE-backend)

Body:

    v_machine := (SELECT "machine" FROM "backend"._get_login());


    RETURN QUERY
        WITH

        -- NO DELETE OPTION

        -- UPDATE
        s AS (
            UPDATE web.https AS t
                SET backend_status = NULL
            WHERE
                backend._machine_priviledged('web', t.domain) AND
                backend._active(t.backend_status)
        )

        -- SELECT
        SELECT
            t.identifier,
            t.domain,
            t.port,
            t.x509_request,
            t.x509_certificate,
            ARRAY(
                SELECT s.x509_certificate::varchar
                FROM web.intermediate_chain AS u
                JOIN web.intermediate_cert AS s
                    USING (subject_key_identifier)
                WHERE
                    u.domain = t.domain AND
                    u.identifier = t.identifier
                ORDER by "order"
            ),
            t.backend_status
        FROM web.https AS t

        WHERE
            backend._machine_priviledged('web', t.domain) AND
            (backend._active(t.backend_status) OR p_include_inactive);

### srv\_site

    backend web.site

Source: ``

-   Parameters:
    -   **p\_include\_inactive** *boolean*
-   Variables defined for body:
    -   **v\_machine** *dns.t\_domain*
-   Returns: TABLE
-   Execute privilege:
    -   [backend](#ROLE-backend)

Body:

    v_machine := (SELECT "machine" FROM "backend"._get_login());

    RETURN QUERY
        WITH

        -- DELETE
        d AS (
            DELETE FROM web.site AS t
            WHERE
                backend._deleted(t.backend_status) AND
                backend._machine_priviledged(t.service, t.domain)
        ),

        -- UPDATE
        s AS (
            UPDATE web.site AS t
                SET backend_status = NULL
            WHERE
                backend._machine_priviledged(t.service, t.domain) AND
                backend._active(t.backend_status)
        )

        -- SELECT
        SELECT
            t.domain,
            t.port,
            t.user,
            t.service_name,
            t.https,
            t.backend_status
        FROM web.site AS t

        WHERE
            backend._machine_priviledged(t.service, t.domain) AND
            (backend._active(t.backend_status) OR p_include_inactive);

### upd\_https

    upd https

Source: ``

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

Body:

    -- begin userlogin prelude
    v_login := (SELECT t.owner FROM "user"._get_login() AS t);
    v_owner := (SELECT t.act_as FROM "user"._get_login() AS t);
    -- end userlogin prelude

    UPDATE web.https
        SET
            x509_certificate = p_x509_certificate,
            authority_key_identifier = p_authority_key_identifier
    WHERE
        domain = p_domain AND
        port = p_port AND
        identifier = p_identifier;

    PERFORM backend._conditional_notify(FOUND, 'web', p_domain);

### upd\_site

    set https identif.

Source: ``

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

Body:

    -- begin userlogin prelude
    v_login := (SELECT t.owner FROM "user"._get_login() AS t);
    v_owner := (SELECT t.act_as FROM "user"._get_login() AS t);
    -- end userlogin prelude


    UPDATE web.site AS t
        SET https = p_identifier
    FROM server_access.user AS s, dns.service AS u
    WHERE
        s.user = t.user AND
        s.service_name = u.service_name AND

        -- dns.service JOIN
        t.domain = u.domain AND
        t.service = u.service AND

        s.owner = v_owner AND
        t.domain = p_domain AND
        t.port = p_port;

    PERFORM backend._conditional_notify(FOUND, 'web', p_domain);

Domains
-------

### t\_cert

    PEM cert
