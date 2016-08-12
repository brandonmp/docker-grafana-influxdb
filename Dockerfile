FROM	ubuntu:14.04

ENV GRAFANA_VERSION 3.1.1-1470047149
ENV INFLUXDB_VERSION 1.0.0-beta3

# Prevent some error messages
ENV DEBIAN_FRONTEND noninteractive

RUN		apt-get -y update && apt-get -y upgrade

# ---------------- #
#   Installation   #
# ---------------- #

# Install all prerequisites
RUN 	apt-get -y install wget curl libfontconfig

# Install Grafana to /src/grafana
RUN wget https://grafanarel.s3.amazonaws.com/builds/grafana_${GRAFANA_VERSION}_amd64.deb
RUN dpkg -i grafana_${GRAFANA_VERSION}_amd64.deb
RUN rm grafana_${GRAFANA_VERSION}_amd64.deb

# Install InfluxDB
RUN wget https://dl.influxdata.com/influxdb/releases/influxdb_${INFLUXDB_VERSION}_amd64.deb
RUN dpkg -i influxdb_${INFLUXDB_VERSION}_amd64.deb
RUN rm influxdb_${INFLUXDB_VERSION}_amd64.deb
 
# ----------- #
#   Cleanup   #
# ----------- #

RUN		apt-get autoremove -y wget curl && \
			apt-get -y clean && \
			rm -rf /var/lib/apt/lists/* && rm -f /*.sh

# ---------------- #
#   Expose Ports   #
# ---------------- #

# Grafana
EXPOSE	3000

# InfluxDB Admin server
EXPOSE	8083

# InfluxDB HTTP API
EXPOSE	8086

# InfluxDB HTTPS API
EXPOSE	8084

# -------- #
#   Run!   #
# -------- #

CMD		["/root/start.sh"]
