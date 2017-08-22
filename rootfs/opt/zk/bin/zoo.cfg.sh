#!/usr/bin/env bash
set -e

ZK_MY_ID=${ZK_MY_ID:-0}
ZK_INIT_LIMIT=${ZK_INIT_LIMIT:-"5"}
ZK_MAX_CLIENT_CXNS=${ZK_MAX_CLIENT_CXNS:-"500"}
ZK_SYNC_LIMIT=${ZK_SYNC_LIMIT:-"2"}
ZK_TICK_TIME=${ZK_TICK_TIME:-"2000"}
ZK_SERVER=${ZK_SERVER:-"server.0=127.0.0.1:2888.3888"}

cat << EOF > ${SERVICE_CONF}
tickTime=${ZK_TICK_TIME}
initLimit=${ZK_INIT_LIMIT}
syncLimit=${ZK_SYNC_LIMIT}
dataDir=${ZK_DATA_DIR}
dataLogDir=${ZK_DATA_LOG_DIR}
maxClientCnxns=${ZK_MAX_CLIENT_CXNS}
clientPort=2181
autopurge.snapRetainCount=3
autopurge.purgeInterval=1
EOF

for server in $ZK_SERVERS; do
  echo "$server" >> "$SERVICE_CONF"
done

cat << EOF > ${SERVICE_HOME}/data/myid
${ZK_MY_ID}
EOF