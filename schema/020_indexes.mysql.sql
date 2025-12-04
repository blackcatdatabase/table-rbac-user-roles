-- Auto-generated from schema-map-mysql.yaml (map@74ce4f4)
-- engine: mysql
-- table:  rbac_user_roles

CREATE INDEX idx_rbac_user_roles_user ON rbac_user_roles (user_id);

CREATE INDEX idx_rbac_user_roles_role ON rbac_user_roles (role_id);

CREATE INDEX idx_rbac_user_roles_tenant ON rbac_user_roles (tenant_id);
