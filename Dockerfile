# Use the Keycloak base image
FROM quay.io/keycloak/keycloak:20.0.0

# Set environment variables
ENV KEYCLOAK_ADMIN=admin
ENV KEYCLOAK_ADMIN_PASSWORD=admin
ENV KC_HOSTNAME_STRICT_HTTPS="true"
ENV KC_HOSTNAME="key-cloak.app.cloud.cbh.kth.se"
ENV KC_PROXY="edge"
ENV KC_HOSTNAME_ADMIN_URL="https://key-cloak.app.cloud.cbh.kth.se"

# Create a directory for persistent data
RUN mkdir -p /opt/jboss/keycloak/standalone/data

# Expose port 8080
EXPOSE 8080

# Mount the persistent data directory as a volume
VOLUME ["/opt/jboss/keycloak/standalone/data"]

# The default command to run Keycloak
CMD ["start-dev"]
