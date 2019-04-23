FROM php:7.2-apache
MAINTAINER docker-web

RUN apt-get update \
    && apt-get -y install vim wget curl figlet git ssmtp mailutils lsb-release libicu-dev mysql-client libfreetype6-dev libjpeg62-turbo-dev libpng-dev jq cron rsyslog \
    && docker-php-ext-install pdo_mysql mysqli intl zip \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install -j$(nproc) gd \
    && docker-php-ext-install opcache
RUN ln -s /etc/apache2/mods-available/rewrite.load /etc/apache2/mods-enabled/rewrite.load
RUN ln -s /etc/apache2/mods-available/vhost_alias.load /etc/apache2/mods-enabled
RUN echo ServerName $HOSTNAME > /etc/apache2/conf-available/fqdn.conf && a2enconf fqdn
RUN pecl install xdebug
# root is the person who gets all mail for userids < 1000
RUN echo "root=ysano@oikaze.jp" >> /etc/ssmtp/ssmtp.conf

# Here is the gmail configuration (or change it to your private smtp server)
RUN echo "mailhub={smtp}" >> /etc/ssmtp/ssmtp.conf
RUN echo "AuthUser={mail_address}" >> /etc/ssmtp/ssmtp.conf
RUN echo "AuthPass={password}" >> /etc/ssmtp/ssmtp.conf

RUN echo "UseTLS=YES" >> /etc/ssmtp/ssmtp.conf
RUN echo "UseSTARTTLS=YES" >> /etc/ssmtp/ssmtp.conf

# RUN echo "Un message de test" | mail -s "sujet de test" size.nn.mod@gmail.com


# Set up php sendmail config
RUN echo "sendmail_path=sendmail -i -t" >> /usr/local/etc/php/conf.d/php-sendmail.ini

COPY ./base.conf /etc/apache2/sites-available/base.conf
RUN a2ensite base.conf

COPY ./php.ini /usr/local/etc/php/

# composer
RUN curl -sS https://getcomposer.org/installer | php
RUN mv composer.phar /usr/local/bin/composer

# wpcli
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
RUN chmod +x wp-cli.phar
RUN mv wp-cli.phar /usr/local/bin/wp

EXPOSE 80