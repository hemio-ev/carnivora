name: _inherit_acl_donor
description: |
 Returns all acl donors for a given user with their priority.

returns: TABLE
returns_columns:
 -
  name: donor
  description: User from which acls are inherited
  type: user.t_user
 -
  name: priority_list
  type: integer[]
  description:

parameters:
 -
  name: p_owner
  type: user.t_user

body: |
 RETURN QUERY
 WITH RECURSIVE acl_donor(donor, priority_list, cycle_detector) AS
 (
    -- cast to varchar, since arrays of t_user are not defined
    SELECT p_owner, ARRAY[]::integer[], ARRAY[CAST(p_owner AS varchar)]

    UNION

    SELECT
     curr.donor,
     prev.priority_list || curr.priority),
     cycle_detector || CAST(curr.donor AS varchar)
    FROM system.inherit_acl AS curr
     JOIN acl_donor AS prev
     ON
      prev.donor = curr.owner AND
      curr.donor <> ALL (prev.cycle_detector)
 )
 SELECT acl_donor.donor, acl_donor.priority_list FROM acl_donor
 -- Appending the NULL changes the ordering between arrays with different size
 ORDER BY acl_donor.priority_list || NULL DESC;
