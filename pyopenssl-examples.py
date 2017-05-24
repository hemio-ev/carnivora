#!/usr/bin/env python3

from OpenSSL import crypto
from cryptography.hazmat.primitives.serialization import Encoding
from cryptography.hazmat.primitives.serialization import PublicFormat

def f(x, y):
    crt = crypto.load_certificate(crypto.FILETYPE_PEM, x)
    csr = crypto.load_certificate_request(crypto.FILETYPE_PEM, y)
    print(list(getCrtAltDnsNames(crt)))
    print(list(getCsrAltDnsNames(csr)))
    print(getPublicBytes(crt))
    print(getPublicBytes(csr))

def getPublicBytes(crt):
    return crt.get_pubkey().to_cryptography_key() \
            .public_bytes(Encoding.DER, PublicFormat.SubjectPublicKeyInfo)

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
    if altExtension:
        for x in map(str.strip, str(altExtension).split(',')):
            split = x.split(':')
            if len(split) == 2 and split[0] == 'DNS':
                yield split[1]

x = """
-----BEGIN CERTIFICATE-----
MIIFSDCCBDCgAwIBAgIRALkS4bF8aQ5ClnLlEB1GNrAwDQYJKoZIhvcNAQELBQAw
XzELMAkGA1UEBhMCRlIxDjAMBgNVBAgTBVBhcmlzMQ4wDAYDVQQHEwVQYXJpczEO
MAwGA1UEChMFR2FuZGkxIDAeBgNVBAMTF0dhbmRpIFN0YW5kYXJkIFNTTCBDQSAy
MB4XDTE1MDIxNzAwMDAwMFoXDTE2MDIxNzIzNTk1OVowczEhMB8GA1UECxMYRG9t
YWluIENvbnRyb2wgVmFsaWRhdGVkMRswGQYDVQQLExJHYW5kaSBTdGFuZGFyZCBT
U0wxMTAvBgNVBAMTKGF1dG9mYXN0ZW4tZWlzZW5hY2gud2ViaG9zdGluZy5oZW1p
by5vcmcwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQC3IFBLHL0RiAPa
pQ8tpCXag4nKzcViP0MIU2V8q4MAtYS4exoiMi3lENLf3W03QdC2rrOkHguE1r1X
/tuDRjYua00taK83b5fManEAKMVC/iM42EaupHbydkiVF7tl03BAAxrpLT55fxR+
TdDBywbi9Peu1VUHdO4yUUGcN748sfOMqxp4l57kQbj0RyE5TwUMQA+Yo2l12RlL
yNG79ZiZlSn2pdLOoDVjXRXE+y3gN2kkKeZmUhdVJl3YqsLXCSCO0jvIalviO02X
Jly8gbXdj3T3kFmf7GMV6at+Cxk2LNYfDbY/kvE555U6NK5W8sL0vl3yHMYenQML
uaJPIEXDAgMBAAGjggHpMIIB5TAfBgNVHSMEGDAWgBSzkKfYya9OzWE8n3ytXX9B
/Wkw6jAdBgNVHQ4EFgQUtgHc4T1S2rZD3IOFzKKxLpoUxskwDgYDVR0PAQH/BAQD
AgWgMAwGA1UdEwEB/wQCMAAwHQYDVR0lBBYwFAYIKwYBBQUHAwEGCCsGAQUFBwMC
MEsGA1UdIAREMEIwNgYLKwYBBAGyMQECAhowJzAlBggrBgEFBQcCARYZaHR0cHM6
Ly9jcHMudXNlcnRydXN0LmNvbTAIBgZngQwBAgEwQQYDVR0fBDowODA2oDSgMoYw
aHR0cDovL2NybC51c2VydHJ1c3QuY29tL0dhbmRpU3RhbmRhcmRTU0xDQTIuY3Js
MHMGCCsGAQUFBwEBBGcwZTA8BggrBgEFBQcwAoYwaHR0cDovL2NydC51c2VydHJ1
c3QuY29tL0dhbmRpU3RhbmRhcmRTU0xDQTIuY3J0MCUGCCsGAQUFBzABhhlodHRw
Oi8vb2NzcC51c2VydHJ1c3QuY29tMGEGA1UdEQRaMFiCKGF1dG9mYXN0ZW4tZWlz
ZW5hY2gud2ViaG9zdGluZy5oZW1pby5vcmeCLHd3dy5hdXRvZmFzdGVuLWVpc2Vu
YWNoLndlYmhvc3RpbmcuaGVtaW8ub3JnMA0GCSqGSIb3DQEBCwUAA4IBAQAudeqS
ARRtOD4+SYuCAHhClJTSTfEqqQbNi6jSiyOdC+C17H4zmL1ht2Gos/76lzXLpUT7
iQxEQtFExbLvpKGvYOZRJlo+7fo/p+39waLDT5dqW/DS1CKUl3btcyaPQqQkS6AV
SxVMwTJmdJwxICmEhVbnLIPTVoPKpkSpVyjpITKGBJApE5pfJ5p4HnmpTqJ8UK5Z
xyqf2SDS4qkeGzBiPg144KplVPYLrSbJFq1kAU7wRofwElByROrmszjONzY0jWaK
tYBpJ2D9RMSFXIm0s3oe3wfrNLRZ+soKfoQ1CvrHS5d7Uzx7JuahrnQTg6FceVPh
NXDgJNr+xJ4lehEw
-----END CERTIFICATE-----
"""

