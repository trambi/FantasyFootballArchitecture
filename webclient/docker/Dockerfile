FROM docker.io/library/nginx:1.24
ADD https://github.com/jmaaanu/FantasyFootballWebView/archive/refs/heads/master.zip /tmp/
WORKDIR /tmp
RUN apt-get update -y && \
  apt-get install -y unzip && \
  unzip master.zip && \
  cp -R FantasyFootballWebView-master/NodeServer/public/* /usr/share/nginx/html/ && \
  rm -fr archive.zip FantasyFootballWebView-master
EXPOSE 80
COPY adapt_from_env.sh /root/adapt_from_env.sh
CMD ["/bin/sh","/root/adapt_from_env.sh"]
