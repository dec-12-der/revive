FROM php:8.1-apache

# Install PHP extensions and tools
RUN apt-get update && apt-get install -y \
    libjpeg-dev libpng-dev libfreetype6-dev libzip-dev unzip git curl wget \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install gd mysqli pdo pdo_mysql zip \
    && a2enmod rewrite

# Clone Revive Adserver directly (shallow clone of v5.5.2)
RUN git clone --depth 1 --branch 5.5.2 https://github.com/revive-adserver/revive-adserver.git /var/www/html

# Set correct ownership and permissions
RUN chown -R www-data:www-data /var/www/html \
    && chmod -R 755 /var/www/html

EXPOSE 80
