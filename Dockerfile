FROM php:8.1-apache

RUN apt-get update && apt-get install -y \
    libjpeg-dev libpng-dev libfreetype6-dev libzip-dev unzip git curl \
    libonig-dev zip unzip wget \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install gd mysqli pdo pdo_mysql zip \
    && a2enmod rewrite

COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

WORKDIR /var/www/html
RUN git clone --depth 1 --branch v5.5.2 https://github.com/revive-adserver/revive-adserver.git . \
  && composer install --no-dev --optimize-autoloader --no-interaction \
  && chown -R www-data:www-data /var/www/html && chmod -R 755 /var/www/html

EXPOSE 80
FROM php:8.1-apache

RUN apt-get update && apt-get install -y \
    libjpeg-dev libpng-dev libfreetype6-dev libzip-dev unzip git curl \
    libonig-dev zip unzip wget \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install gd mysqli pdo pdo_mysql zip \
    && a2enmod rewrite

COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

WORKDIR /var/www/html
RUN git clone --depth 1 --branch v5.5.2 https://github.com/revive-adserver/revive-adserver.git . \
  && composer install --no-dev --optimize-autoloader --no-interaction \
  && chown -R www-data:www-data /var/www/html && chmod -R 755 /var/www/html

EXPOSE 80
