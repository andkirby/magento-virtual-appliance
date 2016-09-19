# The Redbox Appliance

A Vagrant box for developing Magento websites.

## Changed by Kirby in andkirby/magento-virtual-appliance
Changes list:
- Added latest `git` installation
- Set source VM to `bento/centos-6.8`
- Set `PS1` colorization
- Minor customizations in `.bashrc`
- Added `redis` and `memcached`
- Added latest `nano` version (2.3, TBD due to errors in bash provistion file)

## Installation

The box can be found on [Atlas][atlas].

```
vagrant init redbox-digital/appliance
vagrant up
```

## What's Inside?

- CentOS 6.
- PHP 5.5, with everything needed to run Magento;
- Percona 5.6;
- Nginx, configured to run one Magento site;
- Vim, Git, Composer, N98-Magerun, Tmux and Jq;
- The Magento Project Mess Detector;
- NodeJS, NPM, Uglify, Bower, Grunt-CLI and Gulp;
- Compass;
- Fabric, for automating all the things.

The web root is configured to be `/var/www/magento/htdocs`, all requests
to port 80 are forwarded there. Of course, Magento validates the
`base_url`, so be sure to edit your hosts file to give it something
sensible.

[atlas]: https://atlas.hashicorp.com/redbox-digital/boxes/appliance

## Bugs
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
