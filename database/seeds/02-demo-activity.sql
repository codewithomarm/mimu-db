-- Grades, tasks, attendance and daily tracking. Run after 01-demo-academic.sql.
BEGIN;
INSERT INTO mimu.assessments (id, institution_id, teaching_assignment_id, title, description, max_score, assessment_date, created_by)
VALUES
  ('01a14590-0601-71a5-829d-6f91cda978ea', '01a14706-9667-7294-b4e5-e9485d428dc9', '01a14252-7e1e-7d01-a700-dd433e50dd09', 'Reconoce sonidos iniciales', 'Actividad oral individual.', 10.00, '2026-10-05', '01a14759-5384-798e-a26b-ffcff2822949'),
  ('01a1462e-6e49-7d56-a8a5-9ef248fa40dd', '01a14706-9667-7294-b4e5-e9485d428dc9', '01a14476-6549-78a8-9d8a-37230a2730d0', 'Participación en cuento', 'Observación de participación.', 10.00, '2026-10-06', '01a14759-5384-798e-a26b-ffcff2822949'),
  ('01a144b5-879c-7f50-9d69-90b6f5e8159c', '01a14706-9667-7294-b4e5-e9485d428dc9', '01a1420b-55c6-7edf-9d80-5e5709b52fb0', 'Exploración de colores', 'Reconocimiento y combinación de colores.', 10.00, '2026-10-07', '01a1435e-6ddb-7dcb-977a-d2317326cf3a');
INSERT INTO mimu.grade_records (id, institution_id, assessment_id, student_id, score, comment, published_at, recorded_by)
VALUES
  ('01a142bd-c3fc-7de3-ac59-59a46e287966', '01a14706-9667-7294-b4e5-e9485d428dc9', '01a14590-0601-71a5-829d-6f91cda978ea', '01a14790-4585-7345-a97a-1c450e39d3ed', 9.00, 'Identifica sonidos iniciales con seguridad.', '2026-10-06T15:00:00Z', '01a14759-5384-798e-a26b-ffcff2822949'),
  ('01a14299-4081-7619-b484-ebab583ae03a', '01a14706-9667-7294-b4e5-e9485d428dc9', '01a1462e-6e49-7d56-a8a5-9ef248fa40dd', '01a1427f-90b1-7592-a4cb-8bcc9caad2c9', 8.50, 'Participó con apoyo y atención.', '2026-10-07T15:00:00Z', '01a14759-5384-798e-a26b-ffcff2822949'),
  ('01a14607-0857-79f8-9355-11b4b7fb82c9', '01a14706-9667-7294-b4e5-e9485d428dc9', '01a144b5-879c-7f50-9d69-90b6f5e8159c', '01a1438c-688a-7533-afc8-9129ca890471', 9.50, 'Combina colores y explica su elección.', NULL, '01a1435e-6ddb-7dcb-977a-d2317326cf3a');
INSERT INTO mimu.grade_reads (grade_record_id, institution_id, user_id, read_at)
VALUES
  ('01a14299-4081-7619-b484-ebab583ae03a', '01a14706-9667-7294-b4e5-e9485d428dc9', '01a14250-1370-7d72-9c3d-cf8da6ebef3f', '2026-10-08T12:00:00Z');
INSERT INTO mimu.tasks (id, institution_id, teaching_assignment_id, title, description, due_at, publication_status, published_at, created_by)
VALUES
  ('01a14730-f81e-7082-a475-cd4b83198fd1', '01a14706-9667-7294-b4e5-e9485d428dc9', '01a14252-7e1e-7d01-a700-dd433e50dd09', 'Leer un cuento en familia', 'Leer un cuento breve y conversar sobre el personaje favorito.', '2026-10-20T23:00:00Z', 'PUBLISHED', '2026-10-10T13:00:00Z', '01a14759-5384-798e-a26b-ffcff2822949'),
  ('01a147f6-aa07-79b7-89c5-9e5cd941c128', '01a14706-9667-7294-b4e5-e9485d428dc9', '01a14476-6549-78a8-9d8a-37230a2730d0', 'Traer un objeto azul', 'Elegir un objeto seguro de color azul para compartir en clase.', '2026-10-22T13:00:00Z', 'PUBLISHED', '2026-10-11T13:00:00Z', '01a14759-5384-798e-a26b-ffcff2822949'),
  ('01a14780-8541-7e25-a3d7-2ca3ad3a4c8f', '01a14706-9667-7294-b4e5-e9485d428dc9', '01a144f1-733c-7d40-b727-9252a7e571e1', 'Clasificar formas en casa', 'Buscar objetos circulares y cuadrados con ayuda de un adulto.', '2026-10-25T23:00:00Z', 'DRAFT', NULL, '01a1435e-6ddb-7dcb-977a-d2317326cf3a');
