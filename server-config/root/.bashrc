
## Custom

# init once
if [ -z "${BASHRC_INIT}" ]; then
    BASHRC_INIT=1
    readonly BASHRC_INIT

    ORIGINAL_PATH=${PATH}
    readonly ORIGINAL_PATH

    # colorize console
    PS1="\n\[\033[01;37m\]\$? "
    PS1=${PS1}"\$(if [[ \$? == 0 ]]; then echo \"\[\033[01;32m\]\342\234\223\"; else echo \"\[\033[01;31m\]\342\234\227\"; fi)"
    PS1=${PS1}" $(if [[ ${EUID} == 0 ]]; then echo '\[\033[01;31m\]\h'; else echo '\[\033[0;32m\]\u'; fi)"
    PS1=${PS1}" \[\033[00m\]\D{%T}\[\033[0;33m\] \w\[\033[00m\] \n\$ "
fi

alias sync_time='service ntpd stop && ntpdate pool.ntp.org && service ntpd start'

# Restart all services
alias res='service nginx restart && pkill -f php-fpm && service php-fpm start && service php70-php-fpm start && service redis restart && service memcached restart'

# Switch PHP versions
alias php_switch_55='ln -sf /usr/bin/php55 /usr/bin/php'
alias php_switch_70='ln -sf /usr/bin/php70 /usr/bin/php'
