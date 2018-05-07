# Fantasy Football Architecture
This repository is about the architecture of Fantasy Football tournament.
 * _docs_ directory contains documentation about architecture;
 * _dns_ directory contains technical files to handle name resolution;
 * _webclient_ contains dockerfile to create a docker container serving webclient;
 * _webserver_ contains dockerfile to create a docker container serving server side (API REST web service and Admin apps).

## Docker-compose
 _docker-compose.yaml_ is a Docker compose file. The purpose is to launch the system (webclient, webserver and database) in a limited number of commands:
 * You define once four environment variables _DB_USER_, _DB_PASSWORD_, _DB_ROOT_PASSWORD_ and API_FQDN:
  * ```export DB_USER=the_user_you_want```
  * ```export DB_PASSWORD=do_change_this```
  * ```export DB_ROOT_PASSWORD=seriously_do_change_this```
  * ```export API_FQDN=localhost```
 * Then you launch the service with ```docker-compose up -d```.

 If everything is right, open your browser, you should have:
   * in http://localhost/ , you have the client, select the edition and the language;
   * in http://localhost:8080/app.php/admin/main, you have the admin main page.
