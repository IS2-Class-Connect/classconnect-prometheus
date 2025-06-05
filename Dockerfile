FROM prom/prometheus:3.4.1

WORKDIR /etc/prometheus

COPY prometheus.yml.template .
COPY entrypoint.sh .

RUN chmod +x entrypoint.sh

EXPOSE 9090
ENTRYPOINT ["/etc/prometheus/entrypoint.sh"]
