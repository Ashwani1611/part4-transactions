-- safe delete operations

-- always select before delete to verify what will be deleted and always use specific where clause and Delete 1 - remove duplicate enrollment record

-- select before
SELECT enrollment_id, student_id, course_id
FROM enrollments
WHERE student_id = 'S0001'
AND course_id = 'C006';

-- delete duplicate keeping only the first one
DELETE FROM enrollments
WHERE student_id = 'S0001'
AND course_id = 'C006'
AND enrollment_id NOT IN (
    SELECT MIN(enrollment_id)
    FROM enrollments
    WHERE student_id = 'S0001'
    AND course_id = 'C006'
);

-- select after
SELECT enrollment_id, student_id, course_id
FROM enrollments
WHERE student_id = 'S0001'
AND course_id = 'C006';

-- Delete 2 - remove orphan attendance records
-- select before
SELECT attendance_id, student_id
FROM attendance
WHERE student_id NOT IN (
    SELECT student_id FROM students
);

-- delete orphan attendance records
DELETE FROM attendance
WHERE student_id NOT IN (
    SELECT student_id FROM students
);

-- select after
SELECT COUNT(*) as remaining_orphans
FROM attendance
WHERE student_id NOT IN (
    SELECT student_id FROM students
);