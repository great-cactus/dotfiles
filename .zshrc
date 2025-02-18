# Read the environment
. /usr/local/bin/import-env.sh ~/.env

# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt appendhistory autocd extendedglob nomatch correct no_beep
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

PROMPT="%F{#4e5f80}%n@${WIN_DEVICE}%f:%~
>>"

export PYTHONPATH="$HOME/pythonScripts/_modules:$PATH"
export PATH="$HOME/intelpython3/bin:$PATH"
# alias python='python3'

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
export PATH="$HOME/projects/vim/src:$PATH"

# Nas
alias mnt='sudo mount -t cifs -o "username=admin,uid=1000,gid=1000,iocharset=utf8" //172.21.14.71/Public /mnt/nas'
alias uGmnt='sudo mount -t cifs -o "username=admin,uid=1000,gid=1000,iocharset=utf8" //172.21.14.71/Microgravity_Experiment /mnt/uG'

# Cantera
alias cjob='nohup python cf_auto.py&'
alias fjob='nohup python free_auto.py&'
alias mjob='nohup python main.py&'

# git
alias gs='git status'
alias ga='() { git add $1 }'
alias gl='git log --oneline'
alias gc='git commit'
alias gpom='git push origin main'
alias gd='git diff'

# tmux
export PATH="/mnt/c/Windows/system32:$PATH"
export PATH="/mnt/c/Users/$WIN_USER/AppData/Local/Programs/Microsoft VS Code/bin:$PATH"
export PATH="/mnt/c/Users/$WIN_USER/AppData/Local/Microsoft/WindowsApps:$PATH"
export PATH="/usr/lib/wsl/lib:$PATH"
export PATH="/mnt/c/Windows:$PATH"
# export TERM=xterm-256color
if [ $SHLVL = 1 ]; then
    # Create sessions
    tmux new-session -d -s main
    tmux new-session -d -s Obsidian

    # Attach to main session
    tmux attach-session -t main
fi

# deno
export DENO_INSTALL="$HOME/.deno"
export PATH="$DENO_INSTALL/bin:$PATH"

# neovim
alias vi='nvim'

# node.js
export PATH="$HOME/.nodejs/bin:$PATH"

# cuda
export CUDA_PATH=/usr/local/cuda-12
export LD_LIBRARY_PATH=$CUDA_PATH/lib64:$LD_LIBRARY_PATH
export PATH=$CUDA_PATH/bin:$PATH

# Paraview
if [ -f /opt/paraview/bin/paraview ]; then
    export PATH=/opt/paraview/bin:$PATH
fi

# >>> juliaup initialize >>>

# !! Contents within this block are managed by juliaup !!

path=('/home/tnd/.juliaup/bin' $path)
export PATH

# <<< juliaup initialize <<<

# cargo
source $HOME/.cargo/env

# Plugins
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export EDITOR=nvim


[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
# __conda_setup="$('/home/tnd/intelpython3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
# if [ $? -eq 0 ]; then
#     eval "$__conda_setup"
# else
#     if [ -f "/home/tnd/intelpython3/etc/profile.d/conda.sh" ]; then
#         . "/home/tnd/intelpython3/etc/profile.d/conda.sh"
#     else
#         export PATH="/home/tnd/intelpython3/bin:$PATH"
#     fi
# fi
# unset __conda_setup
# <<< conda initialize <<<

