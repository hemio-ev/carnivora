\set v_cert '''' `xxd -p 1.der` ''''
SELECT ssl.cert_info(p_cert:=decode(:v_cert, 'hex'), p_signing_request:=true);
