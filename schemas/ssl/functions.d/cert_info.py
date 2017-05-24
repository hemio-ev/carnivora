---
name: cert_info
description: Certificate information
returns: varchar[]
language: plpython3u
parameters:
 - name: p_cert
   type: bytea
 - name: p_signing_request
   type: bool
   default: "FALSE"
---

from OpenSSL import crypto

def f(x, y):
    crt = crypto.load_certificate(crypto.FILETYPE_PEM, x)
    csr = crypto.load_certificate_request(crypto.FILETYPE_PEM, y)
    print(list(getCrtAltDnsNames(crt)))
    print(list(getCsrAltDnsNames(csr)))

def getCrtAltDnsNames(crt):
    return getAltDnsNames(getExtensions(crt))

def getCsrAltDnsNames(csr):
    return getAltDnsNames(csr.get_extensions())

def getExtensions(crt):
    for i in range(crt.get_extension_count()):
        yield crt.get_extension(i)

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

if p_signing_request:
  v_csr = crypto.load_certificate_request(crypto.FILETYPE_ASN1, p_cert)
  v_alt = list(getCsrAltDnsNames(v_csr))
else:
  v_crt = crypto.load_certificate(crypto.FILETYPE_ASN1, p_cert)
  v_alt = list(getCrtAltDnsNames(v_crt))
  

return [v_alt[0]]

