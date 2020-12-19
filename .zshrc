# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt appendhistory autocd extendedglob nomatch correct
bindkey -v
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
# End of lines added by compinstall

autoload -U colors; colors

export LANGUAGE=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export LANG=ja_JP.UTF-8
export LC_CTYPE=UTF-8

PROMPT='%F{cyan}%n@%m%f:%~
>>'

export PYTHONPATH="$HOME/pythonScripts/_modules:$PATH"
export PYENV_ROOT="$HOME/.pyenv"
if [ -d "${PYENV_ROOT}" ]; then
  export PATH=${PYENV_ROOT}/bin:$PATH
  eval "$(pyenv init -)"
  eval "$(pyenv virtualenv-init -)"
fi

#This is pyenv version manager===================================
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
  eval "$(pyenv virtualenv-init -)"
fi
#===============================================================

#awesome
#export XDG_RUNTIME_DIR='/tmp/runtime-mesa'

#ls configuration
autoload -U compinit
compinit

export LSCOLORS=exfxcxdxbxegedabagacad
export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
alias ls="ls --color"
alias ll="ls -lrthG"
zstyle ':completion*' list-colors 'di=34' 'ln=35' 'so=32' 'ex=31' 'bd=46;34' 'cd=43;34'
#Syncronize 2 PC
alias py2sync="rsync -ahv --progress --exclude='*.png' --exclude='*.npy' /home/titania/pythonScripts 052:/work/A/ENa/ENa052/syncer/"
alias getpy="rsync -ahv --progress --exclude='*.png' --exclude='*.npy' 052:/work/A/ENa/ENa052/syncer/pythonScripts /home/titania/"
#Show resharped csv
alias shwc='(){ column -s, -t $1 | head }'

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

#export DISPLAY=:0.0
export DISPLAY=$(cat /etc/resolv.conf | grep nameserver | awk '{print $2}'):0.0
#export DISPLAY=DESKTOP-0F1RPLS:0.0
#export LIBGL_ALWAYS_INDIRECT=1
#export DISPLAY=localhost:0.0
