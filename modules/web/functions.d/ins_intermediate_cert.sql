name: ins_intermediate_cert
description: Xxx

templates:
 - user.userlogin

returns: void

parameters:
 -
  name: p_subject_key_identifier
  type: varchar
 -
  name: p_authority_key_identifier
  type: varchar
 -
  name: p_x509_certificate
  type: web.t_cert

body: |
    INSERT INTO web.intermediate_cert
        (subject_key_identifier, authority_key_identifier, x509_certificate)
        VALUES
        (p_subject_key_identifier, p_authority_key_identifier, p_x509_certificate);

