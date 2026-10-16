-- MIMU v1.3 DEMO ONLY. Fictional data. Run after V004 RBAC migration.
-- Demo password for local testing only: MimuDemo-2026! (shared by demo accounts).
-- Hashes use Argon2id parameters documented in README.md; verify compatibility with API config.
-- Do not use these demo accounts in production. No refresh sessions or reset tokens are seeded.
BEGIN;
INSERT INTO mimu.institutions (id, name, code, status, time_zone, contact_email, contact_phone)
VALUES
  ('01a14706-9667-7294-b4e5-e9485d428dc9', 'Centro Infantil Arcoíris', 'DEMO-ARCOIRIS', 'ACTIVE', 'America/Panama', 'secretaria@arcoiris.example', '+507 6000-0100');
INSERT INTO mimu.users (id, name, last_name, email, phone, status, must_change_password, terms_accepted, preferred_language)
VALUES
  ('01a14250-1370-7d72-9c3d-cf8da6ebef3f', 'Ana', 'Morales', 'ana.morales@demo.mimu.example', '+507 6000-0101', 'ACTIVE', false, true, 'es'),
  ('01a147ca-5fb7-7570-8f0c-a7f9d1d62e69', 'Carlos', 'Morales', 'carlos.morales@demo.mimu.example', '+507 6000-0102', 'ACTIVE', false, true, 'es'),
  ('01a14759-5384-798e-a26b-ffcff2822949', 'María', 'Gómez', 'maria.gomez@demo.mimu.example', '+507 6000-0103', 'ACTIVE', false, true, 'es'),
  ('01a1435e-6ddb-7dcb-977a-d2317326cf3a', 'Daniel', 'Ríos', 'daniel.rios@demo.mimu.example', '+507 6000-0104', 'ACTIVE', true, false, 'es'),
  ('01a1442c-6589-72f7-a34a-760231ed5720', 'Isabel', 'Vega', 'isabel.vega@demo.mimu.example', '+507 6000-0105', 'ACTIVE', false, true, 'es'),
  ('01a14248-2db5-7016-b20e-7ef3608e9d22', 'Sofía', 'Pérez', 'sofia.perez@demo.mimu.example', '+507 6000-0106', 'ACTIVE', false, true, 'es');
INSERT INTO mimu.credentials (user_id, password_hash, algorithm)
VALUES
  ('01a14250-1370-7d72-9c3d-cf8da6ebef3f', '$argon2id$v=19$m=65536,t=3,p=4$vpI/Fj5TDSm6LBAzqksmkw$voePR8l9edCQaTXrTZJq6jqh7EB1jxPUe/m8o2g7yPk', 'argon2id'),
  ('01a147ca-5fb7-7570-8f0c-a7f9d1d62e69', '$argon2id$v=19$m=65536,t=3,p=4$NLmfomsDY3xbC1GCuDL/BQ$2j4A/ArgRKZRU05g/S3I64UHjLTykR/NENrFlG9KrBE', 'argon2id'),
  ('01a14759-5384-798e-a26b-ffcff2822949', '$argon2id$v=19$m=65536,t=3,p=4$4SqC4TU9Il2+xIl4o7pMyg$nJJzmH1OLEWV9ZxWkDiYwHXrMoZ2SyrpcO1zNF+uXY8', 'argon2id'),
  ('01a1435e-6ddb-7dcb-977a-d2317326cf3a', '$argon2id$v=19$m=65536,t=3,p=4$rPKxqKB5G/+WCJKPXBqlUA$zD9XS4OEfHUQnuiV07pEKcIIR4wns4XcLtNEOzvy8sM', 'argon2id'),
  ('01a1442c-6589-72f7-a34a-760231ed5720', '$argon2id$v=19$m=65536,t=3,p=4$RN4IFAdw85AVtFeSLgGj6w$Cirf0yRiSmKR3A2E0stS0PTDmKRziDaOIFuWyiDudIQ', 'argon2id'),
  ('01a14248-2db5-7016-b20e-7ef3608e9d22', '$argon2id$v=19$m=65536,t=3,p=4$NhK0+zvAIOtwwCxW1WdA2w$M87z67eW9SX9svjuhZcQVw0I5u+ssI5lv3bNO0X5Zwo', 'argon2id');
