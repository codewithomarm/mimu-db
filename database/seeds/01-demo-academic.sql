-- Academic structure and family links. Run after 00-demo-identity.sql.
BEGIN;
INSERT INTO mimu.grade_levels (id, institution_id, name, sort_order)
VALUES
  ('01a145c9-c2e0-7e72-bdc8-bc7a252fa695', '01a14706-9667-7294-b4e5-e9485d428dc9', 'Maternal', '1'),
  ('01a146ea-0256-761e-9c26-4087acdb5c92', '01a14706-9667-7294-b4e5-e9485d428dc9', 'Prekínder', '2'),
  ('01a145fd-ae7e-7a4e-be07-49891a844ffa', '01a14706-9667-7294-b4e5-e9485d428dc9', 'Prekínder avanzado', '3');
INSERT INTO mimu.academic_periods (id, institution_id, name, start_date, end_date, status)
VALUES
  ('01a145d2-6c3f-7599-9350-977713d18d35', '01a14706-9667-7294-b4e5-e9485d428dc9', 'Año lectivo 2026', '2026-03-02', '2026-12-18', 'ACTIVE');
INSERT INTO mimu.groups (id, institution_id, grade_id, academic_period_id, name, status)
VALUES
  ('01a147d4-daa6-7220-aabf-7e184d5c1e6a', '01a14706-9667-7294-b4e5-e9485d428dc9', '01a145c9-c2e0-7e72-bdc8-bc7a252fa695', '01a145d2-6c3f-7599-9350-977713d18d35', 'A', 'ACTIVE'),
  ('01a14555-4e34-70eb-a0e0-5fb635b82510', '01a14706-9667-7294-b4e5-e9485d428dc9', '01a146ea-0256-761e-9c26-4087acdb5c92', '01a145d2-6c3f-7599-9350-977713d18d35', 'B', 'ACTIVE'),
  ('01a14202-2cc0-7f49-ae31-1ed8cee95452', '01a14706-9667-7294-b4e5-e9485d428dc9', '01a145fd-ae7e-7a4e-be07-49891a844ffa', '01a145d2-6c3f-7599-9350-977713d18d35', 'C', 'ACTIVE');
INSERT INTO mimu.students (id, institution_id, internal_code, name, last_name, birth_date, allergies, status)
VALUES
  ('01a14790-4585-7345-a97a-1c450e39d3ed', '01a14706-9667-7294-b4e5-e9485d428dc9', 'LUC-001', 'Lucía', 'Morales', '2022-04-12', 'Sin alergias conocidas', 'ACTIVE'),
  ('01a1427f-90b1-7592-a4cb-8bcc9caad2c9', '01a14706-9667-7294-b4e5-e9485d428dc9', 'MAT-002', 'Mateo', 'Morales', '2023-01-30', 'Alergia ficticia a la fresa; verificar siempre en la ficha autorizada', 'ACTIVE'),
  ('01a1438c-688a-7533-afc8-9129ca890471', '01a14706-9667-7294-b4e5-e9485d428dc9', 'SOF-003', 'Sofía', 'Castillo', '2021-11-05', NULL, 'ACTIVE');
INSERT INTO mimu.student_guardians (id, institution_id, guardian_user_id, student_id, relationship, is_primary, can_receive_notifications, status)
VALUES
  ('01a1438a-901b-7e65-8d58-43c3c6d6ad6b', '01a14706-9667-7294-b4e5-e9485d428dc9', '01a14250-1370-7d72-9c3d-cf8da6ebef3f', '01a14790-4585-7345-a97a-1c450e39d3ed', 'Madre', TRUE, TRUE, 'ACTIVE'),
  ('01a147b7-0f54-73b5-ae27-21eef506cd7b', '01a14706-9667-7294-b4e5-e9485d428dc9', '01a14250-1370-7d72-9c3d-cf8da6ebef3f', '01a1427f-90b1-7592-a4cb-8bcc9caad2c9', 'Madre', TRUE, TRUE, 'ACTIVE'),
  ('01a143b1-15d8-7f06-9528-d40bf89c2ad9', '01a14706-9667-7294-b4e5-e9485d428dc9', '01a147ca-5fb7-7570-8f0c-a7f9d1d62e69', '01a1438c-688a-7533-afc8-9129ca890471', 'Padre', TRUE, TRUE, 'ACTIVE'),
  ('01a14521-24d8-7488-ab1c-090872b503df', '01a14706-9667-7294-b4e5-e9485d428dc9', '01a147ca-5fb7-7570-8f0c-a7f9d1d62e69', '01a14790-4585-7345-a97a-1c450e39d3ed', 'Padre', FALSE, TRUE, 'ACTIVE');
