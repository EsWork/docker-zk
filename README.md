[![Build Status](https://travis-ci.org/EsWork/docker-zk.svg?branch=master)](https://travis-ci.org/EsWork/docker-zk) 

|Image Tag | Metadata from image |
|--------- | :------------ |
|[![](https://images.microbadger.com/badges/version/eswork/zk.svg)](https://microbadger.com/images/eswork/zk "Get your own version badge on microbadger.com")|[![](https://images.microbadger.com/badges/image/eswork/zk.svg)](https://microbadger.com/images/eswork/zk "Get your own image badge on microbadger.com")

## Supported tags and respective `Dockerfile` links

- [`latest` , `3.4.10` (3.4.10/Dockerfile)](https://github.com/EsWork/docker-zk/blob/master/Dockerfile)

* eswork/zk

Environment variables
---

- **SERVICE_USER** : user name *(default : zookeeper)*
- **SERVICE_GROUP** : group name *(default : zookeeper)*
- **SERVICE_UID** : user id *(default : 1000)*
- **SERVICE_GID** : group id *(default : 1000)*

- ZOO_MY_ID="0"
- ZK_DATA_DIR="/opt/zk/data"
- ZK_INIT_LIMIT="5"
- ZK_MAX_CLIENT_CXNS="500"
- ZK_SYNC_LIMIT="2"
- ZK_TICK_TIME="2000"
- ZK_SERVER="server.0=127.0.0.1:2888.3888"


Installation
---
```bash
docker pull eswork/zk
```

Quickstart
---

```bash
docker run --name zk -d \
-v /etc/localtime:/etc/localtime:ro \
-p 2181:2181 --restart=always \
eswork/zk
```