y3 = """
-----BEGIN CERTIFICATE REQUEST-----
MIIEVTCCAj0CAQAwEDEOMAwGA1UEAwwFdGVzdHgwggIiMA0GCSqGSIb3DQEBAQUA
A4ICDwAwggIKAoICAQDIzb7zEofduOc2Qq3ueMD09O20LVAHuociOx7BLG/UAChV
ShuEcRsZSE0OH4jicR8fH311NRQ2ZwqmKvC3kJtG2U0BeVBewnPvmr6/0WQzktrU
fCAJGdOStBNWwy+e1f5ro8OKTUwAlBCvi7J4EnmSiP/OANd2wtSmu2OcKEVamYGB
xFJJSqnzDnJ598cvbb0TWJA148n82+8rdfr5LmrE2NbJ23DWtLrYIPImqX1tXmHB
qLlYQSuxZiscR3YCMAp3ptSM/jWx+bzAPFUdmCzG4B2x1DACdh82+JgxEuiEOUJ9
/UclycsLR36YlrFYibBMy+Q70BM1QwOQC6WdxLHM71XXLUO+1irINJb2o/Tmofee
8IM4ezWBpU9yvyn9HNxIFsNm5D6pfa8pC5fI6QHovivRbe665PhlQPFPwlnEYVGg
n/haSvUyPzA/Tv/792pc+079p3proZRihIbb9BhSi0dkPP0qjw9X6pFcI0W4TZLy
2ck7YYmFXlG3bZo2yaXqiTqXs30eG7+BNd2CNxbMvIRJ1hE/nv+oG5y9tKz/VEN4
ZRqno4TWGg0EwKnesnMYrMIGoGtfJs5DNuHTgBP2kQAKU4Wqz2JGlVDsq3UwiRF5
U2xDZ688DAtO9uQuk0BYF3lU3b8IBAxJriSW5/UQOi/RGTXVIpF/3ZaxuiCVUwID
AQABoAAwDQYJKoZIhvcNAQELBQADggIBAIzNbGCWzU7qLcGtRJlrfzQ6eaOS3Gqs
BPMRRTWggr+049yDOWNoNg73Mki2OyYRDJfwnW92bCnAcTl2Cx2mDtbfOmOQ7j27
/ykURFkkEKhprsPxidvPVPFI4PAWWQi+IAit7wWrPrM9ahd6J+LX9qAOY+BjNzjc
qG/gETasZvh1zhsh18qoGgJAIsVTzMUEc/YqDbvJ7QXI/73xe5zKfjSgk5ZmtzxY
2Qj+rIe7Y44FD/2N8GUBeUVXlLVC/EwHAbrLGMuwDMceT6SW2iaJYjf7+Cnc8bj4
oOjwJSkeR3ynZxRAsRqAKnB66EvvRZL/AwsSnAKr8FZPg1TdHRtUOZljo4UvOvfj
2kCrBpLvTwMFppWzXQxR6neT12/qpzu9u8oainVPLuGqSCziZjKicwMB3aEAzQOB
kkeNwS0FXSkasT3C8CeMAJjMD/ulnF8TmjJvEGZgYA7s5aTd5rGXGq9bkm6mAEr5
/sWV74XVbIc9CumABFMLLGAP1cRjeMiD7CwXsNCw9kaanHx7Vjd1B3eCUvDWeLmk
usYK1h7QIQOqgrxQ6CHWTk3FLUA2pzRsacHXJ/jCaVqeC7grRDD6FaFY5Q5ySkE7
Aqv+8iQIw8qRXMCdGZPaT22WF9If+V5qEvjsKWfE/JUfZ4CJ0bQKzPo8invv2VZA
V6TG0FEwC0Gm
-----END CERTIFICATE REQUEST-----
"""

