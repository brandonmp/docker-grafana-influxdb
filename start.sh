#!/bin/bash

set -m

echo "=> Starting InfluxDB ..."
/etc/init.d/influxdb start

echo "=> Starting Grafana ..."
/etc/init.d/grafana-server start

echo "=> Starting Supervisor ..."
/usr/bin/supervisord
