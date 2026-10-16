-- Creates the least-privileged local API role before the schema is installed.
-- The password is supplied through the API_DB_PASSWORD environment variable.
\getenv app_password API_DB_PASSWORD
SELECT format('CREATE ROLE mimu_app LOGIN PASSWORD %L', :'app_password') \gexec
