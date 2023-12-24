FROM quay.io/keycloak/keycloak:20.0.0

# Set environment variables
ENV KEYCLOAK_ADMIN=admin
ENV KEYCLOAK_ADMIN_PASSWORD=admin
ENV KC_HOSTNAME_STRICT_HTTPS="false"

# Expose port 8080
EXPOSE 8080

# The default command to run Keycloak
CMD ["start-dev"]