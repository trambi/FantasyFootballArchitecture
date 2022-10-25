# Fantasy Football Architecture
This repository is about the architecture of Fantasy Football tournament.

- `deploy` directory contains deployment files;
- `docs` directory contains documentation about architecture;
- `domain` directory contains documentation about domain after an event storming
- `dns` directory contains technical files to handle name resolution;
- `mariadb` directory contains dockerfile and SQL to create database;
- `reverse-proxy` contains configuration to create a reverse-proxy;
- `webclient` contains dockerfile to create a docker container serving webclient;
- `webserver` contains dockerfile to create a docker container serving server side (API REST web service and Admin apps) and python script to test API.

## Launch

The purpose is to launch the system (webclient, webserver, reverse-proxy and database) in a limited number of commands with `docker-compose` or `podman-compose`.
`docker-compose.yaml`, `docker-compose-raspberrypi.yaml` and `deploy/docker-compose.yaml` are Docker compose files. 
 * You define three environment variables `DB_USER`, `DB_PASSWORD`, `DB_ROOT_PASSWORD` :
  * ```export DB_USER=the_user_you_want```
  * ```export DB_PASSWORD=do_change_this```
  * ```export DB_ROOT_PASSWORD=seriously_do_change_this```
 * Then you launch the service with ```docker-compose -f deploy/docker-compose.yaml up -d```.

 If everything is right, open your browser, you should have:
   * in http://localhost/live/index.html , you have the client, select the edition and the language;
   * in http://localhost/admin/main, you have the admin main page with user test and password `password`.

## Build

The purpose is to build the system (webclient, webserver, reverse-proxy and database) in a limited number of commands with `docker-compose` or `podman-compose` and `bash`.
You use the command `bash util.bash build`.

