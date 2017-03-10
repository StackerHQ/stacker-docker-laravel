FROM php:7-apache

COPY rootfs/ /
WORKDIR /app
