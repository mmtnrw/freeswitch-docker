FROM alpine:latest

# set version label
ARG BUILD_DATE
ARG VERSION

RUN \
echo "**** Installing Packages ****" && \
apk add --no-cache nano freeswitch lua sqlite lua-sqlite

RUN \
echo "**** Linking Config ****" &&\
rm -rf /etc/freeswitch && \
ln -s /config /etc/freeswitch && \
rm -rf /var/lib/freeswitch && \
ln -s /data /var/lib/freeswitch


COPY root/ /root/
RUN chmod +x /root/start.sh

# ports and volumes
VOLUME /config /data

CMD ["/root/start.sh"]
