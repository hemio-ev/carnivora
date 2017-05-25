---
name: fwd_renew_requests
description: |
 Creates new certificate request entries if current certificate is expiring.
 Switches over to new subsequent certificate if available.
 
 Additional buffers can be specified to execute those tasks earlier.
 Typically, both parameters should be set to the interval at which this function
 is called as a cron job.
  
returns: void
parameters:
 - name: p_additional_buffer_request
   type: interval
   default: "'0s'"
 - name: p_additional_buffer_switch
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

