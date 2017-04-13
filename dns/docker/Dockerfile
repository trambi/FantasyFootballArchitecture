FROM andyshinn/dnsmasq
RUN echo "conf-dir=/etc/dnsmasq.d/,*.conf" >> /etc/dnsmasq.conf
RUN mkdir /etc/dnsmasq.d
RUN echo "addn-hosts=/etc/dnsmasq.d/added_hosts" >> /etc/dnsmasq.d/custom.conf
COPY etc_hosts_to_add /etc/dnsmasq.d/added_hosts
EXPOSE 53 53/udp
ENTRYPOINT ["dnsmasq","-k"]
