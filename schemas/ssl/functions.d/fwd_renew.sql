---
name: fwd_renew
description: |
 Creates new certificate request entries if current certificate is expiring.
 Switches over to new subsequent certificate if available.
 
 Additional buffers can be specified to execute those tasks earlier.
 Typically, both parameters should be set to the interval at which this function
 is called as a cron job.
  
returns: void
parameters:
 - name: p_buffer_request
   type: interval
 - name: p_buffer_switch
   type: interval
---

WITH
  active_missing AS (
    SELECT d.id, d.service, d.service_entity_name, m.machine_name
    FROM ssl.demand AS d
    
    JOIN system.service_entity_machine AS m
      ON d.service = m.service
      AND d.service_entity_name = m.service_entity_name
    
    LEFT JOIN ssl.active AS a
      ON a.demand_id = d.id
      AND a.machine_name = m.machine_name
    
    WHERE
      a.demand_id IS NULL
  )
  
  INSERT INTO ssl.active
  (demand_id, service, service_entity_name, machine_name)
  SELECT * FROM active_missing;

-- insert new certs
WITH
 new_cert AS (
  INSERT INTO ssl.cert
  (demand_id, machine_name, domains)
  -- ssl.active where subsequent cert exists and the current cert is expiring 
  (SELECT
    a.demand_id, 
    a.machine_name,
    ARRAY(SELECT domain::varchar FROM ssl.demand_domain AS dd WHERE dd.demand_id = a.demand_id)
    FROM ssl.active AS a
     LEFT JOIN ssl.cert AS c ON scheduled = c.id
     WHERE
         renew IS NULL AND
         (
          scheduled IS NULL OR -- if there is not even a current cert
          (c.cert IS NOT NULL -- only check expiry if current has a cert
           AND
           now() - (ssl.cert_info(cert))."notAfter"
            < p_buffer_request
          )
         )
  )
  RETURNING *
 )

 -- add new certs as subsequent certs
 UPDATE ssl.active AS a SET renew = c.id
 FROM new_cert AS c
 WHERE
    a.demand_id = c.demand_id AND
    a.machine_name = c.machine_name
;

-- switch to new cert
WITH
  cert_needs_switch AS (
   SELECT a.demand_id, a.machine_name
    FROM ssl.active AS a
     LEFT JOIN ssl.cert AS c ON scheduled = c.id
     JOIN ssl.cert AS s ON renew = s.id
     WHERE
         scheduled IS NULL -- switch in any case if there is no cert
         OR
         (
          (c.cert IS NOT NULL -- current is issued
           AND
           s.cert IS NOT NULL -- subsequent is issued
           AND
           now() - (ssl.cert_info(c.cert))."notAfter"
            < p_buffer_switch
          )
         )
  )
  
  UPDATE ssl.active AS a SET scheduled=renew, renew=NULL
  FROM cert_needs_switch AS n
  WHERE n.demand_id = a.demand_id AND n.machine_name = a.machine_name;

