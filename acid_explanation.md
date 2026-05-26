# ACID Explanation

I am using Scenario 1 as my example.
In Scenario 1 a student submits a solution and test results are saved together.

## Atomicity
either everything saves or nothing saves.
in Scenario 1 we insert one submission and two test results together.
if inserting test results fails then the submission is also rolled back.
we never get a submission without test results.

## Consistency
the database should always be in a correct state.
in Scenario 1 submission has a valid student and problem.
test results point to a valid submission.
after transaction everything is still linked correctly.

## Isolation
two transactions do not affect each other.
if two students submit at the same time they run separately.
one student cannot see the other students uncommitted data.
each transaction thinks it is the only one running.

## Durability
once committed the data is saved forever.
in Scenario 1 after COMMIT the submission and test results are permanent.
even if the system crashes right after the data will still be there.