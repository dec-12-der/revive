FROM ghcr.io/jitesoft/revive-adserver:latest

USER root

# Ensure Apache binds to 0.0.0.0 and has a ServerName to prevent warnings
RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf \
 && echo "Listen 0.0.0.0:80" > /etc/apache2/ports.conf \
 && chown -R www-data:www-data /var/www/html \
 && chmod -R 755 /var/www/html

USER www-data

EXPOSE 80

CMD ["apache2ctl", "-D", "FOREGROUND"]
