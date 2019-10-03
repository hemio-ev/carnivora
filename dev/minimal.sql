\! bash -c "canini service reload --config-dir ."

SET search_path = NOTHING;

INSERT INTO "user"."user" (contact_email, option, owner, password) VALUES (NULL, '{}', 'user-1', '$6$jFYU9r3PuU5K0nq0$rz4wbtPvkdA2N2xXLGGkHKBEZjPOj9qdF6laEWd.vlLx6G5E/sbGGQ/mhJTRTytEEG4JZBrM1hBxYZw8S5DMD/');

INSERT INTO "user"."user" (contact_email, option, owner, password) VALUES (NULL, '{}', 'grp-x', NULL);
INSERT INTO "user"."user" (contact_email, option, owner, password) VALUES (NULL, '{}', 'grp-a', NULL);
INSERT INTO "user"."user" (contact_email, option, owner, password) VALUES (NULL, '{}', 'grp-z', NULL);
INSERT INTO "user"."user" (contact_email, option, owner, password) VALUES (NULL, '{}', 'grp-5', NULL);
INSERT INTO "user"."user" (contact_email, option, owner, password) VALUES (NULL, '{}', 'grp-1', NULL);

INSERT INTO "user".deputy (deputy, represented) VALUES ('user-1', 'grp-x');
INSERT INTO "user".deputy (deputy, represented) VALUES ('user-1', 'grp-a');
INSERT INTO "user".deputy (deputy, represented) VALUES ('user-1', 'grp-z');
INSERT INTO "user".deputy (deputy, represented) VALUES ('user-1', 'grp-1');
INSERT INTO "user".deputy (deputy, represented) VALUES ('user-1', 'grp-5');

-- CONTINGENT

INSERT INTO system.subservice_entity_contingent (domain_contingent, owner, service, service_entity_name, subservice, total_contingent)
 VALUES (1, 'user-1', 'email', 'mail.my-org.example', 'mailbox', 1);
 
INSERT INTO system.subservice_entity_contingent (domain_contingent, owner, service, service_entity_name, subservice, total_contingent)
 VALUES (2, 'user-1', 'email', 'mail.my-org.example', 'list', 3);
 
INSERT INTO system.subservice_entity_contingent (domain_contingent, owner, service, service_entity_name, subservice, total_contingent)
 VALUES (1, 'user-1', 'domain_registered', 'nameserver.invalid', 'managed', 1);
 
INSERT INTO system.subservice_entity_contingent (domain_contingent, owner, service, service_entity_name, subservice, total_contingent)
 VALUES (1, 'user-1', 'domain_reseller', 'reseller.invalid', 'handle', 1);
INSERT INTO system.subservice_entity_contingent (domain_contingent, owner, service, service_entity_name, subservice, total_contingent)
 VALUES (1, 'user-1', 'email', 'mail.my-org.example', 'dns_activatable', 1);

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

INSERT INTO email.mailbox (backend_status, domain, localpart, option, owner, password, quota, service, service_entity_name, subservice) VALUES ('ins', 'fun.example', 'have', '{}', 'user-1', '$6$MTAdqajZww0GX3ay$qj.BaDMfcNhB3vs.u.KNkOk/e/Crg.TnVBxIyqE9DvEQJAJbPUjC6cZ5FIwvoGBoCPZ5GynX.kqDoTuxcLegQ0', NULL, 'email', 'mail.my-org.example', 'mailbox');
INSERT INTO email.mailbox (backend_status, domain, localpart, option, owner, password, quota, service, service_entity_name, subservice) VALUES ('ins', 'fun.example', 'have2', '{}', 'user-1', '$6$MTAdqajZww0GX3ay$qj.BaDMfcNhB3vs.u.KNkOk/e/Crg.TnVBxIyqE9DvEQJAJbPUjC6cZ5FIwvoGBoCPZ5GynX.kqDoTuxcLegQ0', NULL, 'email', 'mail.my-org.example', 'mailbox');

-- USER

SELECT "user".ins_login('user-1', 'FOMgwkMXmS');
SELECT 'user login', 'user-1', 'FOMgwkMXmS';

-- SERVER_ACCESS

SELECT server_access.ins_user(p_user:='sshusr', p_service_entity_name:='web.my-org.example', p_subservice:='ssh');

-- WEB

--INSERT INTO web.storage
-- (service, port, service_entity_name, storage_service, storage_service_entity_name)
-- VALUES
-- ('web', 80, 'web.my-org.example', 'server_access', 'ssh.my-org.example'),
-- ('web', 443, 'web.my-org.example', 'server_access', 'ssh.my-org.example');

INSERT INTO dns.service (backend_status, domain, registered, service, service_entity_name)
 VALUES ('ins', 'www.fun.example', 'fun.example', 'web', 'web.my-org.example');

SELECT web.ins_site(
  p_domain:='www.fun.example',
  p_port:=80,
  p_user:='sshusr',
  p_service_entity_name:='web.my-org.example'
);

SELECT web.ins_site(
  p_domain:='www.fun.example',
  p_port:=443,
  p_user:='sshusr',
  p_service_entity_name:='web.my-org.example'
);

