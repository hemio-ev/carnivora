\set v_csr '''' `xxd -p 1.der` ''''
\set v_crt '''' `xxd -p 1.crt` ''''
SELECT * FROM (SELECT * FROM ssl.cert_request_info(decode(:v_csr, 'hex'))) AS x;
SELECT * FROM (SELECT * FROM ssl.cert_info(decode(:v_crt, 'hex'))) AS x;
