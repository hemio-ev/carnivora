name: ins_alias
description: Insert alias

templates:
 - user.userlogin

returns: void

parameters:
 -
  name: p_domain
  type: dns.t_domain
 -
  name: p_site
  type: dns.t_domain
 -
  name: p_site_port
  type: commons.t_port

body: |

    PERFORM commons._raise_inaccessible_or_missing(
        EXISTS(
            SELECT TRUE FROM web.site AS t
            JOIN server_access.user AS s
                USING ("user", service_entity_name)
            WHERE
                t.domain = p_site AND
                t.port = p_site_port AND
                s.owner = v_owner
        )
    );

    INSERT INTO web.alias
        (domain, service, subservice, site, site_port, service_entity_name)
    VALUES
        (
            p_domain,
            'web',
            'alias',
            p_site,
            p_site_port,
            (SELECT service_entity_name FROM web.site WHERE domain = p_site AND port = p_site_port)
        );

    PERFORM backend._notify_domain('web', p_domain);
