ssl
======================================================================

SSL Certificates

.. contents:: Schema Contents
   :local:
   :depth: 2



Tables
------


.. _TABLE-ssl.active:

``ssl.active``
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Active cert_active

Primary key
 - demand_id
 - machine_name


.. BEGIN FKs

Foreign keys
 - Reference service entity

   Local Columns
    - service_entity_name
    - service

   Referenced Columns
    - :ref:`system.service_entity.service_entity_name <COLUMN-system.service_entity.service_entity_name>`
    - :ref:`system.service_entity.service <COLUMN-system.service_entity.service>`

 - machine_with_service

   Local Columns
    - service
    - service_entity_name
    - machine_name

   Referenced Columns

 - currently_active

   Local Columns
    - currently
    - machine_name

   Referenced Columns
    - :ref:`ssl.cert.id <COLUMN-ssl.cert.id>`
    - :ref:`ssl.cert.machine_name <COLUMN-ssl.cert.machine_name>`


.. END FKs


Columns
 - .. _COLUMN-ssl.active.service_entity_name:
   
   ``service_entity_name`` :ref:`dns.t_domain <DOMAIN-dns.t_domain>`
     Service entity name





 - .. _COLUMN-ssl.active.service:
   
   ``service`` :ref:`commons.t_key <DOMAIN-commons.t_key>`
     Service (e.g. email, jabber)





 - .. _COLUMN-ssl.active.demand_id:
   
   ``demand_id`` :ref:`uuid <DOMAIN-uuid>`
     X





 - .. _COLUMN-ssl.active.machine_name:
   
   ``machine_name`` :ref:`dns.t_domain <DOMAIN-dns.t_domain>`
     Machine





 - .. _COLUMN-ssl.active.currently:
   
   ``currently`` *NULL* | :ref:`uuid <DOMAIN-uuid>`
     Currently active certificate





 - .. _COLUMN-ssl.active.subsequently:
   
   ``subsequently`` *NULL* | :ref:`uuid <DOMAIN-uuid>`
     Next certificate that will be active







.. _TABLE-ssl.cert:

``ssl.cert``
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

SSL (X.509) certificate

Primary key
 - id


.. BEGIN FKs

Foreign keys
 - Reference service entity

   Local Columns
    - service_entity_name
    - service

   Referenced Columns
    - :ref:`system.service_entity.service_entity_name <COLUMN-system.service_entity.service_entity_name>`
    - :ref:`system.service_entity.service <COLUMN-system.service_entity.service>`

 - active_fk

   Local Columns
    - service
    - service_entity_name
    - machine_name

   Referenced Columns


.. END FKs


Columns
 - .. _COLUMN-ssl.cert.service_entity_name:
   
   ``service_entity_name`` :ref:`dns.t_domain <DOMAIN-dns.t_domain>`
     Service entity name





 - .. _COLUMN-ssl.cert.service:
   
   ``service`` :ref:`commons.t_key <DOMAIN-commons.t_key>`
     Service (e.g. email, jabber)





 - .. _COLUMN-ssl.cert.id:
   
   ``id`` :ref:`uuid <DOMAIN-uuid>`
     UUID

   Default
    .. code-block:: sql

     commons._uuid()




 - .. _COLUMN-ssl.cert.machine_name:
   
   ``machine_name`` :ref:`dns.t_domain <DOMAIN-dns.t_domain>`
     Machine


   References :ref:`backend.machine.name <COLUMN-backend.machine.name>`



 - .. _COLUMN-ssl.cert.domains:
   
   ``domains`` :ref:`varchar[] <DOMAIN-varchar[]>`
     Domains





 - .. _COLUMN-ssl.cert.request:
   
   ``request`` *NULL* | :ref:`ssl.t_request <DOMAIN-ssl.t_request>`
     Certificate request





 - .. _COLUMN-ssl.cert.cert:
   
   ``cert`` *NULL* | :ref:`ssl.t_cert <DOMAIN-ssl.t_cert>`
     Certificate





 - .. _COLUMN-ssl.cert.authority_key_identifier:
   
   ``authority_key_identifier`` *NULL* | :ref:`varchar <DOMAIN-varchar>`
     Identifier of the certificate that has signed this cert.
     The Authority Key Identifier allows to build the chain of trust.
     See <http://www.ietf.org/rfc/rfc3280.txt>.
     Hopefully there exists an entry in web.intermediate_cert
     or a root certificate with an equal subjectKeyIdentifier.
     
     Is NULL whenever x509_certificate is NULL.







