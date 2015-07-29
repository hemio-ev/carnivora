name: srv_all
description: srv all

templates:
 - backend.backend

returns: TABLE
returns_columns:
 -
  name: registered
  type: dns.t_domain
 -
  name: domain
  type: dns.t_domain
 -
  name: type
  type: dns.t_type
 -
  name: rdata
  type: dns.t_rdata
 -
  name: ttl
  type: dns.t_ttl
 -
  name: backend_status
  type: backend.t_status

body: |

    RETURN QUERY
        SELECT
            t.registered,
            COALESCE(s.domain_prefix || t.domain, t.domain)::dns.t_domain,
            s.type,
            s.rdata,
            s.ttl,
            t.backend_status
        FROM dns.service AS t
        JOIN system.service_entity_dns AS s
            USING (service, service_entity_name)
        JOIN dns.registered AS u
            ON t.registered = u.domain
        WHERE
            u.subservice = 'managed'

        UNION ALL

        SELECT
            t.registered,
            t.domain,
            t.type,
            t.rdata,
            t.ttl,
            t.backend_status
        FROM dns.custom AS t
        JOIN dns.registered AS u
            ON t.registered = u.domain
        WHERE
            u.subservice = 'managed'
        ;
