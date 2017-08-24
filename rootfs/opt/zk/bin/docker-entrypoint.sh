#!/usr/bin/env bash
set -e

function log() {
  echo `date` $ME - $@
}

if [ "$1" = 'zkServer.sh' ]; then
log "[ Starting ${SERVICE_NAME}... ]"
${SERVICE_HOME}/bin/zoo.cfg.sh
chown -R ${SERVICE_USER}:${SERVICE_GROUP} ${SERVICE_HOME} ${ZK_DATA_DIR} ${ZK_DATA_LOG_DIR}
exec su-exec ${SERVICE_USER}:${SERVICE_GROUP} "$@"
fi

exec "$@"
