#! /bin/bash


readonly clientContainer="ff_webclient"
readonly serverContainer="ff_webserver"
readonly dbContainer="database"
readonly clientImage="localhost/ff_webclient:latest"
readonly serverImage="localhost/ff_webserver:latest"
readonly dbImage="localhost/ff_mariadb:latest"

usage(){
  echo "${0} build"
  echo "  build the three container images: ${clientImage},${serverImage} and ${dbImage}"
  echo "${0} start"
  echo "  start the three container images: ${clientImage},${serverImage} and ${dbImage}"
  echo "  with the container names : ${clientContainer},${serverContainer} and ${dbContainer}"
  echo "${0} stop"
  echo "  kill and remove the three containers"
}

start(){
  if [[ -f ".env" ]]
  then
    source .env
  fi
  docker run -d -p80:80 -e API_FQDN=${API_FQDN} --name ${clientContainer} ${clientImage}
  docker run -d -p8080:80 -e DBHOST=${API_FQDN} -e DBUSER=${DB_USER} -e DBPASSWD=${DB_PASSWORD} --name ${serverContainer} ${serverImage}
  docker run -d -p3306:3306 -e MYSQL_DATABASE=tournament -e MYSQL_USER=${DB_USER} -e MYSQL_PASSWORD=${DB_PASSWORD} -e MYSQL_ROOT_PASSWORD=${DB_ROOT_PASSWORD} --name ${dbContainer}  -v mydata:/var/lib/mysql -v $(pwd)/mariadb/docker/sql:/docker-entrypoint-initdb.d/:Z ${dbImage}
}

stop(){
  docker kill "${dbContainer}" "${serverContainer}" "${clientContainer}"
  docker rm "${dbContainer}" "${serverContainer}" "${clientContainer}"
}

build(){
  (
    cd mariadb/docker
    docker build -t ${dbImage} .
  )
  (
    cd webclient/docker
    docker build -t ${clientImage} .
  )
  (
    cd webserver
    docker build -t ${serverImage} .
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

if [[ "$1" == "stop" ]]
then
  stop
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