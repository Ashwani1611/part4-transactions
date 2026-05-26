# Part 4 - Transactions and Safe Changes

This is Part 4 of the  assignment.
It covers safe data changes and transaction handling.

## Files
- safe_updates.sql - 4 safe UPDATE operations with before and after checks
- safe_deletes.sql - 2 safe DELETE operations with before and after checks
- transactions.sql - 3 transaction scenarios with commit and rollback
- acid_explanation.md - explains ACID properties using my own transaction
- incident_note.md - a story about what can go wrong without transactions
- README.md - this file

## How to Run
sqlite3 codejudge_raw.db < safe_updates.sql
sqlite3 codejudge_raw.db < safe_deletes.sql
sqlite3 codejudge_raw.db < transactions.sql