\set v_csr '''' `xxd -p 1.der` ''''
\set v_crt1 '''' `xxd -p 1.crt` ''''
\set v_crt2 '''' `xxd -p 2.crt` ''''

SELECT ssl.cert_is_signed(decode(:v_crt1, 'hex'), decode(:v_crt1, 'hex'));
--SELECT ssl.cert_is_signed(decode(:v_crt1, 'hex'), decode(:v_crt2, 'hex'));

SELECT * FROM (SELECT "subjectAltName" FROM ssl.request_info(decode(:v_csr, 'hex'))) AS x;
SELECT * FROM (SELECT "subjectAltName", "subjectKeyIdentifier" FROM ssl.cert_info(decode(:v_crt1, 'hex'))) AS x;
