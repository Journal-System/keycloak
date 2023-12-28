FROM registry.redhat.io/rhbk/keycloak-rhel9:latest as builder

# Enable health and metrics support
ENV KC_HEALTH_ENABLED=true
ENV KC_METRICS_ENABLED=true

# Configure a database vendor
ENV KC_DB=mysql

WORKDIR /opt/keycloak
# for demonstration purposes only, please make sure to use proper certificates in production instead
RUN keytool -genkeypair -storepass password -storetype PKCS12 -keyalg RSA -keysize 2048 -dname "CN=server" -alias server -ext "SAN:c=DNS:localhost,IP:127.0.0.1" -keystore conf/server.keystore
RUN /opt/keycloak/bin/kc.sh build

FROM registry.redhat.io/rhbk/keycloak-rhel9:latest
COPY --from=builder /opt/keycloak/ /opt/keycloak/

# change these values to point to a running postgres instance
ENV KC_DB=mysql
ENV KC_DB_URL=jdbc:mysql://vm.cloud.cbh.kth.se:2776/Keycloak
ENV KC_DB_USERNAME=root
ENV KC_DB_PASSWORD=PASSWORD123
ENV KC_HOSTNAME="key-cloak.app.cloud.cbh.kth.se"

ENTRYPOINT ["/opt/keycloak/bin/kc.sh"]

# The default command to run Keycloak
CMD ["start-dev"]