#! /bin/sh

if [[ -z ${API_FQDN} ]]
then
  sed -i "s#51.15.207.35#${API_FQDN}#" /usr/share/nginx/html/scripts/services.ws.js
else
  sed -i "s#http://51.15.207.35:8080/app.php/ws#../ws#" /usr/share/nginx/html/scripts/services.ws.js
fi
nginx -g "daemon off;"
