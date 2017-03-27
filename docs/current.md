# Current architecture 
Here is the architecture used during Rendez-vous Bloodbowl 14 (may 2016). Basics are described [here](index.md)

## User's point of view
The main user is the participant to the tournament. The main purpose of this system
 is to provide rankings, matches to play...

 1. At the begin of the tournament, user activates wifi 
 and connect to the _rdvbb_ open wifi network ;
 1. User open his browser with url <http://192.168.2.3> ;
 1. User can navigate on the web application.

## Hardware view
Hardware fit in large plastic box (blue one for the record :-) ). The plastic box contains:
* Tournament administrator laptop;
* Two wi-fi routers;
* Two Raspberry PI (_web.rdvbb_ and _mysql.rdvbb_);
* Three ethernet cables.

## Software view
Software is based on AngularJS on client and Symfony2 on servers.
* MySQL server hosts tournament database - running on _mysql.rdvbb_ Raspberry PI;
* API server returns json data from HTTP Get requests using Symfony2 - running on _web.rdvbb_ Raspberry PI;
* Web aplication server is static content - running on _web.rdvbb_ Raspberry PI;
* User web application - running on user browser - is based AngularJS.
 It exchange json data with API server;
* Admin web application use Symfony2 and Bootstrap - running on _tournament admin laptop_

## Network view
The network is based on wifi network _rdvbb_ (192.168.2.0/24). 
DHCP server on wifi routers delivers IP address from 192.168.2.100 (to 192.168.2.254).
 * _web.rdvbb_ use IP address 192.168.2.3 - port 80 for static http server, port 8080 for API server;
 * _mysql.rdvbb_ use IP address 192.168.2.5 - port 3360 for MySQL server;
 * _tournament admin laptop_ can use any unused IP address of 192.168.2.0/24.
