FROM php:8.1-apache

# Install PHP + libraries
RUN apt-get update && apt-get install -y \
    libjpeg-dev libpng-dev libfreetype6-dev libzip-dev unzip curl \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install gd mysqli pdo pdo_mysql zip

# Enable Apache rewrite
RUN a2enmod rewrite

# Download and unpack Revive Adserver v5.5.2
ENV REVIVE_VERSION=5.5.2
RUN curl -fSL "https://download.revive-adserver.com/revive-adserver-${REVIVE_VERSION}.zip" -o revive.zip \
    && unzip revive.zip -d /var/www/html \
    && rm revive.zip

# Fix permissions
RUN chown -R www-data:www-data /var/www/html \
    && chmod -R 755 /var/www/html

EXPOSE 80
