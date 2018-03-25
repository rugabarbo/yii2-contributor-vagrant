#!/usr/bin/env bash

source /y2cv/vagrant/provision/common.sh

#== Provision script ==

info "Provision-script user: `whoami`"

info "Restart web-stack"
service php7.1-fpm restart
service nginx restart
service mysql restart
service memcached restart
service postgresql restart
