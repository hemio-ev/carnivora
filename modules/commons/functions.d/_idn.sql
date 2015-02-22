name: _idn
description: |
 Converts a unicode domain name to IDN (ASCII)

language: plpython3u

returns: varchar

parameters:
 -
  name: p_domain
  type: varchar

body: |
 if p_domain is None:
    return None

 if p_domain.lower() != p_domain:
     raise plpy.Error('Only lower case IDNs are allowed and can be handled.')

 return p_domain.encode('idna').decode()
