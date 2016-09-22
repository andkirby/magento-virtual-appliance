#! /usr/bin/env bash

yum -y update

# Add .bashrc for vagrant
cp /tmp/server-config/home/vagrant/.bashrc /home/vagrant/

# Install EPEL
# Currently we use this for installing pv, which displays progress bars
# on database imports.
yum install -y epel-release

# Install pv
yum install -y pv

# Install tree
yum install -y tree

# Install nano editor
# install nano 2.0
# yum install -y nano
# install nano 2.2. http://superuser.com/questions/383005/centos-nano-upgrading
#
rpm -ivh http://www.nano-editor.org/dist/v2.2/RPMS/nano-2.2.6-1.x86_64.rpm

# Install node 6.x
curl --silent --location https://rpm.nodesource.com/setup_6.x | bash -
yum install -y npm

# Install tmux
yum install -y tmux

# Install jq
yum install -y jq

# Node based tools
npm install -g inherits
npm install -g uglify-js bower grunt-cli gulp

# Synchronization time services
# There is the alias sync_time for fast syncing
yum install -y ntp ntpdate ntp-doc

# Add webtatic (more recent PHP)
# We use -U to update rather than install, so that this script can be
# run multiple times without incident.
rpm -U http://mirror.webtatic.com/yum/el6/latest.rpm

# PHP, and necessary extensions
yum install -y php55w-cli
yum install -y php55w-devel php55w-mcrypt php55w-gd php55w-pear php55w-soap
yum install -y php55w-dom php55w-pdo php55w-mysqlnd php55w-pecl-xdebug

yum -y install php55w-mbstring

# Basic PHP config
cp /tmp/server-config/etc/php.ini /etc/

# Xdebug config
cat /tmp/server-config/etc/php.d/xdebug.ini >> /etc/php.d/xdebug.ini

# PHP-FPM, and config
yum install -y php55w-fpm
cp -r /tmp/server-config/etc/php-fpm.conf /etc/
service php-fpm start

# Tell PHP-FPM to start on system start
chkconfig php-fpm on

# Installing percona, because it's better than MySQL
# It's not really better at dev load, but it's what we run on production
rpm -U http://www.percona.com/redir/downloads/percona-release/percona-release-0.0-1.x86_64.rpm
yum install -y Percona-Server-server-56
mysql_install_db
cp /tmp/server-config/etc/my.cnf /etc/
service mysql start

# Install Nginx.
# We add the Nginx yum repository, because the default version is 1.0.1
rpm -U http://nginx.org/packages/centos/6/noarch/RPMS/nginx-release-centos-6-0.el6.ngx.noarch.rpm
yum install -y nginx
rm -rf /etc/nginx/conf.d
cp -r /tmp/server-config/etc/nginx/ /etc/
service nginx start

# Tools for development
yum install -y vim-enhanced

# Redis
# Source: https://gist.github.com/nghuuphuoc/7801123
rpm -Uvh http://download.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm
rpm -Uvh http://rpms.famillecollet.com/enterprise/remi-release-6.rpm
yum -y --enablerepo=remi,remi-test install redis
# PHP redis
yum -y install php55w-pecl-redis

# Memcached
yum install -y memcached
yum -y install php55w-pecl-memcached

# NetCat
#sudo yum -y install nc.x86_64
#
# check memcached status
#    echo stats | nc 127.0.0.1 11211
# OR
#    netstat -tulpn | grep :11211

# Git
yum install http://opensource.wandisco.com/centos/6/git/x86_64/wandisco-git-release-6-1.noarch.rpm
yum install -y git

