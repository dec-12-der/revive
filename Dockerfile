FROM php:8.1-apache

RUN apt-get update && apt-get install -y \
    libjpeg-dev libpng-dev libfreetype6-dev libzip-dev unzip curl wget \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install gd mysqli pdo pdo_mysql zip \
    && a2enmod rewrite

ENV REVIVE_VERSION=v5.5.2
RUN wget -q "https://github.com/revive-adserver/revive-adserver/archive/refs/tags/${REVIVE_VERSION}.zip" -O revive.zip \
    && unzip revive.zip -d /var/tmp \
    && mv /var/tmp/revive-adserver-${REVIVE_VERSION}/* /var/www/html/ \
    && rm -rf /var/tmp revive.zip

RUN chown -R www-data:www-data /var/www/html && chmod -R 755 /var/www/html
EXPOSE 80
