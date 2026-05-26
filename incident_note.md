# Incident Note

## What happened
a developer ran an UPDATE on submissions table without a WHERE clause.
the query was meant to fix one wrong score.
but it updated all 2501 rows and set every score to 0.

## What was affected
all 2501 submission scores became 0.
students lost their correct scores.
leaderboards and reports became completely wrong.

## How it could be detected
a SELECT after UPDATE would show all scores as 0.
monitoring tools would flag that all rows changed at once.
comparing with a backup would show the difference.

## How rollback could have helped
if the developer used a transaction like this:
BEGIN TRANSACTION;
UPDATE submissions SET score = 0 WHERE submission_id = 'SUB000056';
then checked the result before committing
the mistake would be caught and ROLLBACK would undo everything.

## What to do in future
always use WHERE clause in every UPDATE and DELETE.
always run SELECT first to check which rows will be affected.
always wrap risky changes in a transaction.
take a backup before making bulk changes.
use staging tables to test before touching real data.