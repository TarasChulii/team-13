/*================================================================--*/
/*================================================================--*/
/*================================================================--*/

/* 1. Create Role "Read-Only"
   2. Grant SELECT on ALL Tables for it
   3. Create "ro_user" 
   4. Add user to Role 
--*/
SET search_path TO team13;

CREATE ROLE read_only;
GRANT USAGE ON SCHEMA team13 TO read_only;

/* Grant SELECT on existing tables */
GRANT SELECT ON ALL TABLES IN SCHEMA team13 to read_only;

/* Grant SELECT on future tables */
ALTER DEFAULT PRIVILEGES IN SCHEMA team13 GRANT SELECT ON TABLES TO read_only;

CREATE USER ro_user WITH PASSWORD 'Password_for_ro_user';
GRANT read_only TO ro_user;

/* -- Check
SET search_path TO team13;
SELECT *
FROM information_schema.role_table_grants
WHERE table_schema = 'team13' and grantee = 'read_only';

SELECT member.rolname AS user, role.rolname AS role
FROM pg_auth_members m
JOIN pg_roles role ON m.roleid = role.oid
JOIN pg_roles member ON m.member = member.oid
WHERE member.rolname like '%user%';
--*/

/* --REVOKE access
SET search_path TO team13;
REVOKE read_only FROM ro_user;
DROP USER ro_user;
REVOKE ALL ON ALL TABLES IN SCHEMA team13 FROM read_only CASCADE;
REVOKE ALL ON SCHEMA team13 FROM read_only;
ALTER DEFAULT PRIVILEGES IN SCHEMA team13 REVOKE ALL ON TABLES FROM read_only;
DROP ROLE read_only;
--*/

/*================================================================--*/
/*================================================================--*/
/*================================================================--*/

/* 1. Create Role "Insert_and_Update"
   2. Grant SELECT, INSERT and UPDATE on ALL Tables for it
   3. Create "siu_user" 
   4. Add user to Role 
--*/
SET search_path TO team13;

CREATE ROLE insert_and_update;
GRANT USAGE ON SCHEMA team13 TO insert_and_update;

/* Grant Privileges on existing tables */
GRANT SELECT, INSERT, UPDATE ON ALL TABLES IN SCHEMA team13 to insert_and_update;

/* Grant Privileges on future tables */
ALTER DEFAULT PRIVILEGES IN SCHEMA team13 GRANT SELECT, INSERT, UPDATE ON TABLES TO insert_and_update;

CREATE USER siu_user WITH PASSWORD 'Password_for_siu_user';
GRANT insert_and_update TO siu_user;

/* -- Check
SET search_path TO team13;
SELECT *
FROM information_schema.role_table_grants
WHERE table_schema = 'team13' and grantee = 'insert_and_update';

SELECT member.rolname AS user, role.rolname AS role
FROM pg_auth_members m
JOIN pg_roles role ON m.roleid = role.oid
JOIN pg_roles member ON m.member = member.oid
WHERE member.rolname like '%user%';
--*/

/* --REVOKE access
SET search_path TO team13;
REVOKE insert_and_update FROM siu_user;
DROP USER siu_user;
REVOKE ALL ON ALL TABLES IN SCHEMA team13 FROM insert_and_update CASCADE;
REVOKE ALL ON SCHEMA team13 FROM insert_and_update;
ALTER DEFAULT PRIVILEGES IN SCHEMA team13 REVOKE ALL ON TABLES FROM insert_and_update;
DROP ROLE insert_and_update;
--*/

/*================================================================--*/
/*================================================================--*/
/*================================================================--*/

/* 1. Create Role "Insert_Update_and_delete"
   2. Grant SELECT, INSERT, UPDATE and DELETE on ALL Tables for it
   3. Create "siud_user" 
   4. Add user to Role 
--*/
SET search_path TO team13;

CREATE ROLE insert_update_delete;
GRANT USAGE ON SCHEMA team13 TO insert_update_delete;

/* Grant Privileges on existing tables */
GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA team13 to insert_update_delete;

/* Grant Privileges on future tables */
ALTER DEFAULT PRIVILEGES IN SCHEMA team13 GRANT SELECT, INSERT, UPDATE, DELETE ON TABLES TO insert_update_delete;

CREATE USER siud_user WITH PASSWORD 'Password_for_siud_user';
GRANT insert_update_delete TO siud_user;

/* -- Check
SET search_path TO team13;
SELECT *
FROM information_schema.role_table_grants
WHERE table_schema = 'team13' and grantee = 'insert_update_delete';

SELECT member.rolname AS user, role.rolname AS role
FROM pg_auth_members m
JOIN pg_roles role ON m.roleid = role.oid
JOIN pg_roles member ON m.member = member.oid
WHERE member.rolname like '%user%';
--*/

/* --REVOKE access
SET search_path TO team13;
REVOKE insert_update_delete FROM siud_user;
DROP USER siud_user;
REVOKE ALL ON ALL TABLES IN SCHEMA team13 FROM insert_update_delete CASCADE;
REVOKE ALL ON SCHEMA team13 FROM insert_update_delete;
ALTER DEFAULT PRIVILEGES IN SCHEMA team13 REVOKE ALL ON TABLES FROM insert_update_delete;
DROP ROLE insert_update_delete;
--*/

/*================================================================--*/
/*================================================================--*/
/*================================================================--*/

/* 1. Create Role "Full_Access"
   2. Grant Full Access on ALL Tables for it
   3. Create "fa_user" 
   4. Add user to Role 
--*/
SET search_path TO team13;

CREATE ROLE full_access;
GRANT USAGE ON SCHEMA team13 TO full_access;


/* Grant Privileges on existing tables */
GRANT ALL ON ALL TABLES IN SCHEMA team13 TO full_access WITH GRANT OPTION;

/* Grant Privileges on future tables */
ALTER DEFAULT PRIVILEGES IN SCHEMA team13 GRANT ALL ON TABLES TO full_access WITH GRANT OPTION;

CREATE USER fa_user WITH PASSWORD 'Passworffor_fa_user';
GRANT full_access TO fa_user;

/* -- Check
SET search_path TO team13;
SELECT *
FROM information_schema.role_table_grants
WHERE table_schema = 'team13' and grantee = 'full_access';

SELECT member.rolname AS user, role.rolname AS role
FROM pg_auth_members m
JOIN pg_roles role ON m.roleid = role.oid
JOIN pg_roles member ON m.member = member.oid
WHERE member.rolname like '%user%';
--*/

/* --REVOKE access
SET search_path TO team13;
REVOKE full_access FROM fa_user;
DROP USER fa_user;
REVOKE ALL ON ALL TABLES IN SCHEMA team13 FROM full_access CASCADE;
REVOKE ALL ON SCHEMA team13 FROM full_access;
ALTER DEFAULT PRIVILEGES IN SCHEMA team13 REVOKE ALL ON TABLES FROM full_access;
DROP ROLE full_access;
--*/

/*================================================================--*/
/*================================================================--*/
/*================================================================--*/