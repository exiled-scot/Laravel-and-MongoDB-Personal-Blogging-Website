# Dockerfile
FROM php:latest

# Install required packages
RUN apt-get update && apt-get install -y libonig-dev
# Set environment variables
ENV PKG_CONFIG_PATH=/usr/lib/pkgconfig
# Install PHP extensions
RUN docker-php-ext-install pdo mbstring
RUN apt-get update -y && apt-get install -y libmcrypt-dev

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
RUN docker-php-ext-install pdo mbstring

WORKDIR /app
COPY ./blog /app

RUN composer install

EXPOSE 8000
CMD php artisan serve --host=0.0.0.0 --port=8000
