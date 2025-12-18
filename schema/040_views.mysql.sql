-- Auto-generated from schema-views-mysql.yaml (map@sha1:B3C579FF17AC186C47D2C4AC86B0738DB2308BF2)
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
