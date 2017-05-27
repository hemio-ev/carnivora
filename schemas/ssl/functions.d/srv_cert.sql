---
name: srv_cert
description: |
 Certs
 
 .. todo :: This could be the point where old certificates are deleted.

templates:
 - backend.backend

returns: TABLE
returns_columns:
 -
  name: id
  type: uuid
 -
  name: cert
  type: ssl.t_cert
 -
  name: service
  type: commons.t_key
 -
  name: service_entity_name
  type: dns.t_hostname
---

RETURN QUERY
  WITH

    -- UPDATE
    changed_cert AS (
        UPDATE ssl.active AS t
            SET used = t.scheduled
        WHERE
            (used IS NULL OR used <> t.scheduled)
            AND t.machine_name = v_machine
        RETURNING
            backend._notify(t.machine_name, t.service_entity_name, t.service, 'ssl-cert')
    )
    
    SELECT c.id, c.cert, a.service, a.service_entity_name FROM ssl.cert AS c
    JOIN ssl.active AS a
    ON a.used = c.id OR a.scheduled = c.id OR a.renew = c.id
    WHERE
     c.cert IS NOT NULL
     AND c.machine_name = v_machine;

