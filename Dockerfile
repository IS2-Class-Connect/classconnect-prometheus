FROM prom/prometheus
WORKDIR /etc/prometheus

COPY prometheus.yml.template .
COPY --chmod=0755 entrypoint.sh .

HEALTHCHECK --interval=30s --timeout=5s \
  CMD wget -q -O /dev/null http://localhost:9090/-/healthy || exit 1EXPOSE 9090

ENTRYPOINT ["/etc/prometheus/entrypoint.sh"]
