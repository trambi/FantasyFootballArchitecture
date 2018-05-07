#! /bin/sh

sed -i "s#51.15.207.35#${API_FQDN}#" /usr/share/nginx/html/scripts/services.ws.js
nginx -g "daemon off;"
