#!/bin/sh
set -e

echo "Validating environment variables"
missing_vars=0
REQUIRED_VARS="USERS_DOMAIN EDUCATION_DOMAIN ADMINS_DOMAIN"
for var in $REQUIRED_VARS; do
  value=$(eval echo \"\$$var\")
  if [ -z "$value" ]; then
    echo "✗ $var (not set)"
    missing_vars=1
  else
    echo "✓ $var=$value"
  fi
done

if [ $missing_vars -ne 0 ]; then
  exit 1
fi

echo "Generating config file"
sed \
  -e "s/\$USERS_DOMAIN/$USERS_DOMAIN/g" \
  -e "s/\$EDUCATION_DOMAIN/$EDUCATION_DOMAIN/g" \
  -e "s/\$ADMINS_DOMAIN/$ADMINS_DOMAIN/g" \
  /etc/prometheus/prometheus.yml.template > /etc/prometheus/prometheus.yml

# Validate config file
if ! promtool check config /etc/prometheus/prometheus.yml 2>&1; then
  echo "Error: Invalid Prometheus configuration"
  exit 1
fi

echo "Starting Prometheus server"
exec /bin/prometheus \
  --config.file=/etc/prometheus/prometheus.yml \
  --web.listen-address=:9090
