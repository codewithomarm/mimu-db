-- MIMU v1.3: catálogo RBAC oficial. Ejecutar como migración versionada, una sola vez.
-- IDs fijos UUIDv7 generados fuera de PostgreSQL. No contiene usuarios ni datos de demo.
BEGIN;
INSERT INTO mimu.roles (id, code, name, scope, description)
VALUES
  ('01a1463d-000e-7671-8a7d-0de0aecc8023', 'PARENT_GUARDIAN', 'Tutor', 'INSTITUTION', 'Consulta información autorizada de estudiantes vinculados.'),
  ('01a1423f-f03e-71e4-8acd-b199cd0d2f04', 'TEACHER', 'Educador', 'INSTITUTION', 'Opera en grupos, materias y períodos asignados.'),
  ('01a14341-b9d4-7acc-86af-44c2d574a429', 'SCHOOL_ADMIN', 'Administrador escolar', 'INSTITUTION', 'Administra datos escolares de su institución.'),
  ('01a144bd-a5dc-7dc6-a0ab-a42c75020e49', 'MIMU_SUPPORT_ADMIN', 'Soporte Mimu', 'GLOBAL', 'Rol global de plataforma; herramientas avanzadas fuera del MVP.');
INSERT INTO mimu.permissions (id, code, description)
VALUES
  ('01a145b5-5838-7733-9236-b845ddb209a0', 'profile.read', 'Consultar perfil'),
  ('01a145d4-4c57-7387-9eef-210e994e99c2', 'students.read_linked', 'Consultar estudiantes vinculados'),
  ('01a14241-2298-74c0-bfa0-809c5c3d32e2', 'academic.read', 'Consultar información académica'),
  ('01a14640-a208-7def-aed0-289da1cb12c1', 'grades.read', 'Consultar calificaciones autorizadas'),
  ('01a1441a-0e96-7b43-9781-f4077a10da7c', 'tasks.read', 'Consultar tareas autorizadas'),
  ('01a14798-479c-771d-a997-706c4ab34aaf', 'messages.read', 'Consultar comunicados autorizados'),
  ('01a14582-ef20-78ff-91e2-c3051676920f', 'notifications.read', 'Consultar notificaciones propias'),
  ('01a145e4-b62b-79d1-ad47-a43241c38180', 'classroom.manage_assigned', 'Gestionar información de grupos/materias asignados'),
  ('01a14648-cedc-7516-89ca-66e2af2ed038', 'school.manage', 'Administrar información escolar de la institución'),
  ('01a1467d-af2d-728b-bea6-961a6a0e2041', 'platform.support.read', 'Consultar funciones básicas de soporte de plataforma');
INSERT INTO mimu.role_permissions (role_id, permission_id)
VALUES
  ('01a1463d-000e-7671-8a7d-0de0aecc8023', '01a145b5-5838-7733-9236-b845ddb209a0'),
  ('01a1463d-000e-7671-8a7d-0de0aecc8023', '01a145d4-4c57-7387-9eef-210e994e99c2'),
  ('01a1463d-000e-7671-8a7d-0de0aecc8023', '01a14241-2298-74c0-bfa0-809c5c3d32e2'),
  ('01a1463d-000e-7671-8a7d-0de0aecc8023', '01a14640-a208-7def-aed0-289da1cb12c1'),
  ('01a1463d-000e-7671-8a7d-0de0aecc8023', '01a1441a-0e96-7b43-9781-f4077a10da7c'),
  ('01a1463d-000e-7671-8a7d-0de0aecc8023', '01a14798-479c-771d-a997-706c4ab34aaf'),
  ('01a1463d-000e-7671-8a7d-0de0aecc8023', '01a14582-ef20-78ff-91e2-c3051676920f'),
  ('01a1423f-f03e-71e4-8acd-b199cd0d2f04', '01a145b5-5838-7733-9236-b845ddb209a0'),
  ('01a1423f-f03e-71e4-8acd-b199cd0d2f04', '01a14241-2298-74c0-bfa0-809c5c3d32e2'),
  ('01a1423f-f03e-71e4-8acd-b199cd0d2f04', '01a145e4-b62b-79d1-ad47-a43241c38180'),
  ('01a14341-b9d4-7acc-86af-44c2d574a429', '01a145b5-5838-7733-9236-b845ddb209a0'),
  ('01a14341-b9d4-7acc-86af-44c2d574a429', '01a14241-2298-74c0-bfa0-809c5c3d32e2'),
  ('01a14341-b9d4-7acc-86af-44c2d574a429', '01a145e4-b62b-79d1-ad47-a43241c38180'),
  ('01a14341-b9d4-7acc-86af-44c2d574a429', '01a14648-cedc-7516-89ca-66e2af2ed038'),
  ('01a144bd-a5dc-7dc6-a0ab-a42c75020e49', '01a145b5-5838-7733-9236-b845ddb209a0'),
  ('01a144bd-a5dc-7dc6-a0ab-a42c75020e49', '01a1467d-af2d-728b-bea6-961a6a0e2041');
COMMIT;
