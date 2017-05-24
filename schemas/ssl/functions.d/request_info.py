---
name: request_info
description: Certificate signing request information
returns: ssl.t_request_info
language: plpython3u
parameters:
 - name: p_request
   type: bytea
templates:
 - ssl.openssl
---

def getCsrAltDnsNames(csr):
    return getAltDnsNames(csr.get_extensions())

v_csr = crypto.load_certificate_request(crypto.FILETYPE_ASN1, p_request)

return {
 'subjectAltName' : list(getCsrAltDnsNames(v_csr)),
 'public_key_bytes': getPublicBytes(v_csr)
 }

