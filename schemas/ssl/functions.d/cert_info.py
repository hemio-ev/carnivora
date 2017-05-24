---
name: cert_info
description: Certificate signing request information
returns: ssl.t_cert_info
language: plpython3u
parameters:
 - name: p_cert
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

def getCrtAltDnsNames(crt):
    return getAltDnsNames(getExtensions(crt))

def getExtensions(crt):
    for i in range(crt.get_extension_count()):
        yield crt.get_extension(i)

v_crt = crypto.load_certificate(crypto.FILETYPE_ASN1, p_cert)
v_alt = list(getCrtAltDnsNames(v_crt))

return { 'subjectAltName' : v_alt}

