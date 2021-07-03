FROM alpine:latest

# set version label
ARG BUILD_DATE
ARG VERSION

RUN \
echo "**** Installing Packages ****" && \
apk add --no-cache nano freeswitch lua sqlite lua-sqlite tiff-tools util-linux s6 msmtp openssl

RUN \
echo "**** Linking Config ****" &&\
rm -rf /etc/freeswitch && \
ln -s /config /etc/freeswitch && \
rm -rf /var/lib/freeswitch && \
ln -s /data /var/lib/freeswitch && \
rm -rf /usr/share/freeswitch/sounds && \
ln -s /sounds /usr/share/freeswitch/sounds

ADD ./root/start.sh /start.sh
ADD ./etc/msmtprc /etc/msmtprc

RUN touch /etc/aliases

RUN chmod +x /start.sh

# ports and volumes
VOLUME /config /data /sounds

CMD ["/start.sh"]
