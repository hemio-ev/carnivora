INSERT INTO system.machine
    (name) VALUES
    ('mail-server.example.org'),
    ('web-server.example.org')
;

INSERT INTO system.service
    (service_name, service) VALUES
--    ('web.example.org.', 'webhosting'),
--    ('web.example.org.', 'ssh'),
    ('mail.example.org', 'email')
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
    ('mail.example.org', 'email', 'mail-server.example.org')
;

INSERT INTO "user".contingent_service
    (service, user_name, quantity) VALUES
    ('email', 'user1', 15)
;

--INSERT INTO "user".contingent_service_domain
--    (service, user_name, domain, quantity) VALUES
--    ('email', 'user1', 'my.example.com', 4)
--;

INSERT INTO "user"."user"
    (name, password, login) VALUES
    ('user1', commons._hash_password('testtest'), true)
    ,('user2', 'pw', true)
;

INSERT INTO backend.auth
    (machine, role) VALUES
    ('mail-server.example.org', 'postgres')
;

--SELECT "user".login('user1', 'pw-falsch');
SELECT "user".ins_login('user1', 'testtest');

INSERT INTO dns.service (service_name, service, domain, owner) VALUES ('mail.example.org', 'email', 'my.example.com', 'user1');


SELECT "user"._get_login();


SELECT email.ins_mailbox('vorname', 'my.example.com', 'my-pw-123');
SELECT email.ins_alias('vorname.nachname', 'my.example.com', 'vorname', 'my.example.com');
SELECT email.ins_alias('v.name', 'my.example.com', 'vorname', 'my.example.com');

SELECT email.ins_mailbox('jobs', 'my.example.com', 'my-pw-456');
SELECT email.upd_mailbox('jobs', 'my.example.com', 'my-new-pw');

SELECT backend._get_login();
SELECT * FROM email.srv_mailbox();
SELECT * FROM email.srv_alias();

SELECT * FROM email._address();
SELECT * FROM email.sel_alias();
SELECT * FROM email.sel_mailbox();

SELECT email.ack_mailbox();