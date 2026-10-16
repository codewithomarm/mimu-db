-- Run after all demo scripts. Each query should return the expected counts or zero violations.
SET search_path TO mimu, public;
SELECT 'institutions' AS check_name, count(*) AS actual FROM institutions WHERE code='DEMO-ARCOIRIS';
SELECT 'required_roles' AS check_name, count(*) AS actual FROM roles WHERE code IN ('PARENT_GUARDIAN','TEACHER','SCHOOL_ADMIN','MIMU_SUPPORT_ADMIN');
SELECT 'demo_users' AS check_name, count(*) AS actual FROM users WHERE email LIKE '%@demo.mimu.example';
SELECT 'students' AS check_name, count(*) AS actual FROM students WHERE institution_id=(SELECT id FROM institutions WHERE code='DEMO-ARCOIRIS');
SELECT 'active_enrollment_duplicates' AS check_name, count(*) AS violations FROM (SELECT student_id FROM enrollments WHERE status='ACTIVE' GROUP BY student_id HAVING count(*)>1) x;
SELECT 'task_status_date_mismatch' AS check_name, count(*) AS violations FROM task_assignments WHERE NOT ((status='PENDING' AND submitted_at IS NULL) OR (status='SUBMITTED' AND submitted_at IS NOT NULL));
SELECT 'ready_accounts_without_terms_evidence' AS check_name, count(*) AS violations FROM users u WHERE u.email LIKE '%@demo.mimu.example' AND u.must_change_password=false AND u.terms_accepted=true AND NOT EXISTS (SELECT 1 FROM terms_acceptances ta WHERE ta.user_id=u.id AND ta.terms_id=(SELECT id FROM terms_and_conditions WHERE is_current AND language='es'));
SELECT 'missing_primary_guardians' AS check_name, count(*) AS violations FROM students s WHERE s.institution_id=(SELECT id FROM institutions WHERE code='DEMO-ARCOIRIS') AND s.status='ACTIVE' AND NOT EXISTS (SELECT 1 FROM student_guardians sg WHERE sg.student_id=s.id AND sg.status='ACTIVE' AND sg.is_primary);
-- Security reminder: the shared demo password is for local development only; never use in production.
