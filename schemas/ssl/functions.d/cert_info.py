---
name: cert_info
description: Certificate signing request information
returns: ssl.t_cert_info
language: plpython3u
parameters:
 - name: p_cert
   type: bytea
templates:
 - ssl.openssl
---

def getCrtAltDnsNames(crt):
    return getAltDnsNames(getExtensions(crt))

def getExtensions(crt):
    for i in range(crt.get_extension_count()):
        yield crt.get_extension(i)

v_crt = crypto.load_certificate(crypto.FILETYPE_ASN1, p_cert)

return {
 'subjectAltName' : list(getCrtAltDnsNames(v_crt)),
 'public_key_bytes': getPublicBytes(v_crt)
 }

