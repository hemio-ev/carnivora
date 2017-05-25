ssl
======================================================================

SSL Certificates

.. contents:: Schema Contents
   :local:
   :depth: 2



Tables
------


.. _TABLE-ssl.acme_ca:

``ssl.acme_ca``
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

ACME Server

Primary key
 - name


.. BEGIN FKs


.. END FKs


Columns
 - .. _COLUMN-ssl.acme_ca.name:
   
   ``name`` :ref:`dns.t_domain <DOMAIN-dns.t_domain>`
     Service URL





 - .. _COLUMN-ssl.acme_ca.directory_url:
   
   ``directory_url`` :ref:`varchar <DOMAIN-varchar>`
     Directory





 - .. _COLUMN-ssl.acme_ca.renew_prior_expiry:
   
   ``renew_prior_expiry`` :ref:`interval <DOMAIN-interval>`
     Request new certificate "interval" prior to expiry







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





 - .. _COLUMN-ssl.cert.intermediate:
   
   ``intermediate`` *NULL* | :ref:`varchar <DOMAIN-varchar>`
     Intermediate


   References :ref:`ssl.intermediate.subject_key_identifier <COLUMN-ssl.intermediate.subject_key_identifier>`





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




 - .. _COLUMN-ssl.demand.acme_ca:
   
   ``acme_ca`` *NULL* | :ref:`dns.t_domain <DOMAIN-dns.t_domain>`
     ACME Server


   References :ref:`ssl.acme_ca.name <COLUMN-ssl.acme_ca.name>`





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





.. _TABLE-ssl.intermediate:

``ssl.intermediate``
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Intermediate certificates

Primary key
 - subject_key_identifier


.. BEGIN FKs


.. END FKs


Columns
 - .. _COLUMN-ssl.intermediate.subject_key_identifier:
   
   ``subject_key_identifier`` :ref:`varchar <DOMAIN-varchar>`
     Identifier





 - .. _COLUMN-ssl.intermediate.cert:
   
   ``cert`` :ref:`ssl.t_cert <DOMAIN-ssl.t_cert>`
     Certificate





 - .. _COLUMN-ssl.intermediate.intermediate:
   
   ``intermediate`` *NULL* | :ref:`varchar <DOMAIN-varchar>`
     Intermediate


   References :ref:`ssl.intermediate.subject_key_identifier <COLUMN-ssl.intermediate.subject_key_identifier>`








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
   import datetime
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
       if altExtension:
           for x in map(str.strip, str(altExtension).split(',')):
               split = x.split(':')
               if len(split) == 2 and split[0] == 'DNS':
                   yield split[1]
   
   def getPublicBytes(crt):
       return crt.get_pubkey().to_cryptography_key() \
               .public_bytes(Encoding.DER, PublicFormat.SubjectPublicKeyInfo)
   
   def asn1Time(asn1time):
       return datetime.datetime.strptime(asn1time.decode('ascii'), '%Y%m%d%H%M%SZ')
   
   
   def getCrtAltDnsNames(crt):
       return getAltDnsNames(getExtensions(crt))
   
   def getExtensions(crt):
       for i in range(crt.get_extension_count()):
           yield crt.get_extension(i)
   
   v_crt = crypto.load_certificate(crypto.FILETYPE_ASN1, p_cert)
   
   return {
    'subjectAltName' : list(getCrtAltDnsNames(v_crt)),
    'public_key_bytes': getPublicBytes(v_crt),
    'subjectKeyIdentifier':
      selExtension(b'subjectKeyIdentifier', getExtensions(v_crt)),
    'notAfter': asn1Time(v_crt.get_notAfter())
    }



.. _FUNCTION-ssl.cert_is_signed:

``ssl.cert_is_signed``
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Check signed

.. todo :: use ``set_time()`` with pyopenssl >= v17.0

Parameters
 - ``p_cert`` :ref:`ssl.t_cert <DOMAIN-ssl.t_cert>`
   
    
 - ``p_intermediate`` :ref:`ssl.t_cert <DOMAIN-ssl.t_cert>`
   
    

Language
 plpython3u


Returns
 bool



.. code-block:: guess

   from OpenSSL import crypto
   import datetime
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
       if altExtension:
           for x in map(str.strip, str(altExtension).split(',')):
               split = x.split(':')
               if len(split) == 2 and split[0] == 'DNS':
                   yield split[1]
   
   def getPublicBytes(crt):
       return crt.get_pubkey().to_cryptography_key() \
               .public_bytes(Encoding.DER, PublicFormat.SubjectPublicKeyInfo)
   
   def asn1Time(asn1time):
       return datetime.datetime.strptime(asn1time.decode('ascii'), '%Y%m%d%H%M%SZ')
   
   
   v_cert = crypto.load_certificate(crypto.FILETYPE_ASN1, p_cert)
   v_intermediate = crypto.load_certificate(crypto.FILETYPE_ASN1, p_intermediate)
   
   v_store = crypto.X509Store()
   v_store.add_cert(v_intermediate)
   #v_store.set_time(asn1Time(v_cert.get_notAfter()))
   
   v_store_context = crypto.X509StoreContext(v_store, v_cert)
   v_store_context.verify_certificate()
   
   return True



.. _FUNCTION-ssl.cert_is_trusted:

``ssl.cert_is_trusted``
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

trusted?

Parameters
 - ``p_cert`` :ref:`ssl.t_cert <DOMAIN-ssl.t_cert>`
   
    

