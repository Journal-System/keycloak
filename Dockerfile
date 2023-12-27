# Use the Keycloak base image
FROM quay.io/keycloak/keycloak:22.0.5

# Set environment variables
ENV KEYCLOAK_ADMIN=admin
ENV KEYCLOAK_ADMIN_PASSWORD=admin
ENV KC_HOSTNAME_STRICT_HTTPS="true"
ENV KC_HOSTNAME="key-cloak.app.cloud.cbh.kth.se"
ENV KC_PROXY="edge"
ENV KC_HOSTNAME_ADMIN_URL="https://key-cloak.app.cloud.cbh.kth.se"

# Configure a database vendor
ENV KC_DB=mysql
ENV KC_DB_URL=jdbc:mysql://vm.cloud.cbh.kth.se:2776/Keycloak
ENV KC_DB_USERNAME=root
ENV KC_DB_PASSWORD=PASSWORD123

# Expose port 8080
EXPOSE 8080

# Specify the entry point script
ENTRYPOINT ["/opt/keycloak/bin/kc.sh"]

# The default command to run Keycloak
CMD ["start"]