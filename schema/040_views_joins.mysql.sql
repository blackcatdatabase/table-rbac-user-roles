-- Auto-generated from joins-mysql.yaml (map@85230ed)
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

-- Auto-generated from joins-mysql.yaml (map@85230ed)
-- engine: mysql
-- view:   rbac_effective_permissions

CREATE OR REPLACE ALGORITHM=TEMPTABLE SQL SECURITY INVOKER VIEW vw_rbac_effective_permissions AS
WITH allows AS (
  SELECT ur.user_id, rp.permission_id, ur.tenant_id, ur.scope
  FROM rbac_user_roles ur
  JOIN rbac_role_permissions rp ON rp.role_id = ur.role_id AND rp.effect = 'allow'
  WHERE ur.status='active' AND (ur.expires_at IS NULL OR ur.expires_at > NOW())
  UNION
  SELECT up.user_id, up.permission_id, up.tenant_id, up.scope
  FROM rbac_user_permissions up WHERE up.effect = 'allow'
),
denies AS (
  SELECT ur.user_id, rp.permission_id, ur.tenant_id, ur.scope
  FROM rbac_user_roles ur
  JOIN rbac_role_permissions rp ON rp.role_id = ur.role_id AND rp.effect = 'deny'
  WHERE ur.status='active' AND (ur.expires_at IS NULL OR ur.expires_at > NOW())
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


-- Auto-generated from joins-mysql.yaml (map@85230ed)
-- engine: mysql
-- view:   rbac_user_roles_permissions

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

