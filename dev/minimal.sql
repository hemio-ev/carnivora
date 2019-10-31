\! bash -c "canini service reload --config-dir ."

SET search_path = NOTHING;

INSERT INTO "user"."user"
    (contact_email, option, owner, password) VALUES (NULL, '{}', 'user-1', '$6$jFYU9r3PuU5K0nq0$rz4wbtPvkdA2N2xXLGGkHKBEZjPOj9qdF6laEWd.vlLx6G5E/sbGGQ/mhJTRTytEEG4JZBrM1hBxYZw8S5DMD/'),
    (NULL, '{}', 'user-2', '$6$jFYU9r3PuU5K0nq0$rz4wbtPvkdA2N2xXLGGkHKBEZjPOj9qdF6laEWd.vlLx6G5E/sbGGQ/mhJTRTytEEG4JZBrM1hBxYZw8S5DMD/');

INSERT INTO "user"."user" (contact_email, option, owner, password) VALUES
    (NULL, '{}', 'grp-x', NULL),
    (NULL, '{}', 'grp-a', NULL),
    (NULL, '{}', 'grp-z', NULL),
    (NULL, '{}', 'grp-5', NULL),
    (NULL, '{}', 'grp-1', NULL);

INSERT INTO "user".deputy (deputy, represented) VALUES
    ('user-1', 'grp-x'),
    ('user-1', 'grp-a'),
    ('user-1', 'grp-z'),
    ('user-1', 'grp-1'),
    ('user-1', 'grp-5');

-- CONTINGENT

INSERT INTO system.subservice_entity_contingent (domain_contingent, owner, service, service_entity_name, subservice, total_contingent)
 VALUES
    (2, 'user-1', 'web', 'web.my-org.example', 'site', 2),
    (2, 'user-2', 'web', 'web.my-org.example', 'site', 2),
    (3, 'user-1', 'email', 'mail.my-org.example', 'mailbox', 3),
    (2, 'user-1', 'email', 'mail.my-org.example', 'list', 3),
    (1, 'user-1', 'domain_registered', 'nameserver.invalid', 'managed', 1),
    (1, 'user-1', 'domain_reseller', 'reseller.invalid', 'handle', 1),
    (1, 'user-1', 'email', 'mail.my-org.example', 'dns_activatable', 1);

-- DNS

INSERT INTO dns.registered (backend_status, domain, owner, public_suffix, service, service_entity_name, subservice)
 VALUES ('ins', 'my-org.example', 'user-1', 'example', 'domain_registered', 'nameserver.invalid', 'managed');
 
INSERT INTO dns.registered (backend_status, domain, owner, public_suffix, service, service_entity_name, subservice)
 VALUES ('ins', 'fun.example', 'user-1', 'example', 'domain_registered', 'nameserver.invalid', 'managed');

INSERT INTO domain_reseller.handle (address, alias, backend_status, city, country, email, fax, fname, id, lname, mobile_phone, organization, owner, pcode, phone, service, service_entity_name, state, subservice) VALUES ('Adresse 1', 'Vorname-Nachname', 'ins', 'Stadt', 'DE', 'email@user.invalid', '', 'Vorname', NULL, 'Nachname', '', '', 'user-1', '12345', '+49-3-11', 'domain_reseller', 'reseller.invalid', 'Bundesland', 'handle');
INSERT INTO domain_reseller.registered (admin_c, domain, last_status, payable, period, registrant, registrar_status, registry_status, tech_c, zone_c) VALUES ('Vorname-Nachname', 'my-org.example', NULL, NULL, NULL, 'Vorname-Nachname', NULL, NULL, NULL, NULL);
INSERT INTO domain_reseller.registered (admin_c, domain, last_status, payable, period, registrant, registrar_status, registry_status, tech_c, zone_c) VALUES ('Vorname-Nachname', 'fun.example', NULL, NULL, NULL, 'Vorname-Nachname', NULL, NULL, NULL, NULL);

