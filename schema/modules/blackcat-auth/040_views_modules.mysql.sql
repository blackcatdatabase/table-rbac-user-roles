-- Auto-generated from feature-modules-mysql.yaml (map@sha1:6BBFAABCB9674AA932F98C7B494CCD824B6D6BE1)
-- engine: mysql
-- table:  rbac_user_roles_expiring_assignments

CREATE OR REPLACE ALGORITHM=TEMPTABLE SQL SECURITY INVOKER VIEW vw_rbac_user_roles_expiring_assignments AS
SELECT
  ur.user_id,
  ur.role_id,
  ur.expires_at,
  ur.status
FROM rbac_user_roles ur
WHERE ur.expires_at IS NOT NULL
  AND ur.expires_at <= DATE_ADD(NOW(), INTERVAL 30 DAY);
