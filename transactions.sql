-- transaction scenarios

-- Scenario 1 - student submits a solution and test results are inserted
BEGIN TRANSACTION;

-- insert a new submission
INSERT INTO submissions (submission_id, student_id, problem_id, contest_id, language, submitted_at, status, score, runtime_ms)
VALUES ('SUB999001', 'S0001', 'P0001', NULL, 'Python', '2025-08-15 10:00:00', 'Accepted', 75, 120);

-- insert test results for that submission
INSERT INTO test_results (result_id, submission_id, test_case_id, result_status, runtime_ms, memory_kb, awarded_points)
VALUES ('RES999001', 'SUB999001', 'TC00101', 'Pass', 120, 256, 25);

INSERT INTO test_results (result_id, submission_id, test_case_id, result_status, runtime_ms, memory_kb, awarded_points)
VALUES ('RES999002', 'SUB999001', 'TC00102', 'Pass', 115, 256, 25);

COMMIT;

-- verify
SELECT * FROM submissions WHERE submission_id = 'SUB999001';
SELECT * FROM test_results WHERE submission_id = 'SUB999001';

-- Scenario 2 - course enrollment is created and then rolled back due to invalid data

BEGIN TRANSACTION;

-- insert a new enrollment
INSERT INTO enrollments (enrollment_id, student_id, course_id, enrolled_on, enrollment_status)
VALUES ('E99999', 'S0001', 'C999', '2025-08-15', 'active');

ROLLBACK;

-- verify nothing was inserted
SELECT * FROM enrollments WHERE enrollment_id = 'E99999';

-- Scenario 3 - score correction with savepoint and partial rollback

BEGIN TRANSACTION;

-- fix first score
SAVEPOINT fix_score_1;
UPDATE submissions
SET score = 50
WHERE submission_id = 'SUB000001'
AND score < 0;

-- check if update looks correct
SELECT submission_id, score FROM submissions WHERE submission_id = 'SUB000001';

-- fix second score
SAVEPOINT fix_score_2;
UPDATE submissions
SET score = 0
WHERE submission_id = 'SUB000056'
AND score < 0;

-- check if update looks correct
SELECT submission_id, score FROM submissions WHERE submission_id = 'SUB000056';

-- if second update was wrong we can rollback only that one
-- ROLLBACK TO SAVEPOINT fix_score_2;

-- everything looks good so commit all
COMMIT;

-- verify both updates
SELECT submission_id, score FROM submissions
WHERE submission_id IN ('SUB000001', 'SUB000056');