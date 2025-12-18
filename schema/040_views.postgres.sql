-- Auto-generated from schema-views-postgres.yaml (map@sha1:3C365C10BD489376A27944AE10F143E1BE4D3BCF)
-- engine: postgres
-- table:  rbac_user_roles

-- Contract view for [rbac_user_roles]
CREATE OR REPLACE VIEW vw_rbac_user_roles AS
SELECT
  id, user_id, role_id, tenant_id, scope, status, granted_by, granted_at, expires_at
FROM rbac_user_roles;
