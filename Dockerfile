FROM prom/prometheus

# Install gettext for envsubst
USER root
RUN apk add --no-cache gettext
USER nobody

WORKDIR /etc/prometheus

COPY prometheus.yml.template .
COPY --chmod=0755 entrypoint.sh .

EXPOSE 9090
ENTRYPOINT ["/etc/prometheus/entrypoint.sh"]
