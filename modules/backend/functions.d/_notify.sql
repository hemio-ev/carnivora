name: _notify
description: |
 Informs all machines about changes.

parameters:
 -
  name: p_machine
  type: dns.t_domain
 -
  name: p_service
  type: commons.t_key
 -
  name: p_service_entity_name
  type: dns.t_domain

returns: void

body: |
    PERFORM
        pg_notify(
            'carnivora,' || p_machine,
             p_service || ',' || p_service_entity_name
            ),
        pg_notify(
            'carnivora,' || p_machine,
             '*,' || p_service_entity_name
            ),
        pg_notify(
            'carnivora,' || p_machine,
             p_service || ',*'
            );


