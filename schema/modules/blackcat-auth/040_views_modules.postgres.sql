-- Auto-generated from feature-modules-postgres.yaml (map@sha1:E21F17850CEF9511C760F725ABF4C7D45DC351E4)
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