INSERT INTO mimu.enrollments (id, institution_id, student_id, group_id, start_date, status)
VALUES
  ('01a145c4-a394-73d8-85fb-ea3f679710f3', '01a14706-9667-7294-b4e5-e9485d428dc9', '01a14790-4585-7345-a97a-1c450e39d3ed', '01a14555-4e34-70eb-a0e0-5fb635b82510', '2026-03-02', 'ACTIVE'),
  ('01a147f1-9cab-7d8e-ba07-8873504f59cb', '01a14706-9667-7294-b4e5-e9485d428dc9', '01a1427f-90b1-7592-a4cb-8bcc9caad2c9', '01a147d4-daa6-7220-aabf-7e184d5c1e6a', '2026-03-02', 'ACTIVE'),
  ('01a144e2-bfbe-79c4-9898-2455eed55a0e', '01a14706-9667-7294-b4e5-e9485d428dc9', '01a1438c-688a-7533-afc8-9129ca890471', '01a14202-2cc0-7f49-ae31-1ed8cee95452', '2026-03-02', 'ACTIVE');
INSERT INTO mimu.subjects (id, institution_id, code, name, description, is_active)
VALUES
  ('01a1454f-0217-7354-b7a0-d0885b11387a', '01a14706-9667-7294-b4e5-e9485d428dc9', 'COM', 'Comunicación y lenguaje', 'Lenguaje oral, cuentos y vocabulario.', TRUE),
  ('01a14453-2a63-79b6-a1ff-effef6d40ded', '01a14706-9667-7294-b4e5-e9485d428dc9', 'MAT', 'Pensamiento lógico', 'Clasificación, formas y conteo inicial.', TRUE),
  ('01a14478-d674-761a-835a-1a83d980a60c', '01a14706-9667-7294-b4e5-e9485d428dc9', 'ART', 'Arte y creatividad', 'Exploración de materiales y expresión artística.', TRUE);
INSERT INTO mimu.teaching_assignments (id, institution_id, teacher_user_id, group_id, subject_id, academic_period_id)
VALUES
  ('01a14476-6549-78a8-9d8a-37230a2730d0', '01a14706-9667-7294-b4e5-e9485d428dc9', '01a14759-5384-798e-a26b-ffcff2822949', '01a147d4-daa6-7220-aabf-7e184d5c1e6a', '01a1454f-0217-7354-b7a0-d0885b11387a', '01a145d2-6c3f-7599-9350-977713d18d35'),
  ('01a14252-7e1e-7d01-a700-dd433e50dd09', '01a14706-9667-7294-b4e5-e9485d428dc9', '01a14759-5384-798e-a26b-ffcff2822949', '01a14555-4e34-70eb-a0e0-5fb635b82510', '01a1454f-0217-7354-b7a0-d0885b11387a', '01a145d2-6c3f-7599-9350-977713d18d35'),
  ('01a144f1-733c-7d40-b727-9252a7e571e1', '01a14706-9667-7294-b4e5-e9485d428dc9', '01a1435e-6ddb-7dcb-977a-d2317326cf3a', '01a14555-4e34-70eb-a0e0-5fb635b82510', '01a14453-2a63-79b6-a1ff-effef6d40ded', '01a145d2-6c3f-7599-9350-977713d18d35'),
  ('01a1420b-55c6-7edf-9d80-5e5709b52fb0', '01a14706-9667-7294-b4e5-e9485d428dc9', '01a1435e-6ddb-7dcb-977a-d2317326cf3a', '01a14202-2cc0-7f49-ae31-1ed8cee95452', '01a14478-d674-761a-835a-1a83d980a60c', '01a145d2-6c3f-7599-9350-977713d18d35');
COMMIT;
