#
# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Customize to your needs...
LOCAL_FILE=".zshrc_local"
export EDITOR='vim'

setopt HIST_IGNORE_SPACE

bindkey -v
bindkey "^R" history-incremental-search-backward

# http://www.thegeekstuff.com/2008/10/6-awesome-linux-cd-command-hacks-productivity-tip3-for-geeks/
# http://lifehacker.com/5535495/create-and-change-to-a-new-directory-in-one-command
# mkdir, cd into it
function mkcd () { mkdir -p "$*" && cd "$*"; }

#
# convenience command line aliases
alias server2='python -m SimpleHTTPServer'
alias server='python3 -m http.server'
alias cd..="cd .."
alias cd...="cd ../.."
alias cd....="cd ../../.."
alias cd.....="cd ../../../.."
alias cd......="cd ../../../../.."
alias ll="ls -alh"
alias llg="ls -alh|grep -i"
alias fvimdel="find . -name \"*.swp\" -delete"
alias httpd="http --download"
alias fzkill="ps aux | fzf | awk '{print \$2}' | xargs kill"

# tmux aliases
alias tmn="tmux display-message -t \$TMUX_PANE -F '#I:#W - command COMPLETED!'"

# Git aliases - http://www.catonmat.net/blog/git-aliases/
alias ga='git add'
alias gp='git push'
alias gl='git log'
alias gl3='git log -3'
alias gs='git status'
alias gd='git diff'
alias gdc='git diff --cached'
alias gm='git commit -m'
alias gma='git commit -am'
alias gb='git branch'
alias gc='git checkout'
alias gra='git remote add'
alias grr='git remote rm'
alias gpu='git pull'
alias gcl='git clone'
alias glogp='git log --pretty=format:"%h %s" --graph'
alias groot='cd $(git rev-parse --show-toplevel)'
alias fzga="git status | grep modified|tr -s ' '| cut -d' ' -f2|fzf -m|xargs git add"

# Vagrant aliases
alias vup="vagrant up"
alias vssh="vagrant ssh"
alias voff="vagrant ssh -c 'sudo poweroff'"

# Docker aliases
alias dima="docker images"
alias dpsa="docker ps -a"
alias dps="docker ps"
alias dremove-containers="docker rm -v \$(docker ps -q -a)"
alias dremove-images='docker rmi $(docker images --filter "dangling=true" -q --no-trunc)'

# misc aliases
alias ansible-local="ansible-playbook --connection=local -i 127.0.0.1,"

# add z - jump around...
# https://github.com/rupa/z
. $HOME/source/z/z.sh

# add direnv support
eval "$(direnv hook zsh)"

# auto display 'venv' for direnv activated virtual environments
# https://github.com/direnv/direnv/wiki/Python
show_virtual_env() {
  if [[ -n "$VIRTUAL_ENV" && -n "$DIRENV_DIR" ]]; then
    echo "(venv)"
  fi
}
PS1='$(show_virtual_env) '$PS1

# helper fn
function exists { which $1 &> /dev/null }

# FZF integration
# http://owen.cymru/fzf-ripgrep-navigate-with-bash-faster-than-ever-before/
if exists fzf; then
    # assumes usual homebrew dir
    FZF_DIR=(/home/linuxbrew/.linuxbrew/Cellar/fzf/*/shell)
    source $FZF_DIR/key-bindings.zsh
    source $FZF_DIR/completion.zsh
    bindkey -s "^p" 'vim \$(fzf)\n'

    if exists rg; then
        export FZF_DEFAULT_COMMAND='rg --files --no-ignore --follow -g "!{.direnv,.git,node_modules}/*" 2> /dev/null'
        # export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow -g "!{.git,node_modules}/*" 2> /dev/null'
        export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
    fi
fi

# invoke autocompletion
# http://docs.pyinvoke.org/en/1.2/invoke.html#shell-tab-completion
if exists invoke; then
    source ~/.invoke-completion.sh
fi

# add body function to keep headers in a table for sorting, etc (from Command line Kung Fu book)
# ps aux | body tail  # keep header and then last 10 lines
body() {
    IFS= read -r header
    printf "%s\n" "$header"
    "$@"
}

# source the local init file if available
if [[ -s $HOME/$LOCAL_FILE ]]; then
    source $HOME/$LOCAL_FILE
fi
