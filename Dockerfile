FROM alpine:latest as builder
RUN apk add --no-cache gettext
COPY prometheus.yml.template .

FROM prom/prometheus
WORKDIR /etc/prometheus

COPY --from=builder /usr/bin/envsubst /usr/bin/envsubst
COPY prometheus.yml.template .
COPY --chmod=0755 entrypoint.sh .

EXPOSE 9090
ENTRYPOINT ["/etc/prometheus/entrypoint.sh"]
