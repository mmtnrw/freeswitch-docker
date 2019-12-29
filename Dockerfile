FROM alpine:latest

# set version label
ARG BUILD_DATE
ARG VERSION

RUN \
echo "**** Installing Packages ****" && \
apk add --no-cache nano freeswitch lua

RUN \
echo "**** Linking Config ****" &&\
rm -rf /etc/freeswitch && \
ln -s /config /etc/freeswitch

COPY root/ /root/
RUN chmod +x /root/start.sh

# ports and volumes
VOLUME /config

CMD ["/root/start.sh"]
