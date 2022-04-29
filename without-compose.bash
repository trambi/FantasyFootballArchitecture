#! /bin/bash


readonly clientContainer="ff_webclient"
readonly serverContainer="ff_webserver"
readonly dbContainer="database"
readonly reverseProxyContainer="reverse-proxy"
readonly clientImage="localhost/trambi/fantasyfootball_webclient:18.2-dev"
readonly serverImage="localhost/trambi/fantasyfootball_webserver:18.2-dev"
readonly dbImage="localhost/trambi/fantasyfootball_db:18.2-dev"
readonly reverseProxyImage="localhost/trambi/fantasyfootball_proxy:18.2-dev"

usage(){
  echo "${0} build"
  echo "  build the three container images: ${clientImage},${serverImage} and ${dbImage}"
  echo "${0} start"
  echo "  start the three container images: ${clientImage},${serverImage} and ${dbImage}"
  echo "  with the container names : ${clientContainer},${serverContainer} and ${dbContainer}"
  echo "${0} stop"
  echo "  kill and remove the three containers"
  echo "${0} push"
  echo "  push the three container images: ${clientImage},${serverImage} and ${dbImage}"
   
}

start(){
  if [[ -f ".env" ]]
  then
    source .env
  fi
  docker run -d -p8081:80 -e API_FQDN=${API_FQDN} --name ${clientContainer} ${clientImage}
  docker run -d -p8080:80 -e DBHOST=${API_FQDN} -e DBUSER=${DB_USER} -e DBPASSWD=${DB_PASSWORD} --name ${serverContainer} ${serverImage}
  docker run -d -p3306:3306 -e MYSQL_DATABASE=tournament -e MYSQL_USER=${DB_USER} -e MYSQL_PASSWORD=${DB_PASSWORD} -e MYSQL_ROOT_PASSWORD=${DB_ROOT_PASSWORD} --name ${dbContainer}  -v mydata:/var/lib/mysql -v $(pwd)/mariadb/docker/sql:/docker-entrypoint-initdb.d/:Z ${dbImage}
  docker run -d -p80:80 --name ${reverseProxyContainer}  ${reverseProxyImage}
}

stop(){
  docker kill "${dbContainer}" "${serverContainer}" "${clientContainer}" "${reverseProxyContainer}"
  docker rm "${dbContainer}" "${serverContainer}" "${clientContainer}" "${reverseProxyContainer}"
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
  (
    cd reverse-proxy
    docker build -t ${reverseProxyImage} .
  )
}

push (){
  docker push ${dbImage}
  docker push ${clientImage}
  docker push ${serverImage}
  docker push ${reverseProxyImage}
}

if [[ $# -ne 1 ]]
then
  usage
  exit 1
fi

case ${1} in
  "start")
    start
    ;;
  "stop")
    stop
    ;;
  "build")
    build
    ;;
  "push")
    push
    ;;
  *)
    echo "invalid parameter '${1}'"
    usage
esac