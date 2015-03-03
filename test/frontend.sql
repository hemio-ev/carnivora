
SELECT "user".ins_login('user1', 'testtest');

SELECT email.ins_mailbox('vorname', 'my.example.com', 'my-pw-123');
SELECT email.ins_alias('vorname-nachname', 'my.example.com', 'vorname', 'my.example.com');
SELECT email.ins_alias('v.name', 'my.example.com', 'vorname', 'my.example.com');

SELECT email.ins_mailbox('jobs', 'my.example.com', 'testtest');
SELECT email.upd_mailbox('jobs', 'my.example.com', 'my-new-pw');

SELECT email.ins_redirection('guest', 'my.example.com', 'other-server.example.com');

SELECT email.ins_list('all', 'lists.example.com', 'admin@my.example.com');
SELECT email.ins_list_subscriber('user@xy.example.org', 'all', 'lists.example.com');
SELECT email.ins_list_subscriber('user25@xy.example.org', 'all', 'lists.example.com');
SELECT email.ins_list_subscriber('name@xy.example.org', 'all', 'lists.example.com');
SELECT email.ins_list_subscriber('LLkd@abc.example.org', 'all', 'lists.example.com');

SELECT * FROM email.sel_alias();
SELECT * FROM email.sel_mailbox();
SELECT * FROM email.sel_list();

SELECT jabber.ins_account('name','jab.example.com','password');
SELECT jabber.del_account('name','jab.example.com');
SELECT jabber.ins_account('name','jab.example.com','password');
SELECT jabber.upd_account('name','jab.example.com','password');
SELECT * FROM jabber.sel_account();

SELECT dns.ins_service('example.com', 'www.example.com', 'hosting.example.org', 'web');
SELECT dns.del_service('www.example.com', 'web');

SELECT server_access.ins_user('test', 'hosting.example.org', 'server_access__sftp');
--SELECT server_access.del_user('test', 'hosting.example.org');

SELECT * FROM dns.sel_service();

SELECT web.ins_site('www.example.com', 'test', 'hosting.example.org');
SELECT web.ins_https('www.example.com', '2015');
SELECT web.upd_site('www.example.com', '2015');

--SELECT server_access.del_user('test', 'hosting.example.org');

SELECT * FROM web.sel_alias();

