-- safe update operations
--(select * before update data and always use where clause)

-- Update 1 - fix typo in student enrollment status
-- select before
SELECT student_id, full_name, enrollment_status
FROM students
WHERE enrollment_status = 'actve';

-- update
UPDATE students
SET enrollment_status = 'active'
WHERE enrollment_status = 'actve';

-- select after
SELECT student_id, full_name, enrollment_status
FROM students
WHERE student_id = 'S0089';

-- Update 2 - fix negative score in submissions
-- select before
SELECT submission_id, student_id, score
FROM submissions
WHERE score < 0;

-- update
UPDATE submissions
SET score = 0
WHERE score < 0;

-- select after
SELECT submission_id, student_id, score
FROM submissions
WHERE submission_id = 'SUB000056';

-- Update 3 - fix wrong submission status OK to Accepted
-- select before
SELECT submission_id, status
FROM submissions
WHERE status = 'OK';

-- update
UPDATE submissions
SET status = 'Accepted'
WHERE status = 'OK';

-- select after
SELECT submission_id, status
FROM submissions
WHERE submission_id = 'SUB000208';

-- Update 4 - fix contest end time before start time
-- select before
SELECT contest_id, start_time, end_time
FROM contests
WHERE end_time < start_time;

-- update
UPDATE contests
SET start_time = end_time,
end_time = start_time
WHERE contest_id = 'CT005';

-- select after
SELECT contest_id, start_time, end_time
FROM contests
WHERE contest_id = 'CT005';