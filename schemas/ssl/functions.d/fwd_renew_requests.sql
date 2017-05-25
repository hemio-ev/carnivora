---
name: fwd_renew_requests
description: x
returns: void
parameters:
 - name: p_additional_buffer
   type: interval
   default: "'0s'"
---

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
           now() - (ssl.cert_info(cert))."notAfter" - p_additional_buffer
            < ca.renew_prior_expiry
          )
         )
  )
  RETURNING *
 )

 -- add new certs as subsequent certs
 UPDATE ssl.active AS a SET subsequently = c.id
 FROM new_cert
 WHERE a.service = c.service AND
    a.service_entity_name = c.service_entity_name AND
    a.machine_name = c.machine_name
;

