FROM prom/prometheus

WORKDIR /etc/prometheus

COPY prometheus.yml.template .
COPY entrypoint.sh .

RUN chmod +x entrypoint.sh

EXPOSE 9090
ENTRYPOINT ["/etc/prometheus/entrypoint.sh"]
