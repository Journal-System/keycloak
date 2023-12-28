FROM quay.io/keycloak/keycloak:23.0.1 AS builder

ENV KC_DB=mysql
ENV KC_HEALTH_ENABLED=true

#JDBC-PING cluster setup
COPY ./cache-ispn-jdbc-ping.xml /opt/keycloak/conf/cache-ispn-jdbc-ping.xml
RUN /opt/keycloak/bin/kc.sh build --cache-config-file=cache-ispn-jdbc-ping.xml

FROM registry.access.redhat.com/ubi9/ubi:9.3-1361.1699548029@sha256:5dc85ec81a0d2cc5d19164f80b8d287b176483fd09a88426ca2f698bb2bd09de AS ubi-micro-build
RUN mkdir -p /mnt/rootfs
RUN dnf install --installroot /mnt/rootfs curl --releasever 9 --setopt install_weak_deps=false --nodocs -y; dnf --installroot /mnt/rootfs clean all

FROM quay.io/keycloak/keycloak:23.0.1
ENV KC_CACHE_CONFIG_FILE=cache-ispn-jdbc-ping.xml
COPY --from=ubi-micro-build /mnt/rootfs /
COPY --from=builder /opt/keycloak/lib/quarkus/ /opt/keycloak/lib/quarkus/
COPY --from=builder /opt/keycloak/conf/cache-ispn-jdbc-ping.xml /opt/keycloak/conf

WORKDIR /opt/keycloak

ENTRYPOINT ["/opt/keycloak/bin/kc.sh"]

# The default command to run Keycloak
CMD ["start-dev"]