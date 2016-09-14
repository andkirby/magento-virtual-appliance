# Source global definitions
if [ -f /etc/bashrc ]; then
  source /etc/bashrc
fi

# Add global composer binaries to runtime path
export PATH="~/.composer/vendor/bin:$PATH"

# Aliases
alias mfab="mage-fab.sh"

# console visualization
PS1="\[\033[01;37m\]\$? \$(if [[ \$? == 0 ]]; then echo \"\[\033[01;32m\]\342\234\223\"; else echo \"\[\033[01;31m\]\342\234\227\"; fi) $(if [[ ${EUID} == 0 ]]; then echo '\[\033[01;31m\]\h'; else echo '\[\033[01;32m\]\u@\h'; fi)\[\033[01;34m\] \w \$\[\033[00m\] "
