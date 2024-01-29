# Database migrations

Database migration tools can be very helpfull when dealing with the deployment of database schema changes. The best way to learn how to do schema migrations it to practice it!

In this task you will work with the same old `ShopDB` database for online store. The development team started using the liquibase for database schema migrations allready. The database changelog is stored in the file `task.sql`. The initial version of the database (labeled `0.0.1`) has the following tables:
- `Countries`, which has the following columns: `ID`, `Name`. 
- `Products`, which has the following columns: `ID`, `Name`. 
- `Warehouses`, which has the following columns: `ID`, `Name`, `Address`, `CountryID`
- `ProductInventory`, which has the following columns: `ID`, `ProductID`, `WarehouseAmount` and `WarehouseID`. 

## Task

### Prerequisites

1. Install and configure a MySQL database server on a Virtual Machine, connect to it with the MySQL client.
2. Fork this repository.
3. Install Docker on your computer

### Requirements

In this task, you need to develop 2 new changesets for the `ShopDB` database changelog:

- The first changeset should create a table, called `Users`, which has the following columns: `ID`, `FirstName`, `LastName`, `Email`. The changeset should have a new unique ID (just as the rest of the already existing changesets in the changelog), and it should have label `0.0.2`. 
- The second changeset should create an index, called `Email` for the `Email` field in the `Users` table. This changeset should have label `0.0.3`. 

Both changesets should have rollback procedure defined. 

### How to Test Yourself

Just in case you want to test your script on your database before submitting a pull request, you can do it by performing the following actions: 

1. Drop the `ShopDB` database using "DROP DATABASE ShopDB;" statement if you already have it on your database server. 
2. Create an empty database, called `ShopDB` on your database server. 
3. Run the intial schema migration for the `ShopDB` database with liquibase using docker on your computer: 

`
docker run -v $(pwd):/repos --workdir /repos/ -e INSTALL_MYSQL=true \
    -e LIQUIBASE_COMMAND_USERNAME=<db username> \
    -e LIQUIBASE_COMMAND_PASSWORD=<db password> \
    -e LIQUIBASE_COMMAND_URL=jdbc:mysql://<db host>:3306/ShopDB \
    liquibase/liquibase liquibase update --labels="0.0.1 
`

Make sure to run the command in the folder, where repository is clonned. If you are running the script on Windows - replace `$(pwd)` with the full path of the clonned reposotory. 
Replace <db username>, <db password> and <db host> with values for your database server before running the command. 
4. Tag the database with the initial version, so you will be able to rollback any new changesets: 

`
docker run -v $(pwd):/repos --workdir /repos/ -e INSTALL_MYSQL=true \
    -e LIQUIBASE_COMMAND_USERNAME=<db username> \
    -e LIQUIBASE_COMMAND_PASSWORD=<db password> \
    -e LIQUIBASE_COMMAND_URL=jdbc:mysql://<db host>:3306/ShopDB \
    liquibase/liquibase liquibase tag 0.0.1
`
5. Use commands, described in steps 3 and 4 to update the database to versions `0.0.2` and `0.0.3` you will create while workin on this task. 
6. Test rollback of the changeset by reverting the state of the database to a tag: 

`
docker run -v $(pwd):/repos --workdir /repos/ -e INSTALL_MYSQL=true \
    -e LIQUIBASE_COMMAND_USERNAME=<db username> \
    -e LIQUIBASE_COMMAND_PASSWORD=<db password> \
    -e LIQUIBASE_COMMAND_URL=jdbc:mysql://<db host>:3306/ShopDB \
    liquibase/liquibase liquibase rollback <tag name>
`

Replace <tag name> with the version of tag you want to rollback to (ex. `0.0.2` or `0.0.1`)
