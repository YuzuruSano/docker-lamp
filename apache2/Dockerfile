FROM httpd:latest

RUN mkdir -p /var/www/html
COPY ./my-httpd.conf /usr/local/apache2/conf/httpd.conf
COPY ./vhosts.conf /usr/local/apache2/conf/extra/httpd-vhosts.conf
COPY ./ssl.conf /usr/local/apache2/conf/extra/httpd-ssl.conf

# RUN a2ensite base.conf

# RUN ln -s /etc/apache2/mods-available/rewrite.load /etc/apache2/mods-enabled/rewrite.load
# RUN ln -s /etc/apache2/mods-available/vhost_alias.load /etc/apache2/mods-enabled