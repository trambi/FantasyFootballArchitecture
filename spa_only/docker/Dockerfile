FROM nginx:alpine
RUN apk add --no-cache --virtual git && \
git clone https://github.com/jmaaanu/FantasyFootballWebView.git /tmp/fantasy && \
apk del git && \
cp -R /tmp/fantasy/NodeServer/public/* /usr/share/nginx/html/ && \
rm -fr /tmp/fantasy 
EXPOSE 80
COPY adapt_from_env.sh /root/adapt_from_env.sh
CMD ["/bin/sh","/root/adapt_from_env.sh"]