INSERT INTO mimu.task_recipients (id, institution_id, task_id, group_id, student_id)
VALUES
  ('01a146ce-59ad-7877-b4dc-51231a4c5099', '01a14706-9667-7294-b4e5-e9485d428dc9', '01a14730-f81e-7082-a475-cd4b83198fd1', '01a14555-4e34-70eb-a0e0-5fb635b82510', NULL),
  ('01a1420f-b986-7b69-9201-e2b7e3f2cd2b', '01a14706-9667-7294-b4e5-e9485d428dc9', '01a147f6-aa07-79b7-89c5-9e5cd941c128', '01a147d4-daa6-7220-aabf-7e184d5c1e6a', NULL),
  ('01a1465b-a70a-70d1-b895-bae97c349bc9', '01a14706-9667-7294-b4e5-e9485d428dc9', '01a14780-8541-7e25-a3d7-2ca3ad3a4c8f', '01a14555-4e34-70eb-a0e0-5fb635b82510', NULL);
INSERT INTO mimu.task_assignments (id, institution_id, task_id, student_id, status, submitted_at, updated_by)
VALUES
  ('01a146de-683d-7342-b409-9fb5c13dc243', '01a14706-9667-7294-b4e5-e9485d428dc9', '01a14730-f81e-7082-a475-cd4b83198fd1', '01a14790-4585-7345-a97a-1c450e39d3ed', 'PENDING', NULL, '01a14759-5384-798e-a26b-ffcff2822949'),
  ('01a145a8-3074-782b-b0bb-90960d500653', '01a14706-9667-7294-b4e5-e9485d428dc9', '01a147f6-aa07-79b7-89c5-9e5cd941c128', '01a1427f-90b1-7592-a4cb-8bcc9caad2c9', 'SUBMITTED', '2026-10-13T16:00:00Z', '01a14759-5384-798e-a26b-ffcff2822949');
INSERT INTO mimu.attendance_records (id, institution_id, student_id, group_id, record_date, status, notes, recorded_by)
VALUES
  ('01a14590-a78e-79bf-87a6-d481de24f69e', '01a14706-9667-7294-b4e5-e9485d428dc9', '01a14790-4585-7345-a97a-1c450e39d3ed', '01a14555-4e34-70eb-a0e0-5fb635b82510', '2026-10-15', 'PRESENT', NULL, '01a14759-5384-798e-a26b-ffcff2822949'),
  ('01a147de-61b4-7308-a491-983ee28bfb0c', '01a14706-9667-7294-b4e5-e9485d428dc9', '01a1427f-90b1-7592-a4cb-8bcc9caad2c9', '01a147d4-daa6-7220-aabf-7e184d5c1e6a', '2026-10-15', 'LATE', 'Llegó unos minutos después del inicio.', '01a14759-5384-798e-a26b-ffcff2822949'),
  ('01a14215-ad9f-789a-ad3e-780b125422cc', '01a14706-9667-7294-b4e5-e9485d428dc9', '01a1438c-688a-7533-afc8-9129ca890471', '01a14202-2cc0-7f49-ae31-1ed8cee95452', '2026-10-15', 'ABSENT', 'Ausencia registrada por la institución.', '01a1435e-6ddb-7dcb-977a-d2317326cf3a');
INSERT INTO mimu.daily_tracking (id, institution_id, student_id, group_id, record_date, meal_status, mood_status, notes, recorded_by)
VALUES
  ('01a1461e-00c4-7f43-bdd8-7413e2f21a1d', '01a14706-9667-7294-b4e5-e9485d428dc9', '01a14790-4585-7345-a97a-1c450e39d3ed', '01a14555-4e34-70eb-a0e0-5fb635b82510', '2026-10-15', 'GOOD', 'HAPPY', 'Almorzó bien y participó en las actividades.', '01a14759-5384-798e-a26b-ffcff2822949'),
  ('01a143ea-f2db-740d-9e68-ab43ac0780ed', '01a14706-9667-7294-b4e5-e9485d428dc9', '01a1427f-90b1-7592-a4cb-8bcc9caad2c9', '01a147d4-daa6-7220-aabf-7e184d5c1e6a', '2026-10-15', 'FAIR', 'CHEERFUL', 'Comió parte del almuerzo; estuvo animado.', '01a14759-5384-798e-a26b-ffcff2822949'),
  ('01a1441f-254d-7a88-8a6d-90f883d26014', '01a14706-9667-7294-b4e5-e9485d428dc9', '01a1438c-688a-7533-afc8-9129ca890471', '01a14202-2cc0-7f49-ae31-1ed8cee95452', '2026-10-15', 'DID_NOT_EAT', 'SAD', 'Registro ficticio para probar estados; revisar visibilidad autorizada.', '01a1435e-6ddb-7dcb-977a-d2317326cf3a');
COMMIT;
