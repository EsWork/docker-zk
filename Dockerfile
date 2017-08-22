FROM openjdk:8-jre-alpine

ENV SERVICE_HOME=/opt/zk \
    SERVICE_CONF=/opt/zk/conf/zoo.cfg \
    SERVICE_NAME=zookeeper \
    SERVICE_USER=zookeeper \
    SERVICE_GROUP=zookeeper \
    SERVICE_UID=1000 \
    SERVICE_GID=1000 
ENV ZK_DATA_DIR=${SERVICE_HOME}/data \
    ZK_DATA_LOG_DIR=${SERVICE_HOME}/logs \
    PATH=${SERVICE_HOME}/bin:${PATH}

ARG DISTRO_NAME=zookeeper-3.4.10

LABEL description="zookeeper built from source" \
      zookeeper="zookeeper ${SERVICE_VERSION}" \
      maintainer="JohnWu <v.la@live.cn>"

#china mirrors repos
RUN echo "https://mirrors.ustc.edu.cn/alpine/latest-stable/main" > /etc/apk/repositories \
&&  echo "https://mirrors.ustc.edu.cn/alpine/latest-stable/community" >> /etc/apk/repositories

RUN mkdir -p "${ZK_DATA_DIR}" "${ZK_DATA_LOG_DIR}" \
&& cd /tmp \
&& apk -U upgrade && apk add --update --no-cache bash su-exec curl \
&& apk add --no-cache --virtual .build-deps gnupg \
&& curl -sSLO "https://dist.apache.org/repos/dist/release/zookeeper/${DISTRO_NAME}/${DISTRO_NAME}.tar.gz" \
&& curl -sSLO https://dist.apache.org/repos/dist/release/zookeeper/${DISTRO_NAME}/${DISTRO_NAME}.tar.gz.asc \
&& curl -sSL  https://dist.apache.org/repos/dist/release/zookeeper/KEYS | gpg -v --import - \
&& gpg -v --verify ${DISTRO_NAME}.tar.gz.asc \
&& tar -zx -C ${SERVICE_HOME} --strip-components=1 --no-same-owner -f ${DISTRO_NAME}.tar.gz \
&& apk del .build-deps \
&& rm -rf \
      /tmp/* \
      /root/.gnupg \
      /var/cache/apk/* \
      ${SERVICE_HOME}/contrib/fatjar \
      ${SERVICE_HOME}/dist-maven \
      ${SERVICE_HOME}/docs \
      ${SERVICE_HOME}/src \
      ${SERVICE_HOME}/bin/*.cmd \
&& addgroup -g ${SERVICE_GID} ${SERVICE_GROUP} \
&& adduser -g "${SERVICE_NAME} user" -D -h ${SERVICE_HOME} -G ${SERVICE_GROUP} -s /sbin/nologin -u ${SERVICE_UID} ${SERVICE_USER}

ADD rootfs /
RUN chmod +x ${SERVICE_HOME}/bin/*.sh \
  && chown -R ${SERVICE_USER}:${SERVICE_GROUP} ${SERVICE_HOME} ${ZK_DATA_DIR} ${ZK_DATA_LOG_DIR}

WORKDIR $SERVICE_HOME

EXPOSE 2181 2888 3888

ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["zkServer.sh", "start-foreground"]