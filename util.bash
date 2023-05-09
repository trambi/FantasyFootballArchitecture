#! /bin/bash
readonly composeCmd="podman-compose"
readonly tagCmd="podman image tag"
readonly pushCmd="podman image push"
readonly clientImage="docker.io/trambi/fantasyfootball_webclient:19.0"
readonly serverImage="docker.io/trambi/fantasyfootball_webserver:18.2"
readonly dbImage="docker.io/trambi/fantasyfootball_db:18.2"
readonly reverseProxyImage="docker.io/trambi/fantasyfootball_proxy:19.0"

usage(){
  echo "${0} build"
  echo "  build the four container images: ${clientImage}, ${serverImage}, ${reverseProxyImage} and ${dbImage}"
  echo "${0} start"
  echo "  start the container images: ${clientImage}, ${serverImage}, ${reverseProxyImage} and ${dbImage}"
  echo "${0} stop"
  echo "  kill and remove the containers"
  echo "${0} push"
  echo "  push the container images: ${clientImage}, ${serverImage}, ${reverseProxyImage} and ${dbImage}"
   
}

start(){
  if [[ -f ".env" ]]
  then
    source .env
  fi
  ${composeCmd} up -d
}

stop(){
  ${composeCmd} down
}

build(){
  ${composeCmd} build
}

push (){
  ${tagCmd} localhost/fantasyfootballarchitecture_database:latest ${dbImage}
  ${pushCmd} ${dbImage}
  ${tagCmd} localhost/fantasyfootballarchitecture_webclient:latest ${clientImage}
  ${pushCmd} ${clientImage}
  ${tagCmd} localhost/fantasyfootballarchitecture_webserver:latest ${serverImage}
  ${pushCmd} ${serverImage}
  ${tagCmd} localhost/fantasyfootballarchitecture_proxy:latest ${reverseProxyImage}
  ${pushCmd} ${reverseProxyImage}
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