FROM nginx:alpine
RUN apk add --no-cache --virtual git && \
git clone https://github.com/Zorblug/FantasyFootballWebView.git /tmp/fantasy && \
apk del git && \
cp -R /tmp/fantasy/NodeServer/public/* /usr/share/nginx/html/ && \
rm -fr /tmp/fantasy && \
sed -i "s#192.168.2.2:8080/app.php#51.15.207.35:8080/app.php/ws#" "/usr/share/nginx/html/scripts/services.ws.js"
EXPOSE 80
