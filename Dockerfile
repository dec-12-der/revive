FROM codions/revive-adserver:latest

# Expose necessary port
EXPOSE 80

# Optional: Copy customized config or plugins
COPY revive-config/ /var/www/html/var/

# Set file permissions
RUN chown -R www-data:www-data /var/www/html