Language
 plpython3u


Returns
 bool



.. code-block:: guess

   from OpenSSL import crypto
   import datetime
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
       if altExtension:
           for x in map(str.strip, str(altExtension).split(',')):
               split = x.split(':')
               if len(split) == 2 and split[0] == 'DNS':
                   yield split[1]
   
   def getPublicBytes(crt):
       return crt.get_pubkey().to_cryptography_key() \
               .public_bytes(Encoding.DER, PublicFormat.SubjectPublicKeyInfo)
   
   def asn1Time(asn1time):
       return datetime.datetime.strptime(asn1time.decode('ascii'), '%Y%m%d%H%M%SZ')
   
   
   v_cert = crypto.load_certificate(crypto.FILETYPE_ASN1, p_cert)
   
   v_store = crypto.X509Store()
   
   v_store_context = crypto.X509StoreContext(v_store, v_cert)
   v_store_context.verify_certificate()
   
   return True



.. _FUNCTION-ssl.fwd_renew_requests:

``ssl.fwd_renew_requests``
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Creates new certificate request entries if current certificate is expiring.
Switches over to new subsequent certificate if available.

Additional buffers can be specified to execute those tasks earlier.
Typically, both parameters should be set to the interval at which this function
is called as a cron job.

Parameters
 - ``p_additional_buffer_request`` :ref:`interval <DOMAIN-interval>`
   
    
 - ``p_additional_buffer_switch`` :ref:`interval <DOMAIN-interval>`
   
    



Returns
 void



.. code-block:: plpgsql

   
   WITH
    new_cert AS
    (
     INSERT INTO ssl.cert
     (service, service_entity_name, machine_name, domains)
     -- ssl.active where subsequent cert exists and the current cert is expiring 
     (SELECT
       a.service, 
       a.service_entity_name, 
       a.machine_name,
       ARRAY(SELECT domain::varchar FROM ssl.demand_domain AS dd WHERE dd.demand_id = d.id)
       FROM ssl.active AS a
        LEFT JOIN ssl.cert AS c ON currently = c.id
        JOIN ssl.demand AS d ON demand_id = d.id
        JOIN ssl.acme_ca AS ca ON acme_ca = ca.name
        WHERE
            subsequently IS NULL AND
            (
             currently IS NULL OR -- if there is not even a current cert
             (c.cert IS NOT NULL -- only check expiry if current has a cert
              AND
              now() - (ssl.cert_info(cert))."notAfter" - p_additional_buffer_request
               < ca.renew_prior_expiry
             )
            )
     )
     RETURNING *
    )
   
    -- add new certs as subsequent certs
    UPDATE ssl.active AS a SET subsequently = c.id
    FROM new_cert AS c
    WHERE a.service = c.service AND
       a.service_entity_name = c.service_entity_name AND
       a.machine_name = c.machine_name
   ;
   
   -- switch to new cert
   WITH
     cert_needs_switch AS (
      SELECT a.demand_id, a.machine_name
       FROM ssl.active AS a
        LEFT JOIN ssl.cert AS c ON currently = c.id
        JOIN ssl.cert AS s ON subsequently = s.id
        -- joins for renew interval
        JOIN ssl.demand AS d ON demand_id = d.id
        JOIN ssl.acme_ca AS ca ON acme_ca = ca.name
        WHERE
            currently IS NULL -- switch in any case if there is no cert
            OR
            (
             (c.cert IS NOT NULL -- current is issued
              AND
              s.cert IS NOT NULL -- subsequent is issued
              AND
              now() - (ssl.cert_info(c.cert))."notAfter" - p_additional_buffer_switch
               < ca.renew_prior_expiry
             )
            )
     )
     
     UPDATE ssl.active AS a SET currently=subsequently, subsequently=NULL
     FROM cert_needs_switch AS n
     WHERE n.demand_id = a.demand_id AND n.machine_name = a.machine_name;



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
   import datetime
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
       if altExtension:
           for x in map(str.strip, str(altExtension).split(',')):
               split = x.split(':')
               if len(split) == 2 and split[0] == 'DNS':
                   yield split[1]
   
   def getPublicBytes(crt):
       return crt.get_pubkey().to_cryptography_key() \
               .public_bytes(Encoding.DER, PublicFormat.SubjectPublicKeyInfo)
   
   def asn1Time(asn1time):
       return datetime.datetime.strptime(asn1time.decode('ascii'), '%Y%m%d%H%M%SZ')
   
   
   def getCsrAltDnsNames(csr):
       return getAltDnsNames(csr.get_extensions())
   
   v_csr = crypto.load_certificate_request(crypto.FILETYPE_ASN1, p_request)
   
   return {
    'subjectAltName' : list(getCsrAltDnsNames(v_csr)),
    'public_key_bytes': getPublicBytes(v_csr)
    }



.. _FUNCTION-ssl.srv_request:

``ssl.srv_request``
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Open certificate requests

Parameters
 *None*



Returns
 TABLE

Returned columns
 - ``id`` :ref:`uuid <DOMAIN-uuid>`
    
 - ``request`` :ref:`ssl.t_request <DOMAIN-ssl.t_request>`
    


.. code-block:: plpgsql

   
   RETURN QUERY
     SELECT c.id, c.request
     FROM ssl.cert AS c
     WHERE c.cert IS NULL AND c.request IS NOT NULL;





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

