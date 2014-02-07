LOCAL_FILE=".bashrc_local"

set -o vi
export EDITOR='vim'

alias server='python -m SimpleHTTPServer'

# http://www.thegeekstuff.com/2008/10/6-awesome-linux-cd-command-hacks-productivity-tip3-for-geeks/
# http://lifehacker.com/5535495/create-and-change-to-a-new-directory-in-one-command
# mkdir, cd into it
function mkcd () { mkdir -p "$*" && cd "$*"; }

# convenience command line aliases
alias cd..="cd .."
alias cd...="cd ../.."
alias cd....="cd ../../.."
alias cd.....="cd ../../../.."
alias cd......="cd ../../../../.."
alias ll="ls -alh"
alias llg="ls -alh|grep"
alias f="find ."
alias top="top -o cpu"
alias fvimdel="find . -name \"*.swp\" -delete"

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

# source the local init file if available
if [ -f $HOME/$LOCAL_FILE ]; then
    source $HOME/$LOCAL_FILE
fi
