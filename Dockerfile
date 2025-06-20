FROM php:8.1-apache

# Install PHP extensions + tools
RUN apt-get update && apt-get install -y \
    libjpeg-dev libpng-dev libfreetype6-dev libzip-dev unzip git curl \
    zip unzip git mariadb-client wget \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install gd mysqli pdo pdo_mysql zip \
    && a2enmod rewrite

# Install Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Clone Revive Adserver source code
RUN git clone --depth 1 --branch v5.5.2 https://github.com/revive-adserver/revive-adserver.git /var/www/html

# Install dependencies via Composer (for lib/vendor/autoload.php)
WORKDIR /var/www/html
RUN composer install --no-dev --optimize-autoloader

# Fix permissions
RUN chown -R www-data:www-data /var/www/html && chmod -R 755 /var/www/html

EXPOSE 80
