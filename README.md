# rda_task_9_running_database_migrations

- existing liquibase project 
- add 2 changesets 
    - firts changeset: 
        - adds a new table "Users" (id, first name, last name, email, address)
        - has label "0.0.2"
    - second changeset 
        - creates index, called "Email" for column "Email" in the "Users" table
        - has label "0.0.3"
- both changesets should support rollback scenario


test scenario
- apply 0.0.1 
    - check if users table is not created 
    - tag 0.0.1 
- apply 0.0.2 
    - tag 0.0.2
    - check if users table is presnt 
    - check if index is not created 
- apply 0.0.3 
    - tag 0.0.3
    - check if index is created
- rollback to 0.0.2 
    - check if index was removed 
- rollback to 0.0.1
    - check if users table was removed 