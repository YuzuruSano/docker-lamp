FROM php:7.4-fpm

ARG PUID=300
ARG PGID=300

# Setup Debian
RUN apt-get upgrade && apt-get update && ACCEPT_EULA=Y && apt-get install -y \
        unzip \
        libmcrypt-dev \
        libmemcached-dev \
        libzip-dev zip unzip \
        libgeoip-dev \
        libxml2-dev \
        libxslt-dev \
        libtidy-dev \
        libssl-dev \
        zlib1g-dev \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libpng-dev \
        libwebp-dev \
        libxpm-dev \
        libmagickwand-dev \
        libaio1 \
        apt-file \
        wget \
        vim \
        gnupg \
        gnupg2 \
        rsync \
        libonig-dev \
        libssl-dev \
        openssl \
        ssl-cert \
        iproute2 \
        jq \
        zip \
        git

# Install PECLs
RUN pecl install redis \
    && pecl install geoip-1.1.1 \
    && pecl install apcu \
    && pecl install memcached \
    && pecl install xdebug \
    && pecl install timezonedb \
    && pecl install imagick \
    && docker-php-ext-enable imagick \
    && docker-php-ext-install exif \
    && docker-php-ext-enable exif

RUN docker-php-ext-install -j$(nproc) calendar iconv bcmath xml gd mbstring pdo tidy gettext intl pdo pdo_mysql mysqli simplexml sockets tokenizer xml xsl xmlwriter zip opcache exif \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-configure zip \
    && docker-php-ext-enable redis geoip apcu memcached timezonedb

# Enable PHP error logging to stdout
RUN printf "log_errors = On \nerror_log = /dev/stderr\n" > /usr/local/etc/php/conf.d/php-logs.ini

COPY ./php.ini /usr/local/etc/php/
COPY ./php-fpm.conf /usr/local/etc/php-fpm.d/www.conf

# Set up php sendmail config
RUN curl --location --output /usr/local/bin/mhsendmail https://github.com/mailhog/mhsendmail/releases/download/v0.2.0/mhsendmail_linux_amd64 && \
    chmod +x /usr/local/bin/mhsendmail

RUN echo 'sendmail_path="/usr/local/bin/mhsendmail --smtp-addr=mailhog:1025 --from=no-reply@docker.dev"' > /usr/local/etc/php/conf.d/mailhog.ini

# composer
RUN curl -sS https://getcomposer.org/installer | php
RUN mv composer.phar /usr/local/bin/composer

# wpcli
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
RUN chmod +x wp-cli.phar
RUN mv wp-cli.phar /usr/local/bin/wp