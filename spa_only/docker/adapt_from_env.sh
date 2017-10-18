#! /bin/sh

sed -i "s#http://192.168.2.2:8080/app.php#${API_ROOT_URL}#" /usr/share/nginx/html/scripts/services.ws.js
nginx -g "daemon off;"
