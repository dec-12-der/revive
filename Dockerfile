FROM php:8.1-apache

# Install PHP extensions and tools
RUN apt-get update && apt-get install -y \
    libjpeg-dev libpng-dev libfreetype6-dev libzip-dev unzip curl wget \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install gd mysqli pdo pdo_mysql zip \
    && a2enmod rewrite

# Use literal version name (without "v")
ENV REVIVE_VERSION=5.5.2

# Download and extract Revive from GitHub archive
RUN wget -q "https://github.com/revive-adserver/revive-adserver/archive/refs/tags/${REVIVE_VERSION}.zip" -O revive.zip \
    && unzip revive.zip -d /var/tmp \
    && mv /var/tmp/revive-adserver-${REVIVE_VERSION}/* /var/www/html/ \
    && rm -rf /var/tmp revive.zip

# Permissions
RUN chown -R www-data:www-data /var/www/html \
    && chmod -R 755 /var/www/html

EXPOSE 80
