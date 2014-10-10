###########################
# General settings
###########################
set -o vi

###########################
# General aliases
###########################
alias bedit='start ~/.bashrc'
alias bsource='source ~/.bashrc && cd -'

alias bake='bundle exec rake'

alias ll='ls -la'
alias ls='ls --color=always'

alias sl='([[ ! -d "src" ]] && start *.sln) || start src/*.sln'
alias ss='startserver'
alias sd='start .'

alias bake='bundle exec rake'
alias fr='bake oeapp:run'
alias fw='bake mimosa_fastwatch'
alias bottle='bake bottles:prepare; start .\\Build\\Bottles\\debug'

alias runraven='start "src/packages/RavenDB.Server/tools/Raven.Server.exe"'
alias karmarun='node node_modules/karma/bin/karma start --browsers PhantomJS'
alias st='storyteller -p chrome'

alias notes='ed "C:\Users\pedli\Documents\00-mine\notes\notes.txt" &'
alias ripple='C\:/Ruby193/lib/ruby/gems/1.9.1/bundler/gems/build-support-5ef4b4bada10/lib/EHBuild/Ripple/buildsupport/ripple.exe'
alias codefolder='cd /c/code/'

alias role='whoami -groups -fo list | grep -i' 


###########################
# Git aliases
###########################
alias gs='git status'
alias gd='git diff'
alias ga='git add --all .'
alias gc='git commit -m'
alias gco='git checkout'
alias  gk='git fetch origin; git remote prune origin; gitk &'
alias gka='git fetch origin; git remote prune origin; gitk --all &'
alias gp='git pull'

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
# This line is needed by mimosa watch on the one-exchange project
CHROME_BIN=/c/Program\ Files\ \(x86\)/Google/Chrome/Application/chrome.exe
export CHROME_BIN

###########################
# change the ls directory color
LS_COLORS="di=01;36:"
export LS_COLORS

codefolder


###########################
# Temp stuff
###########################

function oeclean() {
  rm -rf 'c:\code\one-exchange\build'
  rm -rf 'c:\code\one-exchange\src\ExtendHealth.OneExchange\bin'
  rm -rf 'c:\code\one-exchange\src\ExtendHealth.OneExchange\fubu-content'
}

alias dwscenarios='oeclean bake compile:all scenarios bottles:prepare publishbottle'
alias dwoutscenarios='dwscenarios scenarios:remove'
alias publishbottle='cp /c/code/one-exchange/Build/Bottles/debug/ExtendHealth.OneExchange.StoryTeller.zip /c/code/one-exchange/src/ExtendHealth.OneExchange/fubu-content'
