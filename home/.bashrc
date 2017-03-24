###########################
# General settings
###########################

# this makes it so you can do vi commands on the command line
#set -o vi


###########################
# General aliases
###########################

alias ll='ls -la'
alias ls='ls --color=always'
alias bedit='start ~/.bashrc'
alias bsource='source ~/.bashrc'
alias current='cd /c/home/docs/code/websites/pedroliska.com/MovieFinder/angular2'

alias sl='([[ ! -d "Source" ]] && start *.sln) || start Source/*.sln'
alias ds='cd ~/mine/dynamic/work/skullcandy/ordermanager/00-code'


###########################
# Git aliases
###########################

alias  gs='git status'
alias  gd='git diff'
alias  ga='git add --all .'
alias  gc='git commit -m'
alias gco='git checkout'
alias  gk='git fetch origin; git remote prune origin; gitk &'
alias gka='git fetch origin; git remote prune origin; gitk --all &'
alias  gp='git pull'
alias  gh='github'
alias grm='git fetch; git rebase origin/master'

alias td='cmd "/C /home/bin/tdiff.bat" &'
alias tc='cmd "/C /home/bin/tcommit.bat" &'


###########################
# bash functions
###########################

function findg(){
  if [ -z "$1" ]
  then
    echo "Find file and grep its contents"
    echo "Syntax:"
    echo " findg stringPattern fileNamePattern - find matching strings on matching files"
    echo " findg stringPattern                 - find matching strings in all regular files"
    echo "Notes:"
    echo " Both patterns are case insensitive"
    echo " The patters don't need to be wrapped in quotes. Wrap them only if there is a space, or escape the space with a backslash."
  else
    if [ -z "$2" ]
    then
      # we only have one argument
      find . -type f -print0 | xargs -0 grep -nsiI "$1"
    else
      find . -type f -iname "$2" -print0 | xargs -0 grep -nsiI "$1"
    fi
  fi
}

function symlink(){
  bake nuget:symlink[$1,$2]
}
function symlink35(){
  bake nuget:symlink35[$1,$2]
}

function github(){
  if [ -d .git ] || git rev-parse --git-dir > /dev/null 2>&1; then
    remote=$1

    if [ -z $remote ]
    then
      remote=origin
    fi
    url=$(git remote show $remote | grep "Fetch URL" | cut -c 14- | sed -r -e 's/\w+@/http:\/\//' -e '
    s/\.git$//' -e 's/\.com:/.com\//' -e 's/^\s*//')

    platform=$(uname)

    if [[ $platform == Cygwin* || $platform == MINGW* ]]; then
      opencmd=start
    elif [[ $platform == Darwin* ]]; then
      opencmd=open
    fi

    $opencmd $url
  else
    echo 'Not in a Git repository'
  fi
}

function ehclone(){
  if [ -z "$1" ]
  then
    echo "Missing git repository url ending"
    echo "usage: ehclone 'extendhealth git repository ending' ['target directory name']"
    return
  fi

  giturl="git@github.extendhealth.com:extend-health/$1.git"

  if [ -z "$2" ]
    then
      # we DON'T HAVE a target directory
      targetDir=$1
    else
      # we HAVE a target directory
      targetDir=$2
  fi
  git clone --template=C:/home/eh-git $giturl $targetDir
  cd $targetDir

  bundle install
}

function vim(){
  if [[ $# -eq 0 ]]; then
    gvim &
  else
    gvim --remote-tab-silent "$@" &
  fi
}

function ed() {
  "C:\Program Files\Sublime Text 3\sublime_text.exe" $1 &
}

function issuelesscommits() {
  if [ -z "$1" ]
  then
    echo "missing start date"
    echo "usage: issuelesscommits 'YYYY-MM-DD'"
    return
  fi
  git log --since $1 --pretty=oneline | grep -v '#'
}

function trace () {

  command="$@ 2>&1 | cut -c-1000 >> $logFile"
  echo $command

  logFile=trace.log  && \
  echo > $logFile  && \
  start $logFile  && \
  eval $command && \
  echo "----------- DONE -----------" >> $logFile

}

###########################
# change the ls directory color
LS_COLORS="di=01;36:"
export LS_COLORS

cd