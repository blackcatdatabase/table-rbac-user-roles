-- Auto-generated from schema-map-postgres.yaml (map@sha1:F0EE237771FBA8DD7C4E886FF276F91A862C3718)
-- engine: postgres
-- table:  rbac_user_roles

CREATE INDEX IF NOT EXISTS idx_rbac_user_roles_user ON rbac_user_roles (user_id);

CREATE INDEX IF NOT EXISTS idx_rbac_user_roles_role ON rbac_user_roles (role_id);

CREATE INDEX IF NOT EXISTS idx_rbac_user_roles_tenant ON rbac_user_roles (tenant_id);
