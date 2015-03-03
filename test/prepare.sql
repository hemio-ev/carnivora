INSERT INTO "user"."user"
    (owner, password, login) VALUES
    ('user1', commons._hash_password('testtest'), true)
    ,('user2', commons._hash_password('testtest2'), true)
;

INSERT INTO backend.machine
    (name) VALUES
    ('mail-server.example.org'),
    ('web-server.example.org')
;

INSERT INTO backend.auth
    (role, machine) VALUES
    ('carnivora_mailserver', 'mail-server.example.org')
;

INSERT INTO system.service
    (service_name, service) VALUES
--    ('web.example.org.', 'webhosting'),
--    ('web.example.org.', 'ssh'),
    ('mail.example.org', 'email'),
    ('mail.example.org', 'jabber'),
    ('hosting.example.org', 'web'),
    ('hosting.example.org', 'server_access__ssh'),
    ('hosting.example.org', 'server_access__sftp'),
    ('jabber.example.org', 'jabber'),
    ('mail.example.org', 'email__list')
;

INSERT INTO system.service_dns
    (service_name, service, type, rdata, ttl) VALUES
--    ('web.example.org.', 'webhosting', 'A', '127.0.0.1', 73),
--    ('web.example.org.', 'ssh', 'A', '127.0.0.1', 73),
    ('mail.example.org', 'email', 'MX', 'mail-server.example.org', 73)
;

INSERT INTO system.service_machine
    (service_name, service, machine_name) VALUES
    --('web.example.org.', 'webhosting', 'web-server.example.org.'),
    --('web.example.org.', 'ssh', 'web-server.example.org.'),
    ('mail.example.org', 'email', 'mail-server.example.org'),
    ('mail.example.org', 'jabber', 'mail-server.example.org'),
    ('jabber.example.org', 'jabber', 'mail-server.example.org'),
    ('mail.example.org', 'email__list', 'mail-server.example.org')
;

INSERT INTO system.contingent_total
    (service, service_name, owner, quantity) VALUES
    ('email', 'mail.example.org', 'user1', 17),
    ('jabber', 'jabber.example.org', 'user1', 3),
    ('web', 'hosting.example.org', 'user1', 3),
    ('email__list', 'mail.example.org', 'user1', 15)
;

--INSERT INTO "user".contingent_service_domain
--    (service, user_name, domain, quantity) VALUES
--    ('email', 'user1', 'my.example.com', 4)
--;

INSERT INTO backend.auth
    (machine, role) VALUES
    ('mail-server.example.org', 'postgres')
;

INSERT INTO dns.registered (domain, public_suffix, owner)
    VALUES
    ('example.com', 'com', 'user1');

INSERT INTO dns.service (registered,service_name, service, domain)
    VALUES
    ('example.com','mail.example.org', 'email', 'my.example.com'),
    ('example.com','mail.example.org', 'email', 'another.example.com'),
    ('example.com','mail.example.org', 'email__list', 'lists.example.com'),
    ('example.com','jabber.example.org', 'jabber', 'jab.example.com');


