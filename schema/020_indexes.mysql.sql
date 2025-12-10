-- Auto-generated from schema-map-mysql.yaml (map@sha1:09DF9CA612D1573E058190CC207FA257C05AEC1F)
-- engine: mysql
-- table:  rbac_user_roles

CREATE INDEX idx_rbac_user_roles_user ON rbac_user_roles (user_id);

CREATE INDEX idx_rbac_user_roles_role ON rbac_user_roles (role_id);

CREATE INDEX idx_rbac_user_roles_tenant ON rbac_user_roles (tenant_id);
