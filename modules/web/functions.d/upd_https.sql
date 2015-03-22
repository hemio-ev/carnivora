name: upd_https
description: upd https

templates:
 - user.userlogin

returns: void

parameters:
 -
  name: p_domain
  type: dns.t_domain
 -
  name: p_port
  type: commons.t_port
 -
  name: p_identifier
  type: commons.t_key
 -
  name: p_x509_certificate
  type: web.t_cert
 -
  name: p_authority_key_identifier
  type: varchar

body: |
    UPDATE web.https
        SET
            x509_certificate = p_x509_certificate,
            authority_key_identifier = p_authority_key_identifier
    WHERE
        domain = p_domain AND
        port = p_port AND
        identifier = p_identifier;

    PERFORM backend._conditional_notify(FOUND, 'web', p_domain);
