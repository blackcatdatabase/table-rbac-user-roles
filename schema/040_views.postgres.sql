-- Auto-generated from schema-views-postgres.psd1 (map@9d3471b)
-- engine: postgres
-- table:  rbac_user_roles
-- Contract view for [rbac_user_roles]
CREATE OR REPLACE VIEW vw_rbac_user_roles AS
SELECT
  id, user_id, role_id, tenant_id, scope, status, granted_by, granted_at, expires_at
FROM rbac_user_roles;

-- Auto-generated from schema-views-postgres.psd1 (map@9d3471b)
-- engine: postgres
-- table:  rbac_user_roles_expiring_assignments
-- Roles/permissions which will expire within 7 days
CREATE OR REPLACE VIEW vw_rbac_expiring_assignments AS
SELECT
  ''role'' AS kind,
  ur.user_id,
  ur.role_id::bigint AS id,
  ur.tenant_id, ur.scope,
  ur.expires_at
FROM rbac_user_roles ur
WHERE ur.expires_at IS NOT NULL AND ur.expires_at <= now() + interval ''7 days''
UNION ALL
SELECT
  ''permission'' AS kind,
  up.user_id,
  up.permission_id::bigint AS id,
  up.tenant_id, up.scope,
  up.expires_at
FROM rbac_user_permissions up
WHERE up.expires_at IS NOT NULL AND up.expires_at <= now() + interval ''7 days'';

