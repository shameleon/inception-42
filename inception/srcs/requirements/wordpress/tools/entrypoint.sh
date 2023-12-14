#!/bin/bash

# wp is /usr/local/bin/wp (wp-cli.phar)

#######################################################
#       Install wordpress for our website             #
#######################################################
# Download wordpress files
wp core download --path=$WP_PATH --allow-root
chown -R www-data /var/www/html/wordpress
chmod -R 775 /var/www/
#######################################################
# Creates a new wp-config.php with database constants
# config create not working
# wp config create --path=$WP_PATH --allow-root --dbhost=$DB_HOST --dbname=$DB_DATABASE --dbprefix=$DB_TABLE_PREFIX --dbuser=$DB_USER --dbpass=$DB_PASSWORD
# wp config create --allow-root --dbhost=$DB_HOST --dbname=$DB_DATABASE --dbprefix=$DB_TABLE_PREFIX --dbuser=$DB_USER --dbpass=$DB_PASSWORD --path="."
# Error: Database connection error (1045) Access denied for user 'user'@'wordpress.inception-db' (using password: NO)
cd $WP_PATH && cp wp-config-sample.php wp-config.php

#######################################################
# Udate wp-config.php with environment variables
wp config set --allow-root DB_HOST $DB_HOST --path="."
wp config set --allow-root DB_NAME $DB_DATABASE --path="." 
wp config set --allow-root DB_USER $DB_USER --path="."
wp config set --allow-root DB_PASSWORD "${DB_USER_PASSWORD}" --path="."
wp config set --allow-root table_prefix $DB_TABLE_PREFIX --path="."
wp config set --allow-root WP_DEBUG true --path="." --raw
wp config set --allow-root WP_DEBUG_LOG true --path="." --raw
# [--raw] : Place the value into the wp-config.php file as is, instead of as a quoted string.
# Refreshes the salts defined in the wp-config.php file.
wp config shuffle-salts --allow-root
# print config
echo "wp-config.php file generated"
wp config list --allow-root


# https://developer.wordpress.org/cli/commands/core/install/
wp core install --allow-root \
    --path="." \
    --url=$DOMAIN_NAME \
    --title=$WP_TITLE \
    --admin_user=$WP_ADMIN \
    --admin_password=$WP_ADMIN_PASSWORD \
    --admin_email=$WP_ADMIN_EMAIL
# wp core install --allow-root --path=$WP_PATH --url=$DOMAIN_NAME --title=$WP_TITLE --admin_user=$WP_ADMIN --admin_password=$WP_ADMIN_PASSWORD --admin_email=$WP_ADMIN_EMAIL
wp plugin update --path="." --allow-root --all

# Create default user
wp user create --path=$WP_PATH --allow-root \
    $WP_USER $WP_USER_EMAIL --user_pass=$WP_USER_PASSWORD \
    --role=author

# create PID file (/run/php/php7.3-fpm.pid)
# mkdir -p /run/php
# /usr/sbin/php-fpm7.3 -F
php-fpm7.3 -F


# if [-z wp-config.php]
# then
    
# else
# fi