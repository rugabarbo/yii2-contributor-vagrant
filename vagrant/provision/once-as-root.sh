#!/usr/bin/env bash

source /y2cv/vagrant/provision/common.sh

#== Import script args ==

timezone=$(echo "$1")

#== Provision script ==

info "Provision-script user: `whoami`"

export DEBIAN_FRONTEND=noninteractive

info "Configure timezone"
timedatectl set-timezone ${timezone} --no-ask-password
echo "Done!"

info "Prepare root password for MySQL"
debconf-set-selections <<< "mysql-community-server mysql-community-server/root-pass password root"
debconf-set-selections <<< "mysql-community-server mysql-community-server/re-root-pass password root"
echo "Done!"

info "Add PHP7.1 PPA"
add-apt-repository -y ppa:ondrej/php

info "Update OS software"
apt-get update
apt-get upgrade -y

info "Install additional software"
apt-get install -y \
nginx \
php7.1-fpm php7.1-cli \
mysql-server-5.7 memcached sqlite postgresql \
php7.1-mysql php-memcache php-memcached php7.1-sqlite php7.1-pgsql \
php7.1-curl php7.1-intl php7.1-mcrypt php7.1-gd php7.1-mbstring php7.1-xml \
php-xdebug \
unzip mc htop

info "Configure MySQL"
sed -i "s/.*bind-address.*/bind-address = 0.0.0.0/" /etc/mysql/mysql.conf.d/mysqld.cnf
mysql -uroot -proot <<< "CREATE USER 'root'@'%' IDENTIFIED BY 'root'"
mysql -uroot -proot <<< "GRANT ALL PRIVILEGES ON *.* TO 'root'@'%'"
mysql -uroot -proot <<< "FLUSH PRIVILEGES"
echo "Done!"

info "Configure PHP"
sed -i 's/display_errors = Off/display_errors = On/g' /etc/php/7.1/fpm/php.ini
echo "Done!"

info "Configure PHP-FPM"
sed -i 's/user = www-data/user = vagrant/g' /etc/php/7.1/fpm/pool.d/www.conf
sed -i 's/group = www-data/group = vagrant/g' /etc/php/7.1/fpm/pool.d/www.conf
sed -i 's/owner = www-data/owner = vagrant/g' /etc/php/7.1/fpm/pool.d/www.conf
echo "Done!"

info "Configure XDebug"
cat << EOF > /etc/php/7.1/mods-available/xdebug.ini
zend_extension=xdebug.so
xdebug.remote_enable=1
xdebug.remote_connect_back=1
xdebug.profiler_enable_trigger=1
xdebug.profiler_output_dir = "/y2cv/vagrant/xdebug-profiler-output"
xdebug.profiler_output_name = "cachegrind.out.%u"
xdebug.remote_host=192.168.206.1
EOF
echo "Done!"

info "Configure NGINX"
sed -i 's/user www-data/user vagrant/g' /etc/nginx/nginx.conf
echo "Done!"

info "Enabling site configuration"
ln -s /y2cv/vagrant/nginx/app.conf /etc/nginx/sites-enabled/app.conf
echo "Done!"

info "Initializing databases and users for MySQL"
mysql -uroot -proot <<< "CREATE DATABASE yii2_test"
mysql -uroot -proot <<< "CREATE USER 'yii2_test'@'%' IDENTIFIED BY 'yii2_test'"
mysql -uroot -proot <<< "GRANT ALL PRIVILEGES ON yii2_test.* TO 'yii2_test'@'%'"
mysql -uroot -proot <<< "FLUSH PRIVILEGES"
echo "Done!"

info "Initializing databases and users for PostgreSQL"
sudo -u postgres psql -c "CREATE USER yii2_test WITH PASSWORD 'yii2_test'"
sudo -u postgres psql -c "CREATE DATABASE yii2_test WITH OWNER 'yii2_test'"
echo "Done!"

info "Install composer"
curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer