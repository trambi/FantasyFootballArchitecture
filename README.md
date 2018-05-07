# Fantasy Football Architecture
This repository is about the architecture of Fantasy Football tournament.
 * _docs_ directory contains documentation about architecture;
 * _dns_ directory contains technical files to handle name resolution;
 * _webclient_ contains dockerfile to create a docker container serving webclient;
 * _webserver_ contains dockerfile to create a docker container serving server side (API REST web service and Admin apps).

 _docker-compose.yaml_ is a Docker compose file. The purpose is to launch the system (webserver and database) in a single command ```docker-compose up -d```.
