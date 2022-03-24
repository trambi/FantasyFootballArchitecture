#! /bin/bash

usage(){
  echo "${0} build"
  echo "  build the three docker images"
  echo "${0} start"
  echo "  start the three docker images"
}

start(){
  docker run -d -p80:80 -e API_FQDN=${API_FQDN} --name ff_webclient localhost/ff_webclient:latest
  docker run -d -p8080:80 -e DBHOST=${API_FQDN} -e DBUSER=${DB_USER} -e DBPASSWD=${DB_PASSWORD} --name ff_webserver localhost/ff_webserver:latest
  docker run -d -p3306:3306 -e MYSQL_DATABASE=tournament -e MYSQL_USER=${DB_USER} -e MYSQL_PASSWORD=${DB_PASSWORD} -e MYSQL_ROOT_PASSWORD=${DB_ROOT_PASSWORD} --name database  -v mydata:/var/lib/mysql -v $(pwd)/mariadb/docker/sql:/docker-entrypoint-initdb.d/:Z localhost/ff_mariadb:latest
}

build(){
  (
    cd mariadb/docker
    docker build -t ff_mariadb:latest .
  )
  (
    cd webclient/docker
    docker build -t ff_webclient:latest .
  )
  (
    cd webserver
    docker build -t ff_webserver:latest .
  )
}
done=0
if [[ $# -gt 1 ]]
then
  usage
  exit 1
fi

if [[ "$1" == "start" ]]
then
  start
  done=1
fi

if [[ "$1" == "build" ]]
then
  build
  done=1
fi

if [[ ${done} -eq 0 ]]
then
  usage
  exit 1
fi