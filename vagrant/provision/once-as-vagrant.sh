#!/usr/bin/env bash

source /y2cv/vagrant/provision/common.sh

#== Import script args ==

github_token=$(echo "$1")

#== Provision script ==

info "Provision-script user: `whoami`"

info "Adding GitHub to known hosts"
ssh-keyscan github.com > /home/vagrant/.ssh/known_hosts
echo "Done!"

info "Configure composer"
composer config --global github-oauth.github.com ${github_token}
echo "Done!"

info "Install project dependencies"
cd /yii2
composer --no-progress install

info "Install basic app"
php build/build dev/app basic --useHttp

info "Configure yii2 playground"
cp /y2cv/vagrant/yii2-local-configs/tests/data/config.local.php /yii2/tests/data/config.local.php
echo "Done!"

info "Configure linked basic app"
sed -i "s/'cookieValidationKey' => ''/'cookieValidationKey' => 'f8dcecf915c4ad7086ec198028969593'/g" /yii2/apps/basic/config/web.php
echo "Done!"

info "Automatic project dir opening after SSH login"
echo 'cd /yii2' | tee -a /home/vagrant/.bashrc

info "Enabling colorized prompt for guest console"
sed -i "s/#force_color_prompt=yes/force_color_prompt=yes/" /home/vagrant/.bashrc
echo "Done!"

info "Configure of rewriting .bash_history to directory /y2cv/vagrant/history"
rm -f /home/vagrant/.bash_history
touch /y2cv/vagrant/history/.bash_history
ln -s /y2cv/vagrant/history/.bash_history /home/vagrant/.bash_history
echo "Done!"

info "Configuring max size of .bash_history"
sed -i "s/HISTSIZE=1000/HISTSIZE=99999999/" /home/vagrant/.bashrc
sed -i "s/HISTFILESIZE=2000/HISTFILESIZE=99999999/" /home/vagrant/.bashrc
echo "Done!"
