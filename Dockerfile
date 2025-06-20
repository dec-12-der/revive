FROM ghcr.io/jitesoft/revive-adserver:latest

# Optional: Copy domain-specific config or plugins
COPY revive-config/ /var/www/html/var/

USER root
RUN chown -R www-data:www-data /var/www/html \
    && chmod -R 755 /var/www/html
USER www-data

EXPOSE 80