INSERT INTO mimu.institution_memberships (id, institution_id, user_id, status, start_date)
VALUES
  ('01a14647-413f-7980-88cb-42aedd6b5b77', '01a14706-9667-7294-b4e5-e9485d428dc9', '01a14250-1370-7d72-9c3d-cf8da6ebef3f', 'ACTIVE', '2026-08-01'),
  ('01a144f7-1571-7aa1-94d9-f7852a64b58b', '01a14706-9667-7294-b4e5-e9485d428dc9', '01a147ca-5fb7-7570-8f0c-a7f9d1d62e69', 'ACTIVE', '2026-08-01'),
  ('01a14708-24ac-715d-b7ca-cc7be551d657', '01a14706-9667-7294-b4e5-e9485d428dc9', '01a14759-5384-798e-a26b-ffcff2822949', 'ACTIVE', '2026-08-01'),
  ('01a144fb-311a-7d01-bcf5-5e43ce226a69', '01a14706-9667-7294-b4e5-e9485d428dc9', '01a1435e-6ddb-7dcb-977a-d2317326cf3a', 'ACTIVE', '2026-08-01'),
  ('01a147c2-37cd-7057-968e-d04242ceed6d', '01a14706-9667-7294-b4e5-e9485d428dc9', '01a1442c-6589-72f7-a34a-760231ed5720', 'ACTIVE', '2026-08-01');
INSERT INTO mimu.terms_and_conditions (id, version, title, content, language, published_at, is_current)
VALUES
  ('01a14688-736e-7fe5-993f-890121c7e9c4', '1.0-demo', 'Términos y condiciones de demostración', 'Texto ficticio para probar el flujo de aceptación. No constituye términos legales vigentes.', 'es', '2026-08-01T12:00:00Z', TRUE);
INSERT INTO mimu.user_roles (id, user_id, role_id, institution_id, assigned_by)
VALUES
  ('01a14341-2c74-755e-8a40-ad8dddc19ac6', '01a14250-1370-7d72-9c3d-cf8da6ebef3f', '01a1463d-000e-7671-8a7d-0de0aecc8023', '01a14706-9667-7294-b4e5-e9485d428dc9', '01a1442c-6589-72f7-a34a-760231ed5720'),
  ('01a1463b-cbe7-715f-a78b-2dcedd3aac8c', '01a147ca-5fb7-7570-8f0c-a7f9d1d62e69', '01a1463d-000e-7671-8a7d-0de0aecc8023', '01a14706-9667-7294-b4e5-e9485d428dc9', '01a1442c-6589-72f7-a34a-760231ed5720'),
  ('01a14515-b2cf-76cb-bf70-10b4d59937fb', '01a14759-5384-798e-a26b-ffcff2822949', '01a1423f-f03e-71e4-8acd-b199cd0d2f04', '01a14706-9667-7294-b4e5-e9485d428dc9', '01a1442c-6589-72f7-a34a-760231ed5720'),
  ('01a144bd-2b33-723e-aea1-98eaf9def9d8', '01a1435e-6ddb-7dcb-977a-d2317326cf3a', '01a1423f-f03e-71e4-8acd-b199cd0d2f04', '01a14706-9667-7294-b4e5-e9485d428dc9', '01a1442c-6589-72f7-a34a-760231ed5720'),
  ('01a1468a-9ccc-79bf-bbe1-c56cb463e095', '01a1442c-6589-72f7-a34a-760231ed5720', '01a14341-b9d4-7acc-86af-44c2d574a429', '01a14706-9667-7294-b4e5-e9485d428dc9', '01a1442c-6589-72f7-a34a-760231ed5720'),
  ('01a14518-df18-71ca-a2b6-5d619e892ea6', '01a14248-2db5-7016-b20e-7ef3608e9d22', '01a144bd-a5dc-7dc6-a0ab-a42c75020e49', NULL, '01a14248-2db5-7016-b20e-7ef3608e9d22');
-- users_teacher2 is the first-login test account: must_change_password=true, terms_accepted=false.
-- Ana Morales, Carlos Morales and the other ready accounts bypass first-login only because
-- the current demo terms acceptance is recorded for them where applicable.
INSERT INTO mimu.terms_acceptances (id, user_id, terms_id, accepted_at)
VALUES
  ('01a14476-3d27-71d6-97a5-a58349d5c9c0', '01a14250-1370-7d72-9c3d-cf8da6ebef3f', '01a14688-736e-7fe5-993f-890121c7e9c4', '2026-08-02T14:00:00Z'),
  ('01a142f7-4dcf-7730-b88f-71cd80e74b10', '01a147ca-5fb7-7570-8f0c-a7f9d1d62e69', '01a14688-736e-7fe5-993f-890121c7e9c4', '2026-08-02T15:00:00Z'),
  ('01a14365-3cca-7940-b530-6810f0f0b65a', '01a14759-5384-798e-a26b-ffcff2822949', '01a14688-736e-7fe5-993f-890121c7e9c4', '2026-08-02T16:00:00Z'),
  ('01a142ab-2962-7af0-ae63-f4eb6ecf301c', '01a1442c-6589-72f7-a34a-760231ed5720', '01a14688-736e-7fe5-993f-890121c7e9c4', '2026-08-02T17:00:00Z'),
  ('01a144a7-37db-7118-9de1-e1b8825763e9', '01a14248-2db5-7016-b20e-7ef3608e9d22', '01a14688-736e-7fe5-993f-890121c7e9c4', '2026-08-02T18:00:00Z');
COMMIT;
