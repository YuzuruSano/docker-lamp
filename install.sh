#!/bin/bash

docker-compose exec php-fpm composer create-project roots/bedrock src
echo -e '\033[32mbedrock is successfully installed.\033[m'

cp .env.example ./html/src/.env
source ./html/src/.env

docker-compose exec db mysql -uroot -proot -e "CREATE DATABASE IF NOT EXISTS \`database\` ;"
echo -e '\033[32mdatabase is successfully created.\033[m'

if ! $( wp core is-installed --allow-root --path=/var/www/html/src/web/wp ); then

	# install wordpress
	docker-compose exec php-fpm /bin/bash -c "
	cd /var/www/html/src/web/wp && \
	wp core install \
		--url=$WP_HOME \
		--title="$WP_TITLE" \
		--admin_user=$WP_USER \
		--admin_password=$WP_PASSWORD \
		--admin_email=$WP_EMAIL \
		--skip-email \
		--allow-root \
		--path=/var/www/html/src/web/wp"

	# enable all available plugins
	# wp plugin activate --all

fi

git clone git@github.com:YuzuruSano/wp_skelton.git
mv ./wp_skelton ./base_theme
rm -rf ./base_theme/.git*
mv ./base_theme ./html/src/web/app/themes

docker-compose exec php-fpm /bin/bash -c "
cd /var/www/html/src/web/wp && \
wp theme activate base_theme --allow-root"