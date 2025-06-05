FROM ubuntu:latest as builder
RUN apt-get update && apt-get install -y gettext-base

FROM prom/prometheus
WORKDIR /etc/prometheus

COPY --from=builder /usr/bin/envsubst /usr/bin/envsubst
COPY prometheus.yml.template .
COPY --chmod=0755 entrypoint.sh .

EXPOSE 9090
ENTRYPOINT ["/etc/prometheus/entrypoint.sh"]