y2="""
-----BEGIN CERTIFICATE REQUEST-----
MIIEWDCCAkACAQAwEzERMA8GA1UEAwwIaGVtaW8uZGUwggIiMA0GCSqGSIb3DQEB
AQUAA4ICDwAwggIKAoICAQDIADidEyXbpX8zFrcQWYnQxzIoS83ngZNdWudlwmNm
vRrGUohUFerUQqpVKj6PX2BMWpYfnFSNMw4r9Qn1o3AN3j7I1ap0vMmz6roFD6C7
1v3dX93AXKuu/71eARU8RE6TRLtvQJD/As2nESWVg25S7xhOn9dqvZUsFNNBcOAX
WVLvI1HjFYYfVLhawYXtKKWE1iol6LCkuAESofhcfRu2Np09QHyawZykZMyhnUfK
WycNMr1WN4tJbTKzYXc8gZPg91BavkzFb/BxmedIHf0r5+YyvcyPo5roxZg+DVOa
asUrXTawSbfVzAdWVmpzNNCP1XamTcDHltNjA0Nc6tasBWJHk7xJNvOoKCkOXFwS
T39I8AQ/iTGTd27FZvckk0+qQFuiHXofGysvJzGzqwKFyyeRxva7cOLkzd254vIa
tIORjx0B1VnBPX+AfQ4PhtKO47NaxWwhkBbi6l2nmnqWMHyj25wlyfEDh70ftjGr
jYGUS9CgeIK+N00JpYY7x98CoBHUVRZbDOxf3K+CphsA48Y/PUs1yc1JaJ5cmfDe
MYoUNQMmflXzWbWpjuM06Wt3ccCyOlp8oOKcO+6ejvHN7KmzpFVeNp2te1UlNO0h
hOul6DuBDlcfhv/teMxjQRbeq7NTtnXAvEj9Tq81vkuDtFJFjwh7KbQP0pLs+JI5
FwIDAQABoAAwDQYJKoZIhvcNAQELBQADggIBAImU4bcFPjh/Yg0bxosV3zAJg7EO
prePpqGq9mlpg1YeMxyHRDkIc++yWUuKnuQyY/Fxk8OSuj+OucHzcOII698wUn3w
c3yzQNE83qv4QPaAv7CBhrHY3UCV/YNZSxT7895YXmHO4aA4ASuJKKS28Hh6qQ7W
LiPOGb98cJcz9hJsOa1RLBwHt25tPM2QkRcfvG9DaQibQL0k4GLYQ34SxFgY7C9l
YC7r4DnIOMi3KaWx6XcfRG124kMWI0/Z8b9Aw7GueKVc8TgOyIx9BUFpao6zIalv
V7PgSanZK8Yw7NbrJTsJ4QclFZUBvu3AS+ihCgagzLwDaVEWYOxbmDQL769/9AVg
hyD+EcprPRgkJiBVgntA7dwYoMcikA+ePnFUEFLOJzEp+RNYGmJ5sPWNMcwTS5n1
wUwzedzW0kNNEkzNEsLlvWtkseTHC9gmSJAhaPTFSWHEqbV5aQedhsnJ7xy9rx2i
g6j/UCjvuga8MCK7HqWDLyewRcxUK66L/jZPSmyawBimR7D969xgfpi0ijkoKi7/
N1IB06Je9tcGsvCDF1raZ5L+tLJSYn80G2fBggsD6/t8UABZMWnJJ8lMYn4rLV2O
W1ZYWhj27JZ1cxOEQMu9Snim1088NLwNIw8MhZ0zjR7Nv+7nxHv7mWYA5kb6uKb5
JicPmn5YdRj+SylV
-----END CERTIFICATE REQUEST-----
"""

y="""
-----BEGIN CERTIFICATE REQUEST-----
MIIC3DCCAcQCAQAwgZYxCzAJBgNVBAYTAkRFMRwwGgYDVQQIDBNOb3JkcmhlaW4t
V2VzdGZhbGVuMQ0wCwYDVQQHDARIYW1tMRgwFgYDVQQKDA9BdXRvZmFzdGVuIEhh
bW0xGzAZBgNVBAMMEmF1dG9mYXN0ZW4taGFtbS5kZTEjMCEGCSqGSIb3DQEJARYU
bWhlcm9sZEBjb2xvcm1vdmUuZGUwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEK
AoIBAQDLAi7kZkyhgWpaQz6C9PcTEtbSvvH2367sdiSRfcczs/NNWKYa4vYtgd3K
rSL6W2mmrq4vxL/VzCAlukMpbR5ujaOl41LPMsidwzfukVXX4WGKrxyoqdDm+0vI
dOpEwvtywrqjlwPlE7a9ox5HSTREkzKsvZRSFbhhDW+fsz1S3iMJNHh0v//+7rh0
N6vqxMSxhwVGRrAQ/WB8P9ptN81aoAmxFWtluPJDEh1V7wFDOJJMH4BR65DM/DSk
Jrl2WoD9d3uOgTpoEbmAAQ+tPXASpM+lHsFhhpFimfHQwsot5UWHBsdhG+4cgJk/
CK4q/wipX9kwGWb1kVqqX+gvVjCPAgMBAAGgADANBgkqhkiG9w0BAQsFAAOCAQEA
UeM28QB383fr9ix0ELQ4w6EUrGpLuMeCC/y6A2aCxeRl3cPbeF/RnQuvXrfDtPDJ
r+AhrnvJ/bEzYbx4GUlQEq46lVQd7hvwWIXlAPQjt4P2+KBNT18BHN5x237oKypo
gqwQcKfS++6z8lNPnvOE1Q8EPAlY3J+XL997kwZu5+crVBz67RjulWOIdRk02TjY
JCFJTkbGbUibgWOttkadMpygw5KdKacyMU33B0zP9WCIIdaHHQGoW+VV/JPML5lh
KgKhgp1M5iw7Ogtpwed5go+fU3yMcAqCbSw2ALzt6lm5AMhvRd4k34o1DGrqH8DD
Z+fNqgXyRbeBBZ3Z3eNOYA==
-----END CERTIFICATE REQUEST-----
"""

f(x,y)
f(x,y2)
f(x,y3)

