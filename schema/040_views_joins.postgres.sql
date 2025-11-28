-- Auto-generated from joins-postgres.psd1 (map@mtime:2025-11-25T01:28:48Z)
-- engine: postgres
-- view:   rbac_user_roles_permissions

CREATE OR REPLACE VIEW vw_rbac_user_roles_permissions AS
WITH active_roles AS (
  SELECT ur.user_id, ur.role_id
  FROM rbac_user_roles ur
  WHERE ur.status = ''active'' AND (ur.expires_at IS NULL OR ur.expires_at > now())
),
role_perms AS (
  SELECT ar.user_id, rp.permission_id
  FROM active_roles ar
  JOIN rbac_role_permissions rp ON rp.role_id = ar.role_id
  WHERE rp.effect = ''allow''
)
SELECT
  u.id AS user_id,
  COUNT(DISTINCT ar.role_id) AS active_roles,
  to_json(array_agg(DISTINCT rp.permission_id ORDER BY rp.permission_id)) AS permission_ids
FROM users u
LEFT JOIN active_roles ar ON ar.user_id = u.id
LEFT JOIN role_perms rp   ON rp.user_id = u.id
GROUP BY u.id;
