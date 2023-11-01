FROM php:8.2-fpm

# Install dependencies
RUN apt-get update \
    && apt-get install -y \
       libzip-dev \
       zlib1g-dev \
       libicu-dev \
       g++ \
       git \
       unzip \
       libonig-dev \
       libpng-dev \
       mariadb-client \
       libmagickwand-dev \
       vim 

# Clear cache
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# Install extensions
RUN docker-php-ext-install pdo_mysql mysqli mbstring zip exif pcntl
RUN pecl install imagick && docker-php-ext-enable imagick
RUN docker-php-ext-configure intl

COPY ./php.ini /usr/local/etc/php/

# Get latest Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Set up php sendmail config
RUN curl --location --output /usr/local/bin/mhsendmail https://github.com/mailhog/mhsendmail/releases/download/v0.2.0/mhsendmail_linux_amd64 && \
    chmod +x /usr/local/bin/mhsendmail

RUN echo 'sendmail_path="/usr/local/bin/mhsendmail --smtp-addr=mailhog:1025 --from=no-reply@docker.dev"' > /usr/local/etc/php/conf.d/mailhog.ini

# wpcli
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
RUN chmod +x wp-cli.phar
RUN mv wp-cli.phar /usr/local/bin/wp

# Configure volume working directory
WORKDIR /var/www/html
