echo "INFO: Starting a MySQL database server for tests"
docker run --name mysql -e MYSQL_ROOT_PASSWORD=P@ssw0rd -v $(pwd):/scripts -p 3307:3306 -d mysql:8.0-debian

echo "INFO: Wainting for database server to initialize"
sleep 15 

echo "INFO: Creating a database for test"
docker exec mysql sh -c 'mysql -u root -pP@ssw0rd < /scripts/test-queries/1-create-database.sql'

echo "INFO: Starging a liquibase container"
hostIP=$(hostname -i)
docker run -v $(pwd):/repos --workdir /repos/ -e INSTALL_MYSQL=true \
    -e LIQUIBASE_COMMAND_USERNAME=root \
    -e LIQUIBASE_COMMAND_PASSWORD=P@ssw0rd \
    -e LIQUIBASE_COMMAND_URL=jdbc:mysql://$hostIP:3307/ShopDB \
    liquibase/liquibase liquibase update --labels="0.0.1"

