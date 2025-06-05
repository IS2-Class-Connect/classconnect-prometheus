# Prometheus Monitoring Service

![Prometheus Logo](https://prometheus.io/assets/prometheus_logo_grey.svg)

A lightweight Prometheus deployment configured for Railway with persistent storage.

## Features

- ✅ **Dynamic target configuration** via environment variables
- ✅ **Configuration validation** on startup
- ✅ **Persistent metrics storage** using Railway volumes

## Configuration

### Required Environment Variables

Set these in your Railway project's **Variables** tab:

| Variable           | Description                     |
|--------------------|---------------------------------|
| `USERS_DOMAIN`     | Users service metrics endpoint  |
| `EDUCATION_DOMAIN` | Education service endpoint      |
| `ADMINS_DOMAIN`    | Admin dashboard endpoint        |
