FROM quay.io/keycloak/keycloak:latest

# Set environment variables
ENV KEYCLOAK_ADMIN=admin
ENV KEYCLOAK_ADMIN_PASSWORD=admin

# Expose port 8080
EXPOSE 8089

# The default command to run Keycloak
CMD ["start-dev"]