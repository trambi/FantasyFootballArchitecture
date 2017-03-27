# Fantasy Football Architecture basics
1. Client get data by connecting to API server;
1. Data are provided by API server on json format.

Reference API server is https://github.com/trambi/FantasyFootball/tree/master/TournamentCoreBundle  
Reference Javascript client is https://github.com/Zorblug/FantasyFootballWebView/tree/master/NodeServer/public 

Purpose are :
* Separation between client and server: 
you can use:
  * reference API server and reference Javascript client 
or
  * reference API server and our own Javascript client
or
  * our own API server and reference Javascript client

