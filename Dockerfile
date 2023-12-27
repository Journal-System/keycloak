# Use the builder image to build with the necessary configurations
FROM quay.io/keycloak/keycloak:latest as builder

# Enable health and metrics support
ENV KC_HEALTH_ENABLED=true
ENV KC_METRICS_ENABLED=true
# Configure a database vendor
ENV KC_DB=mysql

WORKDIR /opt/keycloak

# Build the configuration
RUN /opt/keycloak/bin/kc.sh build --cache=ispn

# Final image
FROM quay.io/keycloak/keycloak:latest

# Copy the built artifacts from the builder stage
COPY --from=builder /opt/keycloak/ /opt/keycloak/

ENV KEYCLOAK_ADMIN=admin
ENV KEYCLOAK_ADMIN_PASSWORD=admin
ENV KC_HOSTNAME_STRICT_HTTPS="true"
ENV KC_PROXY="edge"
ENV KC_HOSTNAME_ADMIN_URL="https://key-cloak.app.cloud.cbh.kth.se"

ENV KC_DB=mysql
ENV KC_DB_URL=jdbc:mysql://vm.cloud.cbh.kth.se:2776/Keycloak
ENV KC_DB_USERNAME=root
ENV KC_DB_PASSWORD=PASSWORD123
ENV KC_HOSTNAME="key-cloak.app.cloud.cbh.kth.se"
ENV JAVA_OPTS_APPEND="-Dcom.redhat.fips=false"

# Expose port 8080
EXPOSE 8080

# Set the entry point to start Keycloak
ENTRYPOINT ["/opt/keycloak/bin/kc.sh"]

# The default command to run Keycloak
CMD ["start"]