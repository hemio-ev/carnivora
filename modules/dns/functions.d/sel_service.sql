templates:
 - user.userlogin

name: sel_service
description: |
 List all domains that have a service entry in dns with their service.
 This is particularly usefull since these domains are ready for use with
 this service. Usually this means that accounts etc. can be created for this
 domain.

 TODO: Their is no owner of dns entries and therefore no access check at all!

return: TABLE
return_columns:
 -
  name: domain
  type: dns.domain_name
 -
  name: service
  type: varchar(50)

body: |
 RETURN QUERY
  SELECT s.domain, s.service FROM dns.service AS s
   GROUP BY s.domain, s.service;
