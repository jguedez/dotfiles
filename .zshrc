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

bindkey -v
bindkey "^R" history-incremental-search-backward

# http://www.thegeekstuff.com/2008/10/6-awesome-linux-cd-command-hacks-productivity-tip3-for-geeks/
# http://lifehacker.com/5535495/create-and-change-to-a-new-directory-in-one-command
# mkdir, cd into it
function mkcd () { mkdir -p "$*" && cd "$*"; }

#
# convenience command line aliases
alias server='python -m SimpleHTTPServer'
alias cd..="cd .."
alias cd...="cd ../.."
alias cd....="cd ../../.."
alias cd.....="cd ../../../.."
alias cd......="cd ../../../../.."
alias ll="ls -alh"
alias llg="ls -alh|grep"
alias fvimdel="find . -name \"*.swp\" -delete"
alias httpd="http --download"

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

# Vagrant aliases
alias vup="vagrant up"
alias vssh="vagrant ssh"
alias voff="vagrant ssh -c 'sudo poweroff'"

# Docker aliases
alias dima="docker images"
alias dpsa="docker ps -a"                                                                                                                                 ⏎
alias dps="docker ps"


# add percol support for zsh history search...
function exists { which $1 &> /dev/null }

if exists percol; then
    function percol_select_history() {
        local tac
        exists gtac && tac="gtac" || { exists tac && tac="tac" || { tac="tail -r" } }
        BUFFER=$(fc -l -n 1 | eval $tac | percol --query "$LBUFFER")
        CURSOR=$#BUFFER         # move cursor
        zle -R -c               # refresh
    }

    zle -N percol_select_history
    bindkey '^R' percol_select_history
fi

# source the local init file if available
if [[ -s $HOME/$LOCAL_FILE ]]; then
    source $HOME/$LOCAL_FILE
fi
