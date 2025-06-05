FROM alpine:latest as builder

FROM prom/prometheus
WORKDIR /etc/prometheus

COPY prometheus.yml.template .
COPY --chmod=0755 entrypoint.sh .

EXPOSE 9090
ENTRYPOINT ["/etc/prometheus/entrypoint.sh"]
