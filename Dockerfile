FROM debian:buster-slim

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y --no-install-recommends \
	gnupg2 \
	wget \
	ca-certificates

RUN wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | apt-key add -
RUN echo "deb https://artifacts.elastic.co/packages/7.x/apt stable main" | tee /etc/apt/sources.list.d/elastic-7.x.list
ENV PB_HOME=/usr/share/packetbeat PB_CONF=/etc/packetbeat
RUN apt-get update && apt-get install -y --no-install-recommends \
	packetbeat

RUN apt-get purge -y gnupg2 wget ca-certificates && apt-get autoremove -y

COPY ./packetbeat.yml ${PB_CONF}/packetbeat.yml
RUN chmod go-w ${PB_CONF}/packetbeat.yml

COPY ./start.sh /usr/local/bin/start.sh
RUN chmod +x /usr/local/bin/start.sh

EXPOSE 5066

CMD /usr/local/bin/start.sh
