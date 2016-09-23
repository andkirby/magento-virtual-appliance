# The Redbox Appliance

A Vagrant box for developing Magento websites.<br>
It is based upon [`bento/centos-6.7`](https://atlas.hashicorp.com/bento/boxes/centos-6.7).

## Installation

The box can be found on [Atlas][atlas].

```
$ git clone https://github.com/andkirby/magento-virtual-appliance.git
$ cd magento-virtual-appliance
$ vagrant up
```

## What's Inside?

- CentOS 6.
- PHP 5.5, with everything needed to run Magento;
- PHP 7.0 (beta for Magento 2)
- Percona 5.6;
- Nginx, configured to run one Magento site;
- Vim, Git, Composer, N98-Magerun, Tmux and Jq;
- The Magento Project Mess Detector;
- NodeJS, NPM, Uglify, Bower, Grunt-CLI and Gulp;
- Compass;
- Fabric, for automating all the things. (Removed Magento Fabric, there are errors)

The web root is configured to be `/var/www/magento/htdocs`, all requests
to port 80 are forwarded there. Of course, Magento validates the
`base_url`, so be sure to edit your hosts file to give it something
sensible.

## Kirby's updates

### Commands list (aliases from `~/.bashrc`)
#### Make new Virtual host
`make_vhost new-host.cc` PHP 5.5 by default<br>
Or `make_vhost new-host-70.cc` for PHP 7.0 (just use ending `-70.cc`)<br>
Or direct command `sh ~/centos-scripts/make-host.sh new-host.cc`
<br>(recommended format `*.cc`)

#### Switch status of XDebug
`xd_swi`

See file `~/.xd_swi`

#### Restart all services (except MySQL)
`res`

Services:
- nginx
- php-fpm
- php70-php-fpm
- redis
- memcached

To restart MySQL use `sudo service mysql restart`.

#### Switch PHP versions in console
`php_switch_55` - PHP 5.5.x (latest, set by default)
`php_switch_70` - PHP 7.0.x (7.0.11)

#### Sync VM time
`sync_time`

### Release notes

#### v2.2.0 to v2.3.0
 - Removed Magento Fabric (there are errors)<br>
 source (https://github.com/redbox-digital/magento-fabric.git)
 - Mirrored some code from `.bashrc` for `root` user.
#### v2.0.0 to v2.2.x
 - Updated `nano` to v2.2.
 - Added `nano` colorization.
 - Added andkirby/centos-scripts-mage for quick making virtual hosts.<br>
 You may create new host `sh ~/centos-scripts/make-host.sh new-host.cc`
 - Console colorization
 - Added sync time services (alias `sync_time`)
 - Added missed `mbstring` PHP extension
 - Node 6.x will be installed instead old one
 - VM box updated to `bento/centos-6.7`
 - Added `redis` installation
 - Added `memcached` installation
 - Added PHP 7.0.x (7.0.11 at the moment)<br>
 To use project with PHP 7.0 just create virtual host with suffix "-70.cc"<br>
 PHP in console still is 5.5. <br>
 To switch to PHP 7.0 use alias `php_switch_70`<br>
 To switch to PHP 5.5 use alias `php_switch_55`<br>
 _Magento 2 Nginx configuration in BETA testing._

## Bugs / Problems
### Vagrant 1.8.5
Due to (this version issue)[http://stackoverflow.com/questions/39350227/cannot-make-vagrant-ssh-key-using-connection-in-base-initializing-authorized-ke] ((github issue)[https://github.com/mitchellh/vagrant/issues/7610]), there is a trick to avoid this problem.

So, change permissions manually for `~/.ssh/*` files (please note port `2222` is a default one, you may have different one):
```
$ ssh vagrant@127.0.0.1 -p 2222 -o PubkeyAuthentication=no 'chmod 600 ~/.ssh/*'
```
And run `up` command with "provision" for installation.
```
$ vagrant up --provision
```
### DNS
If you faced Internet connection troubles, please add new dns servers
```shell
$ sudo vi /etc/resolv.conf
```
New nameservers:
```
nameserver 8.8.8.8
nameserver 8.8.4.4
```
