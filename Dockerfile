FROM stackerhq/base:latest

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update
RUN apt-get install -y software-properties-common

RUN add-apt-repository -y ppa:nginx/development
RUN add-apt-repository -y ppa:ondrej/php
RUN apt-get update

RUN apt-get install -y --allow-unauthenticated nginx

RUN curl -sL https://deb.nodesource.com/setup_6.x | bash -
RUN apt-get install -y nodejs
RUN npm install -g gulp

RUN apt-get install -y --allow-unauthenticated php7.1-fpm php7.1-cli php7.1-dev \
  php7.1-pgsql php7.1-sqlite3 php7.1-gd \
  php7.1-curl php7.1-memcached \
  php7.1-imap php7.1-mysql php7.1-mbstring \
  php7.1-xml php7.1-zip php7.1-bcmath php7.1-soap \
  php7.1-intl php7.1-readline php7.1-mcrypt

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

COPY rootfs/ /
WORKDIR /root

ENTRYPOINT ["/app-entrypoint.sh"]
CMD ["zsh"]
