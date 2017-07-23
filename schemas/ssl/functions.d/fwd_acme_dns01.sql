---
name: fwd_acme_dns01
description: |
 Fulfill ACME dns-01 challenge
 
 .. todo :: Restrict updates to plausible domains
 
 .. todo :: Add dns01 delete function for cleanup

parameters:
 - name: p_registered
   type: dns.t_hostname
 - name: p_digest
   type: varchar

variables:
 - name: v_domain
   type: dns.t_domain
   default: |
    '_acme-challenge.' || p_registered

returns: void
---

WITH
  deleted AS (
    DELETE FROM dns.custom
    WHERE
      type = 'TXT'
      AND domain = v_domain
  )

  INSERT INTO dns.custom
    (registered, domain, type, rdata)
  VALUES (
    p_registered,
    v_domain,
    'TXT',
    json_build_object('txtdata', json_build_array(p_digest))
  )
;
