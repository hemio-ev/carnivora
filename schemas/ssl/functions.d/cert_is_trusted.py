---
name: cert_is_trusted
description: trusted?
returns: bool
language: plpython3u
parameters:
 - name: p_cert
   type: ssl.t_cert
templates:
 - ssl.openssl
---

v_cert = crypto.load_certificate(crypto.FILETYPE_ASN1, p_cert)

v_store = crypto.X509Store()

v_store_context = crypto.X509StoreContext(v_store, v_cert)
v_store_context.verify_certificate()

return True
