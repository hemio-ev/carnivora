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
  name: p_identifier
  type: commons.t_key
 -
  name: p_x509_certificate
  type: text
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
        identifier = p_identifier;
