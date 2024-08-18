FROM php:7.2-apache

RUN a2enmod rewrite

RUN [ "docker-php-ext-install", "pdo", "pdo_mysql", "mysqli", "mbstring" ]

RUN apt-get update \
     && apt-get install -y libzip-dev \
     && docker-php-ext-install zip
     
COPY html /var/www/html

RUN chmod -R 777 /var/www/html

VOLUME [ "/srv" ]