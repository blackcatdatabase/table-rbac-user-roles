# rbac_user_roles

Assignments of RBAC roles to users.

## Columns
| Column | Type | Null | Default | Description |
| --- | --- | --- | --- | --- |
| expires_at | DATETIME(6) | YES |  | Optional expiration time (UTC). |
| granted_at | DATETIME(6) | NO | CURRENT_TIMESTAMP(6) | Grant timestamp (UTC). |
| granted_by | BIGINT | YES |  | User/admin who granted the role. |
| id | BIGINT | NO |  | Surrogate primary key. |
| role_id | BIGINT | NO |  | Role granted (FK rbac_roles.id). |
| scope | VARCHAR(120) | YES |  | Additional scope qualifier. |
| status | ENUM('active','revoked','expired') | NO | active | Assignment status. (enum: active, revoked, expired) |
| tenant_id | BIGINT | YES |  | Tenant scope, optional. |
| user_id | BIGINT | NO |  | User receiving the role (FK users.id). |

## Engine Details

### mysql

Unique keys:
| Name | Columns |
| --- | --- |
| uq_rbac_user_roles | user_id, role_id, tenant_id, scope |

Indexes:
| Name | Columns | SQL |
| --- | --- | --- |
| idx_rbac_user_roles_role | role_id | CREATE INDEX idx_rbac_user_roles_role ON rbac_user_roles (role_id) |
| idx_rbac_user_roles_tenant | tenant_id | CREATE INDEX idx_rbac_user_roles_tenant ON rbac_user_roles (tenant_id) |
| idx_rbac_user_roles_user | user_id | CREATE INDEX idx_rbac_user_roles_user ON rbac_user_roles (user_id) |
| uq_rbac_user_roles | user_id,role_id,tenant_id,scope | UNIQUE KEY uq_rbac_user_roles (user_id, role_id, tenant_id, scope) |

Foreign keys:
| Name | Columns | References | Actions |
| --- | --- | --- | --- |
| fk_rbac_ur_grant | granted_by | users(id) | ON DELETE SET |
| fk_rbac_ur_role | role_id | rbac_roles(id) | ON DELETE CASCADE |
| fk_rbac_ur_tenant | tenant_id | tenants(id) | ON DELETE CASCADE |
| fk_rbac_ur_user | user_id | users(id) | ON DELETE CASCADE |

### postgres

Unique keys:
| Name | Columns |
| --- | --- |
| uq_rbac_user_roles | user_id, role_id, tenant_id, scope |

Indexes:
| Name | Columns | SQL |
| --- | --- | --- |
| idx_rbac_user_roles_role | role_id | CREATE INDEX IF NOT EXISTS idx_rbac_user_roles_role ON rbac_user_roles (role_id) |
| idx_rbac_user_roles_tenant | tenant_id | CREATE INDEX IF NOT EXISTS idx_rbac_user_roles_tenant ON rbac_user_roles (tenant_id) |
| idx_rbac_user_roles_user | user_id | CREATE INDEX IF NOT EXISTS idx_rbac_user_roles_user ON rbac_user_roles (user_id) |
| uq_rbac_user_roles | user_id,role_id,tenant_id,scope | CONSTRAINT uq_rbac_user_roles UNIQUE (user_id, role_id, tenant_id, scope) |

Foreign keys:
| Name | Columns | References | Actions |
| --- | --- | --- | --- |
| fk_rbac_ur_grant | granted_by | users(id) | ON DELETE SET |
| fk_rbac_ur_role | role_id | rbac_roles(id) | ON DELETE CASCADE |
| fk_rbac_ur_tenant | tenant_id | tenants(id) | ON DELETE CASCADE |
| fk_rbac_ur_user | user_id | users(id) | ON DELETE CASCADE |

## Engine differences

## Views
| View | Engine | Flags | File |
| --- | --- | --- | --- |
| vw_rbac_effective_permissions | mysql | algorithm=TEMPTABLE, security=INVOKER | [schema\040_views_joins.mysql.sql](schema\040_views_joins.mysql.sql) |
| vw_rbac_user_roles | mysql | algorithm=MERGE, security=INVOKER | [schema\040_views.mysql.sql](schema\040_views.mysql.sql) |
| vw_rbac_user_roles_permissions | mysql | algorithm=TEMPTABLE, security=INVOKER | [schema\040_views_joins.mysql.sql](schema\040_views_joins.mysql.sql) |
| vw_rbac_effective_permissions | postgres |  | [schema\040_views_joins.postgres.sql](schema\040_views_joins.postgres.sql) |
| vw_rbac_user_roles | postgres |  | [schema\040_views.postgres.sql](schema\040_views.postgres.sql) |
| vw_rbac_user_roles_permissions | postgres |  | [schema\040_views_joins.postgres.sql](schema\040_views_joins.postgres.sql) |
