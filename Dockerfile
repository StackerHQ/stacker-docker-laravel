FROM php:apache

RUN apt-get update && apt-get install -y \
      git \
      libicu-dev \
      libpq-dev \
      libmcrypt-dev \
      libnotify-bin \
 && rm -r /var/lib/apt/lists/* \
 && docker-php-ext-configure pdo_mysql --with-pdo-mysql=mysqlnd \
 && docker-php-ext-install \
      intl \
      mbstring \
      mcrypt \
      pcntl \
      pdo_mysql \
      pdo_pgsql \
      pgsql \
      zip \
      opcache \
 && a2enmod rewrite

## TODO clear php build files
## TODO remove *-dev packages after build

# install composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Install nodejs
RUN curl -sL https://deb.nodesource.com/setup_6.x | bash - \
 && apt-get install -y nodejs \
 && npm update -g npm \
 && npm install -g gulp

COPY rootfs/ /
WORKDIR /app