# Install GCC, etc.
wget http://people.centos.org/tru/devtools-1.1/devtools-1.1.repo -P /etc/yum.repos.d
yum install -y devtoolset-1.1
ln -s /opt/centos/devtoolset-1.1/root/usr/bin/* /usr/bin/

# Compass, through rubygems
yum install -y ruby ruby-devel rubygems
gem update --system
gem install compass

# Magerun
curl -o n98-magerun.phar \
  https://raw.githubusercontent.com/netz98/n98-magerun/1.96.0/n98-magerun.phar
chmod +x n98-magerun.phar
mv n98-magerun.phar /usr/local/bin/n98-magerun.phar

# Magerun modules
mkdir -p /usr/local/share/n98-magerun/modules/
git clone https://github.com/AOEPeople/mpmd.git \
  /usr/local/share/n98-magerun/modules/mpmd

# Composer
curl -sS https://getcomposer.org/installer | php
chmod +x composer.phar
mv composer.phar /usr/local/bin/composer
cp -r /tmp/server-config/home/vagrant/.composer /home/vagrant/
chown -R vagrant:vagrant /home/vagrant/.composer

# Fabric
yum install -y python python-devel
python /tmp/server-config/tmp/get-pip.py
pip install fabric

# Magento-Fabric
su -c "/usr/local/bin/composer global require rbd/magento-fabric dev-master" vagrant

# Add MageShell for magento installation from CLI
# Initialized parameters in file ~/.mageinstall/params.sh
# To reinit use command
#     $ mageshell install init
# To install use command (domain: mage.cc, dir: /var/www/mage.cc)
#     $ mageshell install -p mage.cc
su -c "/usr/local/bin/composer global require andkirby/mageinstall ^7.0@beta" vagrant

# centos-scripts
su -c "cd; git clone https://github.com/andkirby/centos-scripts-mage.git" vagrant

# Nano editor colorization
su -c "git clone https://github.com/scopatz/nanorc.git /home/vagrant/.nano && cat /home/vagrant/.nano/nanorc >> /home/vagrant/.nanorc" vagrant

# Add nginx user into vagrant group
usermod -G vagrant nginx

# Install man (manual)
yum install -y man
####### End

# User settings
cat /tmp/server-config/home/vagrant/.ssh/known_hosts >> \
  /home/vagrant/.ssh/known_hosts
chown vagrant:vagrant /home/vagrant/.ssh/known_hosts

mkdir -p /var/www/magento
chown -R vagrant:vagrant /var/www/magento

############## php 7.0.x ##############
# move old bin PHP
mv /usr/bin/php /usr/bin/php55
ln -sf /usr/bin/php /usr/bin/php55

yum install -y php70
yum install -y php70-php-devel php70-php-mcrypt php70-php-gd php70-php-pear php70-php-intl php70-php-soap
yum install -y php70-php-mbstring php70-php-xml php70-php-pdo php70-php-mysqlnd php70-php-pecl-zip php70-php-pecl-xdebug

#xdebug config
cat /tmp/server-config/etc/opt/remi/php70/php.d/15-xdebug.ini >> $(php70 -i | grep -oP '[^ ]+xdebug.ini')

# PHP7.1 PHP-FPM
yum install -y php70-php-fpm
cp -r /tmp/server-config/etc/opt/remi/php70/php-fpm.conf /etc/opt/remi/php70/
service php70-php-fpm start

# Tell PHP-FPM to start on system start
chkconfig php70-php-fpm on

yum -y install php70-php-pecl-redis
yum -y install php70-php-pecl-memcached

# Make things smaller
yum -y clean all

# Whiteout the swap partition to reduce box size
# Swap is disabled till reboot
readonly swapuuid=$(/sbin/blkid -o value -l -s UUID -t TYPE=swap)
readonly swappart=$(readlink -f /dev/disk/by-uuid/"$swapuuid")
/sbin/swapoff "$swappart"
dd if=/dev/zero of="$swappart" bs=1M || echo "dd exit code $? is suppressed"
/sbin/mkswap -U "$swapuuid" "$swappart"

dd if=/dev/zero of=/EMPTY bs=1M
rm -f /EMPTY
# Block until the empty file has been removed, otherwise, Packer
# will try to kill the box while the disk is still full and that's bad
sync

