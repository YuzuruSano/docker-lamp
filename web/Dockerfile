FROM php:7.1-apache
MAINTAINER docker-web

RUN apt-get update \
    && apt-get -y install vim wget curl figlet git ssmtp mailutils lsb-release libicu-dev mysql-client libfreetype6-dev libjpeg62-turbo-dev libpng-dev \
    && docker-php-ext-install pdo_mysql mysqli intl gd
RUN ln -s /etc/apache2/mods-available/rewrite.load /etc/apache2/mods-enabled/rewrite.load
RUN ln -s /etc/apache2/mods-available/vhost_alias.load /etc/apache2/mods-enabled
RUN echo ServerName $HOSTNAME > /etc/apache2/conf-available/fqdn.conf && a2enconf fqdn

# root is the person who gets all mail for userids < 1000
RUN echo "root={root mail address}" >> /etc/ssmtp/ssmtp.conf

# Here is the gmail configuration (or change it to your private smtp server)
RUN echo "mailhub={smtpserver&setport}" >> /etc/ssmtp/ssmtp.conf
RUN echo "AuthUser={user}" >> /etc/ssmtp/ssmtp.conf
RUN echo "AuthPass={pass}" >> /etc/ssmtp/ssmtp.conf

RUN echo "UseTLS=YES" >> /etc/ssmtp/ssmtp.conf
RUN echo "UseSTARTTLS=YES" >> /etc/ssmtp/ssmtp.conf


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