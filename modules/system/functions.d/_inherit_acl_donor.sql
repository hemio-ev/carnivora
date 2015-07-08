name: _inherit_acl_donor
description: |
 Returns all acl donors for a given user.

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
 WITH RECURSIVE acl_donor(donor, priority_list) AS
 (
    SELECT p_owner, CAST(ARRAY[] AS integer[])

    UNION

    SELECT curr.donor, array_append(prev.priority_list, curr.priority)
    FROM system.inherit_acl AS curr
        JOIN acl_donor AS prev
        ON prev.donor = curr.owner
 )
 SELECT acl_donor.donor, acl_donor.priority_list FROM acl_donor
 -- Appending the NULL corrects the ordering between arrays with different size
 ORDER BY array_append(acl_donor.priority_list, NULL) DESC;
