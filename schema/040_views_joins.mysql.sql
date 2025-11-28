-- Auto-generated from joins-mysql.psd1 (map@mtime:2025-11-25T01:30:51Z)
-- engine: mysql
-- view:   rbac_user_roles_permissions
-- Users with active roles and resolved permission ids
CREATE OR REPLACE ALGORITHM=TEMPTABLE SQL SECURITY INVOKER VIEW vw_rbac_user_roles_permissions AS
WITH active_roles AS (
  SELECT ur.user_id, ur.role_id
  FROM rbac_user_roles ur
  WHERE ur.status = 'active' AND (ur.expires_at IS NULL OR ur.expires_at > NOW())
),
role_perms AS (
  SELECT ar.user_id, rp.permission_id
  FROM active_roles ar
  JOIN rbac_role_permissions rp ON rp.role_id = ar.role_id
  WHERE rp.effect = 'allow'
)
SELECT
  u.id AS user_id,
  COUNT(DISTINCT ar.role_id) AS active_roles,
  CONCAT('[', GROUP_CONCAT(DISTINCT rp.permission_id ORDER BY rp.permission_id SEPARATOR ','), ']') AS permission_ids
FROM users u
LEFT JOIN active_roles ar ON ar.user_id = u.id
LEFT JOIN role_perms rp   ON rp.user_id = u.id
GROUP BY u.id;
