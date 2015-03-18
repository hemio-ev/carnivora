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

body: |

    PERFORM commons._raise_inaccessible_or_missing(
        EXISTS(
            SELECT TRUE FROM web.site AS t
            JOIN server_access.user AS s
                USING ("user", service_name)
            WHERE
                t.domain = p_site AND
                s.owner = v_owner
        )
    );

    INSERT INTO web.alias
        (domain, site, service_name)
    VALUES
        (
            p_domain,
            p_site,
            (SELECT service_name FROM web.site WHERE domain = p_site)
        );

    PERFORM backend._notify_domain('web', p_domain);
