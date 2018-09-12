###########################
# General settings
###########################

# this makes it so you can do vi commands on the command line
set -o vi


###########################
# General aliases
###########################

alias ll='ls -la'
alias ls='ls --color=always'
alias bedit='ed ~/.bashrc'
alias bsource='source ~/.bashrc'

alias dcurrent='cd /c/home/code/BizDev'
alias dcode='cd /c/home/code'
alias current='dcurrent'

alias  sl='([[ ! -d "Source" ]] && start *.sln) || start Source/*.sln'
alias sla='git pull &&  sl &&  gka'
alias  ds='cd ~/mine/dynamic/work/skullcandy/ordermanager/00-code'


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

function wclone() {
  repoUrl='https://tfs.1800contacts.com/tfs/defaultcollection/BizDev/_git/'
  repoUrl+=$1
  git clone $repoUrl
  cd $1
}

function kraken () {
	/c/Users/pliska/AppData/Local/gitkraken/app-4.0.2/gitkraken.exe -p $(pwd) &
}

# function sl() {
#   if [ -z "$1" ]
#   then
#     # we have no parameters
#     rootDir=''
#   else
#     # we have a directory parameter
#     rootDir=$1/
#   fi
#   sourceDir=$rootDir
#   sourceDir+="Source";
#   ([[ ! -d $sourceDir ]] && start $rootDir*.sln) || start $sourceDir/*.sln
# }

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

function gitweb(){
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

function github(){
  echo "executing GITWEB command"
  gitweb
}

function vim(){
  if [[ $# -eq 0 ]]; then
    gvim &
  else
    gvim --remote-tab-silent "$@" &
  fi
}

function ed() {
  #"C:\Program Files\Sublime Text 3\sublime_text.exe" $1 &
  "code" $1 &
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
# These lines is needed by mimosa watch on the one-exchange project
CHROME_BIN=/c/Program\ Files\ \(x86\)/Google/Chrome/Application/chrome.exe
export CHROME_BIN

###########################
# change the ls directory color
LS_COLORS=$LS_COLORS:'di=0;35:'
export LS_COLORS
# Blue = 34
# Green = 32
# Light Green = 1;32
# Cyan = 36
# Red = 31
# Purple = 35
# Brown = 33
# Yellow = 1;33
# Bold White = 1;37
# Light Grey = 0;37
# Black = 30
# Dark Grey= 1;30

###########################
# Update the Prompt Screen (remove MINGW64)
# by default it looked like this and i didn't like it: pliska@PLISKA-1700 MINGW64 ~
PS1='\[\033]0;$TITLEPREFIX:${PWD//[^[:ascii:]]/?}\007\]\n\[\033[32m\]\u@\h \[\033[35m\]\w\[\033[36m\]`__git_ps1`\[\033[0m\]\n$ '
export PS1

current;