-- Announcements, events, one-way messages and notifications. Run after 02-demo-activity.sql.
BEGIN;
INSERT INTO mimu.announcements (id, institution_id, title, message_body, publication_status, published_at, created_by)
VALUES
  ('01a14260-1865-77b8-9459-ebf70bc534f8', '01a14706-9667-7294-b4e5-e9485d428dc9', 'Semana de la lectura', 'Esta semana compartiremos cuentos, rimas y actividades de lectura en cada grupo.', 'PUBLISHED', '2026-10-12T13:00:00Z', '01a1442c-6589-72f7-a34a-760231ed5720'),
  ('01a1440c-6632-7fcf-81db-742891a9a4e9', '01a14706-9667-7294-b4e5-e9485d428dc9', 'Reunión de familias', 'Invitamos a las familias a una reunión breve para conversar sobre el progreso del período.', 'DRAFT', NULL, '01a1442c-6589-72f7-a34a-760231ed5720');
INSERT INTO mimu.announcement_recipients (id, institution_id, announcement_id, recipient_type, group_id, student_id, user_id)
VALUES
  ('01a1451c-cca4-7eb4-a7b4-40657ad04dc7', '01a14706-9667-7294-b4e5-e9485d428dc9', '01a14260-1865-77b8-9459-ebf70bc534f8', 'INSTITUTION', NULL, NULL, NULL),
  ('01a14674-d7a0-77f0-a061-4b1d93f3b4a9', '01a14706-9667-7294-b4e5-e9485d428dc9', '01a1440c-6632-7fcf-81db-742891a9a4e9', 'GROUP', '01a14555-4e34-70eb-a0e0-5fb635b82510', NULL, NULL);
INSERT INTO mimu.events (id, institution_id, title, description, event_type, starts_at, ends_at, location, publication_status, publish_at, created_by)
VALUES
  ('01a147a5-1d9a-7d33-9ed4-a7efde353b06', '01a14706-9667-7294-b4e5-e9485d428dc9', 'Día de colores', 'Actividad de expresión artística por grupos.', 'ACTIVITY', '2026-10-23T14:00:00Z', '2026-10-23T16:00:00Z', 'Patio escolar', 'PUBLISHED', NULL, '01a1442c-6589-72f7-a34a-760231ed5720'),
  ('01a14462-5241-73f4-a923-302e1733c06c', '01a14706-9667-7294-b4e5-e9485d428dc9', 'Reunión de familias de Prekínder', 'Espacio de conversación con el equipo docente.', 'MEETING', '2026-10-28T22:00:00Z', '2026-10-28T23:00:00Z', 'Aula Exploradores', 'PUBLISHED', NULL, '01a1442c-6589-72f7-a34a-760231ed5720');
INSERT INTO mimu.event_recipients (id, institution_id, event_id, recipient_type, group_id, student_id, user_id)
VALUES
  ('01a144b9-3d8c-7b67-ad0a-58476a0a8f37', '01a14706-9667-7294-b4e5-e9485d428dc9', '01a147a5-1d9a-7d33-9ed4-a7efde353b06', 'INSTITUTION', NULL, NULL, NULL),
  ('01a1437b-ec6a-740f-850c-889788abc121', '01a14706-9667-7294-b4e5-e9485d428dc9', '01a14462-5241-73f4-a923-302e1733c06c', 'GROUP', '01a14555-4e34-70eb-a0e0-5fb635b82510', NULL, NULL);
INSERT INTO mimu.messages (id, institution_id, title, content, publication_status, published_at, created_by)
VALUES
  ('01a144cf-64e3-7e85-b46b-e4b079e27ddb', '01a14706-9667-7294-b4e5-e9485d428dc9', 'Bienvenidos a la semana', 'Recordatorio: revisen la agenda del estudiante y envíen cualquier consulta por los canales oficiales.', 'PUBLISHED', '2026-10-14T13:00:00Z', '01a1442c-6589-72f7-a34a-760231ed5720'),
  ('01a14613-b981-7b37-8d08-7e43f4cae9e5', '01a14706-9667-7294-b4e5-e9485d428dc9', 'Material para actividad', 'Para la actividad de colores, pueden enviar una hoja reutilizada y crayones identificados.', 'PUBLISHED', '2026-10-15T13:00:00Z', '01a14759-5384-798e-a26b-ffcff2822949');
INSERT INTO mimu.message_recipients (id, institution_id, message_id, recipient_type, group_id, student_id, user_id)
VALUES
  ('01a14267-fff8-7fc5-af92-e04d6120e8d2', '01a14706-9667-7294-b4e5-e9485d428dc9', '01a144cf-64e3-7e85-b46b-e4b079e27ddb', 'INSTITUTION', NULL, NULL, NULL),
  ('01a1448d-33e9-709d-be36-52c90304c229', '01a14706-9667-7294-b4e5-e9485d428dc9', '01a14613-b981-7b37-8d08-7e43f4cae9e5', 'GROUP', '01a14555-4e34-70eb-a0e0-5fb635b82510', NULL, NULL);
INSERT INTO mimu.message_reads (message_id, institution_id, user_id, read_at)
VALUES
  ('01a144cf-64e3-7e85-b46b-e4b079e27ddb', '01a14706-9667-7294-b4e5-e9485d428dc9', '01a14250-1370-7d72-9c3d-cf8da6ebef3f', '2026-10-15T15:00:00Z');
INSERT INTO mimu.notifications (id, institution_id, user_id, notification_type, title, body, entity_type, entity_id, read_at)
VALUES
  ('01a1458a-b129-7701-8228-ea24f5e06561', '01a14706-9667-7294-b4e5-e9485d428dc9', '01a14250-1370-7d72-9c3d-cf8da6ebef3f', 'TASK_PUBLISHED', 'Nueva tarea', 'Se publicó una tarea para Lucía.', 'task', '01a14730-f81e-7082-a475-cd4b83198fd1', NULL),
  ('01a14362-879a-749b-a345-c553b2f9c65a', '01a14706-9667-7294-b4e5-e9485d428dc9', '01a147ca-5fb7-7570-8f0c-a7f9d1d62e69', 'MESSAGE_PUBLISHED', 'Nuevo comunicado', 'El centro publicó un comunicado para las familias.', 'message', '01a144cf-64e3-7e85-b46b-e4b079e27ddb', '2026-10-15T15:30:00Z');
COMMIT;
