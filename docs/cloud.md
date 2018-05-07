# Cloud architecture
Here is the architecture used during Eurobowl 2017 and EurOpen 2017 (november 2017).
Remember basics are described [here (index)](index.md).

## Summary
All functions except administration one are running on the cloud.

## Pros and Cons
### Pros
+ We did not have to install servers, wifi routers;
+ We needed only one laptop to run our tournament;
+ We could broacast the results all around the world;
+ We have mitigated the risk on Internet connection for tournament administration.

### Cons
- We were really dependant of Internet connection for user part;
- You have to pay cloud VM;
- Install the tournament administration software on Windows laptop is not trivial.

## Details

### User's point of view
The main user is the participant to the tournament. The main purpose of this system
 is to provide rankings, matches to play...

 1. At the begin of the tournament, user activates data connection ;
 1. User open his browser with url <http://ip_on_the_cloud> ;
 1. User can navigate on the web application.

### Hardware view
Hardware is limited to tournament administrator laptop.
We have to create at least one virtual machine on Cloud - Scaleway in our case.

### Software view
Software is based on AngularJS for client and Symfony2 for servers.

Tournament database, API server and static web server - containing user application - were running on cloud server .

Admin web application use Symfony2 and Bootstrap and was running on _tournament admin laptop_


### Network view
The network is based on connection to ip_on_the_cloud. Every clients connect to the created cloud server.
