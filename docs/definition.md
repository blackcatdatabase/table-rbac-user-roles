<!-- Auto-generated from schema-map-postgres.psd1 @ 62c9c93 (2025-11-20T21:38:11+01:00) -->
# Definition – rbac_user_roles

Assignments of RBAC roles to users.

## Columns
| Column | Type | Null | Default | Description | Notes |
|-------:|:-----|:----:|:--------|:------------|:------|
| id | BIGINT | — | AS | Surrogate primary key. |  |
| user_id | BIGINT | NO | — | User receiving the role (FK users.id). |  |
| role_id | BIGINT | NO | — | Role granted (FK rbac_roles.id). |  |
| tenant_id | BIGINT | YES | — | Tenant scope, optional. |  |
| granted_at | TIMESTAMPTZ(6) | NO | CURRENT_TIMESTAMP(6) | Grant timestamp (UTC). |  |
| expires_at | TIMESTAMPTZ(6) | YES | — | Optional expiration time (UTC). |  |