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
    cd /var/www/

    # colorize console
    PS1="\[\033[01;37m\]\$? \$(if [[ \$? == 0 ]]; then echo \"\[\033[01;32m\]\342\234\223\"; else echo \"\[\033[01;31m\]\342\234\227\"; fi) $(if [[ ${EUID} == 0 ]]; then echo '\[\033[01;31m\]\h'; else echo '\[\033[0;32m\]\u'; fi)\[\033[0;33m\] \w\[\033[00m\] \$ "
fi

# Add global composer binaries to runtime path
export PATH="${ORIGINAL_PATH}:~/.composer/vendor/bin"

# Aliases
alias mfab="mage-fab.sh"

alias sync_time='sudo service ntpd stop && sudo ntpdate pool.ntp.org && sudo service ntpd start'
