name: fwd_registered_status
description: Update status

templates:
 - backend.backend

returns: void

parameters:
 -
  name: p_domain
  type: dns.t_domain
 -
  name: p_payable
  type: timestamp
 -
  name: p_period
  type: integer
 -
  name: p_registrar_status
  type: varchar
 -
  name: p_registry_status
  type: varchar
 -
  name: p_last_status
  type: varchar

body: |

    UPDATE domain_reseller.registered
    SET
        payable = p_payable,
        period = p_period,
        registrar_status = p_registrar_status,
        registry_status = p_registry_status,
        last_status = p_last_status
    WHERE domain = p_domain;
