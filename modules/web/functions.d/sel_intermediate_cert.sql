name: sel_intermediate_cert
description: int

templates:
 - user.userlogin

returns: TABLE
returns_columns:
 -
  name: subject_key_identifier
  type: varchar
 -
  name: authority_key_identifier
  type: varchar
 -
  name: x509_certificate
  type: web.t_cert

parameters:
 -
  name: p_subject_key_identifier
  type: varchar

body: |
    RETURN QUERY
        SELECT
            t.subject_key_identifier,
            t.authority_key_identifier,
            t.x509_certificate
        FROM web.intermediate_cert AS t
        WHERE
            t.subject_key_identifier = p_subject_key_identifier;
