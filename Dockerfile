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

# ports and volumes
VOLUME /config

CMD ["/usr/bin/freeswitch", "-nc"]
