name: _notify
description: |
 Informs all machines about changes.

 To listen to signals use LISTEN "carnivora/machine.name.example".
 The payload has the form 'mail.domain.example/email/list'.

parameters:
 -
  name: p_machine
  type: dns.t_domain
 -
  name: p_service_entity_name
  type: dns.t_domain
 -
  name: p_service
  type: commons.t_key
 -
  name: p_subservice
  type: commons.t_key

returns: void

body: |
    PERFORM
        pg_notify(
            'carnivora/' || p_machine,
             p_service_entity_name || '/' || p_service || '/' || p_subservice
            );
