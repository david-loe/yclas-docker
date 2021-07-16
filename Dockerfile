# syntax=docker/dockerfile:1
FROM php:7.3-apache
RUN apt-get update && apt-get install -y libmagickwand-dev --no-install-recommends && rm -rf /var/lib/apt/lists/*
RUN printf "\n" | pecl install imagick

# COPY src/ /var/www/html/
RUN apt-get update && apt-get install -y \
  unzip \
  wget \
  libzip-dev

RUN docker-php-ext-enable imagick
RUN docker-php-ext-install mysqli
RUN docker-php-ext-install soap
RUN docker-php-ext-install zip

RUN a2enmod rewrite
RUN cd /var/www/html/
RUN wget https://github.com/yclas/yclas/archive/refs/tags/4.3.0.zip
RUN unzip 4.3.0.zip && \
  mv yclas-4.3.0/* .
RUN chmod -R 777 .
