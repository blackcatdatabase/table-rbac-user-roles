-- Auto-generated from schema-map-mysql.yaml (map@sha1:09DF9CA612D1573E058190CC207FA257C05AEC1F)
-- engine: mysql
-- table:  rbac_user_roles

ALTER TABLE rbac_user_roles ADD CONSTRAINT fk_rbac_ur_user FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE;

ALTER TABLE rbac_user_roles ADD CONSTRAINT fk_rbac_ur_role FOREIGN KEY (role_id) REFERENCES rbac_roles(id) ON DELETE CASCADE;

ALTER TABLE rbac_user_roles ADD CONSTRAINT fk_rbac_ur_tenant FOREIGN KEY (tenant_id) REFERENCES tenants(id) ON DELETE CASCADE;

ALTER TABLE rbac_user_roles ADD CONSTRAINT fk_rbac_ur_grant FOREIGN KEY (granted_by) REFERENCES users(id) ON DELETE SET NULL;
