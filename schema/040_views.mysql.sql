-- Auto-generated from schema-views-mysql.psd1 (map@62c9c93)
-- engine: mysql
-- table:  rbac_user_roles_expiring_assignments
-- Roles/permissions which will expire within 7 days
CREATE OR REPLACE ALGORITHM=MERGE SQL SECURITY INVOKER VIEW vw_rbac_expiring_assignments AS
SELECT
  'role' AS kind,
  ur.user_id,
  CAST(ur.role_id AS UNSIGNED) AS id,
  ur.tenant_id,
  ur.scope,
  ur.expires_at
FROM rbac_user_roles ur
WHERE ur.expires_at IS NOT NULL
  AND ur.expires_at <= NOW() + INTERVAL 7 DAY
UNION ALL
SELECT
  'permission' AS kind,
  up.user_id,
  CAST(up.permission_id AS UNSIGNED) AS id,
  up.tenant_id,
  up.scope,
  up.expires_at
FROM rbac_user_permissions up
WHERE up.expires_at IS NOT NULL
  AND up.expires_at <= NOW() + INTERVAL 7 DAY;

-- Auto-generated from schema-views-mysql.psd1 (map@62c9c93)
-- engine: mysql
-- table:  rbac_user_roles
-- Contract view for [rbac_user_roles]
CREATE OR REPLACE ALGORITHM=MERGE SQL SECURITY INVOKER VIEW vw_rbac_user_roles AS
SELECT
  id,
  user_id,
  role_id,
  tenant_id,
  scope,
  status,
  granted_by,
  granted_at,
  expires_at
FROM rbac_user_roles;

