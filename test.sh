echo "INFO: Starting a MySQL database server for tests"
docker network create -d bridge test-network
docker run --name mysql --network=test-network --hostname mysql  \
-e MYSQL_ROOT_PASSWORD=P@ssw0rd -v $(pwd):/scripts -d mysql:8.0-debian

echo "INFO: Wainting for database server to initialize"
sleep 15 

echo "INFO: Creating a database for test"
docker exec mysql sh -c 'mysql -u root -pP@ssw0rd < /scripts/test-queries/1-create-database.sql'

echo "INFO: Starging a liquibase container"
docker run --network=test-network -v $(pwd):/repos --workdir /repos/ -e INSTALL_MYSQL=true \
    -e LIQUIBASE_COMMAND_USERNAME=root \
    -e LIQUIBASE_COMMAND_PASSWORD=P@ssw0rd \
    -e LIQUIBASE_COMMAND_URL=jdbc:mysql://mysql:3306/ShopDB \
    liquibase/liquibase liquibase update --labels="0.0.1"

