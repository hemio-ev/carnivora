---
name: _notify
description: |
 Informs a machine about changes. To listen to signals use

 .. code-block :: sql
  
  LISTEN "carnivora/machine.name.example"

 on the machine. The payload has the form
 ``<service_entity_name>/<service>/<subservice>``. For example
 ``mail.domain.example/email/mailbox`` for a mailbox related update.

parameters:
 -
  name: p_machine
  type: dns.t_hostname
 -
  name: p_service_entity_name
  type: dns.t_hostname
 -
  name: p_service
  type: commons.t_key
 -
  name: p_subservice
  type: commons.t_key

returns: void
---

PERFORM
    pg_notify(
        'carnivora/' || p_machine,
         p_service_entity_name || '/' || p_service || '/' || p_subservice
        );
