# Fantasy Football Architecture basics
1. Client get data by connecting to API server;
1. Data are provided by API server on json format.

Reference API server is [TournamentCoreBundle](https://github.com/trambi/FantasyFootball/tree/master/TournamentCoreBundle)  
Reference Javascript client is [FantasyFootballWebView](https://github.com/Zorblug/FantasyFootballWebView/tree/master/NodeServer/public)

The main purpose is __Separation between client and server__, so you can use:
  * reference API server and reference Javascript client
__or__
  * reference API server and our own Javascript client
__or__
  * our own API server and reference Javascript client
__or__
  * our own API server and our own Javascript client

## Current architectures
From Eurobowl 2017, there are two architectures :
 * [Cloud based architecture](cloud.md) - used in Eurobowl/EurOpen 2017 ;
 * [Raspberry Pi based architecture](raspberry.md) - used in Rendez-vous Bloodbowl for many years.
