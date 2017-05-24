---
name: cert_request_info
description: Certificate signing request information
returns: ssl.t_cert_request_info
language: plpython3u
parameters:
 - name: p_cert_request
   type: bytea
---

# global

from OpenSSL import crypto

def selExtension(shortName, extensions):
    for x in extensions:
        if x.get_short_name() == shortName:
            return x
    else:
        None
            
def getAltDnsNames(extensions):
    altExtension = selExtension(b'subjectAltName', extensions)
    print(altExtension)
    if altExtension:
        for x in map(str.strip, str(altExtension).split(',')):
            split = x.split(':')
            if len(split) == 2 and split[0] == 'DNS':
                yield split[1]

# CRT

"""
def getCrtAltDnsNames(crt):
    return getAltDnsNames(getExtensions(crt))

def getExtensions(crt):
    for i in range(crt.get_extension_count()):
        yield crt.get_extension(i)

v_crt = crypto.load_certificate(crypto.FILETYPE_ASN1, p_cert)
v_alt = list(getCrtAltDnsNames(v_crt))
"""

# CSR

def getCsrAltDnsNames(csr):
    return getAltDnsNames(csr.get_extensions())

v_csr = crypto.load_certificate_request(crypto.FILETYPE_ASN1, p_cert_request)
v_alt = list(getCsrAltDnsNames(v_csr))

return { 'subjectAltName' : v_alt}

