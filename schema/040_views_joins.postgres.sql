-- Auto-generated from auth-rbac\joins-postgres.yaml (map@sha1:819A7F0638F1D5C0A86E37B6E574CC5689B6F3EE)
-- engine: postgres
-- view:   rbac_user_roles_permissions

CREATE OR REPLACE VIEW vw_rbac_user_roles_permissions AS
WITH active_roles AS (
  SELECT ur.user_id, ur.role_id
  FROM rbac_user_roles ur
  WHERE ur.status = $$active$$ AND (ur.expires_at IS NULL OR ur.expires_at > now())
),
role_perms AS (
  SELECT ar.user_id, rp.permission_id
  FROM active_roles ar
  JOIN rbac_role_permissions rp ON rp.role_id = ar.role_id
  WHERE rp.effect = $$allow$$
)
SELECT
  u.id AS user_id,
  COUNT(DISTINCT ar.role_id) AS active_roles,
  to_json(array_agg(DISTINCT rp.permission_id ORDER BY rp.permission_id)) AS permission_ids
FROM users u
LEFT JOIN active_roles ar ON ar.user_id = u.id
LEFT JOIN role_perms rp   ON rp.user_id = u.id
GROUP BY u.id;

-- Auto-generated from core\joins-postgres.yaml (map@sha1:29CF395A3A4C8964482083733F8E613ABFBEF5CC)
-- engine: postgres
-- view:   rbac_effective_permissions

-- Effective permissions (deny overrides allow)
CREATE OR REPLACE VIEW vw_rbac_effective_permissions AS
WITH allows AS (
  SELECT ur.user_id, rp.permission_id, ur.tenant_id, ur.scope
  FROM rbac_user_roles ur
  JOIN rbac_role_permissions rp ON rp.role_id = ur.role_id AND rp.effect = 'allow'
  WHERE ur.status='active' AND (ur.expires_at IS NULL OR ur.expires_at > now())
  UNION
  SELECT up.user_id, up.permission_id, up.tenant_id, up.scope
  FROM rbac_user_permissions up WHERE up.effect = 'allow'
),
denies AS (
  SELECT ur.user_id, rp.permission_id, ur.tenant_id, ur.scope
  FROM rbac_user_roles ur
  JOIN rbac_role_permissions rp ON rp.role_id = ur.role_id AND rp.effect = 'deny'
  WHERE ur.status='active' AND (ur.expires_at IS NULL OR ur.expires_at > now())
  UNION
  SELECT up.user_id, up.permission_id, up.tenant_id, up.scope
  FROM rbac_user_permissions up WHERE up.effect = 'deny'
)
SELECT a.user_id, a.permission_id, a.tenant_id, a.scope
FROM allows a
LEFT JOIN denies d
  ON d.user_id = a.user_id
 AND d.permission_id = a.permission_id
 AND COALESCE(d.tenant_id, -1) = COALESCE(a.tenant_id, -1)
 AND COALESCE(d.scope, '') = COALESCE(a.scope, '')
WHERE d.permission_id IS NULL;