.. _TABLE-ssl.demand:

``ssl.demand``
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Service needs certificates

Primary key
 - id


.. BEGIN FKs

Foreign keys
 - Reference service entity

   Local Columns
    - service_entity_name
    - service

   Referenced Columns
    - :ref:`system.service_entity.service_entity_name <COLUMN-system.service_entity.service_entity_name>`
    - :ref:`system.service_entity.service <COLUMN-system.service_entity.service>`


.. END FKs


Columns
 - .. _COLUMN-ssl.demand.service_entity_name:
   
   ``service_entity_name`` :ref:`dns.t_domain <DOMAIN-dns.t_domain>`
     Service entity name





 - .. _COLUMN-ssl.demand.service:
   
   ``service`` :ref:`commons.t_key <DOMAIN-commons.t_key>`
     Service (e.g. email, jabber)





 - .. _COLUMN-ssl.demand.id:
   
   ``id`` :ref:`uuid <DOMAIN-uuid>`
     UUID

   Default
    .. code-block:: sql

     commons._uuid()






.. _TABLE-ssl.demand_domain:

``ssl.demand_domain``
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Domains for which the cert should be issued

.. todo:: check domain is subdomain of registered

Primary key
 - demand_id
 - domain


.. BEGIN FKs


.. END FKs


Columns
 - .. _COLUMN-ssl.demand_domain.demand_id:
   
   ``demand_id`` :ref:`uuid <DOMAIN-uuid>`
     Certificate demand id


   References :ref:`ssl.demand.id <COLUMN-ssl.demand.id>`



 - .. _COLUMN-ssl.demand_domain.domain:
   
   ``domain`` :ref:`dns.t_domain <DOMAIN-dns.t_domain>`
     Domain





 - .. _COLUMN-ssl.demand_domain.registered:
   
   ``registered`` :ref:`dns.t_domain <DOMAIN-dns.t_domain>`
     registered domain


   References :ref:`dns.registered.domain <COLUMN-dns.registered.domain>`








Functions
---------



.. _FUNCTION-ssl.cert_info:

``ssl.cert_info``
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Certificate signing request information

Parameters
 - ``p_cert`` :ref:`bytea <DOMAIN-bytea>`
   
    

Language
 plpython3u


Returns
 ssl.t_cert_info



.. code-block:: guess

   from OpenSSL import crypto
   from cryptography.hazmat.primitives.serialization import Encoding
   from cryptography.hazmat.primitives.serialization import PublicFormat
   
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
   
   def getPublicBytes(crt):
       return crt.get_pubkey().to_cryptography_key() \
               .public_bytes(Encoding.DER, PublicFormat.SubjectPublicKeyInfo)
   
   
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



.. _FUNCTION-ssl.request_info:

``ssl.request_info``
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Certificate signing request information

Parameters
 - ``p_request`` :ref:`bytea <DOMAIN-bytea>`
   
    

Language
 plpython3u


Returns
 ssl.t_request_info



.. code-block:: guess

   from OpenSSL import crypto
   from cryptography.hazmat.primitives.serialization import Encoding
   from cryptography.hazmat.primitives.serialization import PublicFormat
   
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
   
   def getPublicBytes(crt):
       return crt.get_pubkey().to_cryptography_key() \
               .public_bytes(Encoding.DER, PublicFormat.SubjectPublicKeyInfo)
   
   
   def getCsrAltDnsNames(csr):
       return getAltDnsNames(csr.get_extensions())
   
   v_csr = crypto.load_certificate_request(crypto.FILETYPE_ASN1, p_request)
   
   return {
    'subjectAltName' : list(getCsrAltDnsNames(v_csr)),
    'public_key_bytes': getPublicBytes(v_csr)
    }





Domains
-------



.. _DOMAIN-ssl.t_cert:

``ssl.t_cert``
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

DER cert

Checks
 - ``cert``
    really a cert?

   .. code-block:: sql

    VALUE IS NULL OR
    array_length((ssl.cert_info(VALUE))."subjectAltName", 1) > 0




.. _DOMAIN-ssl.t_request:

``ssl.t_request``
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

DER cert

Checks
 - ``cert``
    really a cert?

   .. code-block:: sql

    VALUE IS NULL OR
    array_length((ssl.request_info(VALUE))."subjectAltName", 1) > 0







.. This file was generated via HamSql

