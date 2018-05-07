#! /bin/sh

sed -i "s#http://localhost:8080/FantasyFootball2/web/app_dev.php#${API_ROOT_URL}#" /usr/share/nginx/html/scripts/services.ws.js
nginx -g "daemon off;"
