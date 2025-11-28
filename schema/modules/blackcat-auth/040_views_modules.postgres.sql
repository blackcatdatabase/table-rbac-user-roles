-- Auto-generated from feature-modules-postgres.psd1 (map@mtime:2025-11-27T13:56:21Z)
-- engine: postgres
-- table:  rbac_user_roles_expiring_assignments
CREATE OR REPLACE VIEW vw_rbac_user_roles_expiring_assignments AS
SELECT
  ur.user_id,
  ur.role_id,
  ur.expires_at,
  ur.status
FROM rbac_user_roles ur
WHERE ur.expires_at IS NOT NULL
  AND ur.expires_at <= now() + interval '30 day';
