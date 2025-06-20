FROM ghcr.io/jitesoft/revive-adserver:latest

USER root
RUN chown -R www-data:www-data /var/www/html \
    && chmod -R 755 /var/www/html
USER www-data
ENV APACHE_RUN_USER=www-data
ENV APACHE_RUN_GROUP=www-data
ENV APACHE_LOG_DIR=/var/log/apache2
ENV APACHE_PID_FILE=/var/run/apache2/apache2.pid
ENV APACHE_LOCK_DIR=/var/lock/apache2
ENV APACHE_RUN_DIR=/var/run/apache2
ENV APACHE_SERVER_NAME=localhost
ENV APACHE_LISTEN_PORT=80

# Explicitly bind to all interfaces
RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf && \
    echo "Listen 0.0.0.0:80" > /etc/apache2/ports.conf

EXPOSE 80
