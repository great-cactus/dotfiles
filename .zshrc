# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt appendhistory autocd extendedglob nomatch correct
bindkey -v
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
# End of lines added by compinstall
export PATH="$HOME/.local/bin:$PATH"

autoload -U colors; colors

export LANGUAGE=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export LANG=ja_JP.UTF-8
export LC_CTYPE=UTF-8

PROMPT='%F{#4e5f80}%n@DELL%f:%~
>>'

export PYTHONPATH="$HOME/work/pythonScripts/_modules:$PATH"

#ls configuration
autoload -U compinit
compinit

export LSCOLORS=exfxcxdxbxegedabagacad
export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
alias ls="ls --color"
alias ll="ls -lrthG"
zstyle ':completion*' list-colors 'di=34' 'ln=35' 'so=32' 'ex=31' 'bd=46;34' 'cd=43;34'
# Rsync settings
alias spsync='(){ rsync -ahvm --progress --include="*/" --include=$1 --exclude="*" $2 $3 }'
alias mysync='() { rsync -ahv --progress $1 $2 }'
# Oneapi
alias Act1AIP="source /opt/intel/oneapi/setvars.sh"

# vim
alias vi='vim'

# open command like Mac
alias open='xdg-open'

# Cantera
alias cjob='nohup python cf_auto.py&'

# Open mendeley
export PATH=$PATH:/home/sparrowhawk/Apps
alias ramen='mendeley-reference-manager-2.84.0-x86_64.AppImage'
