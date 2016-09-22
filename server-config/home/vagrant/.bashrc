# Source global definitions
if [ -f /etc/bashrc ]; then
  source /etc/bashrc
fi

# init once
if [ -z "${BASHRC_INIT}" ]; then
    BASHRC_INIT=1
    readonly BASHRC_INIT

    ORIGINAL_PATH=${PATH}
    readonly ORIGINAL_PATH

    # go to docroot by default
    [ -d /var/www/ ] && cd /var/www/

    # colorize console
    PS1="\n\[\033[01;37m\]\$? "
    PS1=${PS1}"\$(if [[ \$? == 0 ]]; then echo \"\[\033[01;32m\]\342\234\223\"; else echo \"\[\033[01;31m\]\342\234\227\"; fi)"
    PS1=${PS1}" $(if [[ ${EUID} == 0 ]]; then echo '\[\033[01;31m\]\h'; else echo '\[\033[0;32m\]\u'; fi)"
    PS1=${PS1}" \[\033[00m\]\D{%T}\[\033[0;33m\] \w\[\033[00m\] \n\$ "
fi

# Add global composer binaries to runtime path
export PATH="${ORIGINAL_PATH}:~/.composer/vendor/bin"

# Aliases
alias mfab="mage-fab.sh"

alias sync_time='sudo service ntpd stop && sudo ntpdate pool.ntp.org && sudo service ntpd start'

# Restart all services
alias res='sudo service nginx restart && sudo pkill -f php-fpm && sudo service php-fpm start && sudo service php70-php-fpm start && sudo service redis restart && sudo service memcached restart'

alias php_switch_55='sudo ln -sf /usr/bin/php55 /usr/bin/php'
alias php_switch_70='sudo ln -sf /usr/bin/php70 /usr/bin/php'
