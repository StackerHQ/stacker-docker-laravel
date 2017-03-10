FROM php:7-apache

RUN a2enmod rewrite

COPY rootfs/ /
WORKDIR /app
