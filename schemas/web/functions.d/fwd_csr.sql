name: fwd_x509_request
description: x509 request

templates:
 - backend.backend

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
  name: p_x509_request
  type: web.t_cert

body: |
    UPDATE web.https
        SET x509_request = p_x509_request
    WHERE
        domain = p_domain AND
        port = p_port AND
        identifier = p_identifier;
