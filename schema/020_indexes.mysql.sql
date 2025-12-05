-- Auto-generated from schema-map-mysql.yaml (map@sha1:5E62933580349BE7C623D119AC9D1301A62F03EF)
-- engine: mysql
-- table:  rbac_user_roles

CREATE INDEX idx_rbac_user_roles_user ON rbac_user_roles (user_id);

CREATE INDEX idx_rbac_user_roles_role ON rbac_user_roles (role_id);

CREATE INDEX idx_rbac_user_roles_tenant ON rbac_user_roles (tenant_id);