-- EMAIL

INSERT INTO dns.service (backend_status, domain, registered, service, service_entity_name)
 VALUES ('ins', 'some.fun.example', 'fun.example', 'email', 'mail.my-org.example');
INSERT INTO dns.service (backend_status, domain, registered, service, service_entity_name)
 VALUES ('ins', 'fun.example', 'fun.example', 'email', 'mail.my-org.example');

-- USER

SELECT "user".ins_login('user-1', 'FOMgwkMXmS');
SELECT 'user login', 'user-1', 'FOMgwkMXmS';

SELECT "user".upd_user('FOMgwkMXmS');

-- EMAIL

SELECT email.ins_mailbox('have', 'fun.example', 'myPassword');
SELECT email.ins_mailbox('have2', 'fun.example', 'myPassword');

-- SERVER_ACCESS

SELECT server_access.ins_user(p_user:='sshusr', p_service_entity_name:='web.my-org.example', p_subservice:='ssh');

-- WEB

/*
INSERT INTO web.storage
 (service, port, service_entity_name, storage_service, storage_service_entity_name)
 VALUES
 ('web', 80, 'web.my-org.example', 'server_access', 'ssh.my-org.example'),
 ('web', 443, 'web.my-org.example', 'server_access', 'ssh.my-org.example');
*/

INSERT INTO dns.service (backend_status, domain, registered, service, service_entity_name)
 VALUES ('ins', 'www.fun.example', 'fun.example', 'web', 'web.my-org.example');

SELECT web.ins_site(
  p_domain:='www.fun.example',
  p_port:=80,
  p_user:='sshusr',
  p_service_entity_name:='web.my-org.example'
);

SELECT web.upd_site('www.fun.example', 80, NULL);

SELECT web.ins_site(
  p_domain:='www.fun.example',
  p_port:=443,
  p_user:='sshusr',
  p_service_entity_name:='web.my-org.example'
);

-- TESTS

SELECT "user".del_login();
SELECT "user".ins_login('user-2', 'FOMgwkMXmS');

CREATE FUNCTION public.tests() RETURNS void AS
$$ BEGIN
    BEGIN
        PERFORM server_access.upd_user(
            p_user:='sshusr',
            p_service_entity_name:='web.my-org.example',
            p_password:='myNewPassword');
        ASSERT FALSE;
    EXCEPTION
        WHEN assert_failure THEN
            RAISE EXCEPTION 'Test #1 FAILED!!!';
        WHEN raise_exception THEN
            RAISE NOTICE 'Test #1 passed.';
    END;

    BEGIN
        PERFORM email.ins_mailbox('localpart', 'fun.example', 'myPassword');
        ASSERT FALSE;
    EXCEPTION
        WHEN assert_failure THEN
            RAISE EXCEPTION 'Test #2 FAILED!!!';
        WHEN raise_exception THEN
            RAISE NOTICE 'Test #2 passed.';
    END;

    BEGIN
        PERFORM web.ins_site(
          p_domain:='www.fun.example',
          p_port:=81,
          p_user:='sshusr',
          p_service_entity_name:='web.my-org.example'
        );
        ASSERT FALSE;
    EXCEPTION
        WHEN assert_failure THEN
            RAISE EXCEPTION 'Test #3 FAILED!!!';
        WHEN foreign_key_violation THEN
            RAISE NOTICE 'Test #3 passed.';
    END;

    /*
    BEGIN
        PERFORM server_access.ins_user(
            p_user:='sshusr-2',
            p_service_entity_name:='web.my-org.example',
            p_subservice:='ssh');
        ASSERT FALSE;
    EXCEPTION
        WHEN assert_failure THEN
            RAISE EXCEPTION 'Test #4 FAILED!!!';
        WHEN raise_exception THEN
            RAISE NOTICE 'Test #4 passed.';
    END;
    */

END $$ LANGUAGE plpgsql;

SELECT public.tests();
