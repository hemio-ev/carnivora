---
name: cert_is_signed
description: |
 Check signed
 
 .. todo :: use ``set_time()`` with pyopenssl >= v17.0

returns: bool
language: plpython3u
parameters:
 - name: p_cert
   type: ssl.t_cert
 - name: p_intermediate
   type: ssl.t_cert
templates:
 - ssl.openssl
---

v_cert = crypto.load_certificate(crypto.FILETYPE_ASN1, p_cert)
v_intermediate = crypto.load_certificate(crypto.FILETYPE_ASN1, p_intermediate)

v_store = crypto.X509Store()
v_store.add_cert(v_intermediate)
#v_store.set_time(asn1Time(v_cert.get_notAfter()))

v_store_context = crypto.X509StoreContext(v_store, v_cert)
v_store_context.verify_certificate()

return True
