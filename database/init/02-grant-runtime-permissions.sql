-- Grant the API role only the permissions needed for ordinary application queries.
GRANT CONNECT ON DATABASE mimu TO mimu_app;
GRANT USAGE ON SCHEMA mimu TO mimu_app;
GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA mimu TO mimu_app;

-- Tables created later by the migration/database owner receive the same runtime grants.
ALTER DEFAULT PRIVILEGES FOR ROLE mimu_admin IN SCHEMA mimu
  GRANT SELECT, INSERT, UPDATE, DELETE ON TABLES TO mimu_app;
