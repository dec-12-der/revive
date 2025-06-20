FROM ghcr.io/jitesoft/revive-adserver:latest

USER root
RUN chown -R www-data:www-data /var/www/html \
    && chmod -R 755 /var/www/html
USER www-data

EXPOSE 80
