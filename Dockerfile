FROM php:8.1-apache

# Install PHP extensions needed by Revive
RUN apt-get update && apt-get install -y \
    libjpeg-dev libpng-dev libfreetype6-dev libzip-dev unzip git curl mariadb-client \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install gd mysqli pdo pdo_mysql zip

# Enable Apache rewrite
RUN a2enmod rewrite

# Download Revive Adserver (change version as needed)
RUN curl -L https://download.revive-adserver.com/revive-adserver-5.5.1.zip -o revive.zip \
    && unzip revive.zip -d /var/www/html \
    && rm revive.zip

# Fix permissions
RUN chown -R www-data:www-data /var/www/html \
    && chmod -R 755 /var/www/html

EXPOSE 80
