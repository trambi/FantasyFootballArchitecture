#! /bin/bash
readonly compose-cmd=podman-compose
readonly clientImage="docker.io/trambi/fantasyfootball_webclient:18.2"
readonly serverImage="docker.io/trambi/fantasyfootball_webserver:18.2"
readonly dbImage="docker.io/trambi/fantasyfootball_db:18.2"
readonly reverseProxyImage="docker.io/trambi/fantasyfootball_proxy:18.2"

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
  ${compose-cmd} up -d
}

stop(){
  ${compose-cmd} down
}

build(){
  ${compose-cmd} build
}

push (){
  docker tag localhost/fantasyfootballarchitecture_database:latest ${dbImage}
  docker push ${dbImage}
  docker tag localhost/fantasyfootballarchitecture_webclient:latest ${clientImage}
  docker push ${clientImage}
  docker tag localhost/fantasyfootballarchitecture_webserver:latest ${serverImage}
  docker push ${serverImage}
  docker tag localhost/fantasyfootballarchitecture_proxy:latest ${reverseProxyImage}
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