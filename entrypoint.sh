#!/bin/sh
set -e

echo "Validating environment variables"
missing_vars=0
REQUIRED_VARS="USERS_DOMAIN EDUCATION_DOMAIN ADMINS_DOMAIN"
for var in $REQUIRED_VARS; do
  if [ -z "${!var}" ]; then
    echo "✗ $var (not set)"
    missing_vars=1
  else
    echo "✓ $var=${!var}"
  fi
done

if [ $missing_vars -ne 0 ]; then
  exit 1
fi

echo "Generating config file"
envsubst < /etc/prometheus/prometheus.yml.template > /etc/prometheus/prometheus.yml

# Validate config file
if ! promtool check config /etc/prometheus/prometheus.yml 2>&1; then
  echo "Error: Invalid Prometheus configuration"
  exit 1
fi

echo "Starting Prometheus server"
exec /bin/prometheus \
  --config.file=/etc/prometheus/prometheus.yml \
  --web.listen-address=:9090
