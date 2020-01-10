#!/bin/sh

echo "[info] Setting up User ID: ${PUID}"
echo "[info] Setting up Group ID: ${PGID}"
echo "[info] **** Warning: Don't forget to chown Files to the User... ***"

if [ ! "$(getent passwd ${PGID})" ]
then
addgroup --gid "$PGID" "mmtnrw"
GROUP="mmtnrw"
else
GROUP=$(getent group ${PGID}|cut -d: -f1)
fi

if [ ! "$(getent passwd ${PUID})" ]
then
adduser --gecos "" --ingroup "mmtnrw" --system --uid "$PUID" "$GROUP"
fi

RUN="s6-applyuidgid -u ${PUID} -g ${PGID}"
UMASK_SET=${UMASK_SET:-022}
umask "$UMASK_SET"

echo "[info] Setting up Timezone : $TZ"
ln -snf /usr/share/zoneinfo/$TZ /etc/localtime
echo $TZ > /etc/timezone

echo "[info] Syncing Time...."
ntpd -d -q -n -p time.cloudflare.com &> /dev/null

echo "Starting Freeswitch Daemon"
chown -R $PUID:$PGID /data
chown -R $PUID:$PGID /config
chown -R $PUID:$PGID /etc/freeswitch
chown -R $PUID:$PGID /var/lib/freeswitch
chown -R $PUID:$PGID /var/log/freeswitch
chown -R $PUID:$PGID /usr/share/freeswitch
touch /var/run/freeswitch/freeswitch.pid
chown $PUID:$PGID /var/run/freeswitch/freeswitch.pid
$RUN /usr/bin/freeswitch -nf
