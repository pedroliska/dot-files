###########################
# General aliases
###########################
alias bedit='start ~/.bashrc'
alias bsource='source ~/.bashrc && cd -'

alias bake='bundle exec rake'

alias ll='ls -la'
alias ls='ls --color=always'

alias bake='bundle exec rake'
alias sl='([[ ! -d "src" ]] && start *.sln) || start src/*.sln'
alias ss='startserver'
alias sd='start .'
alias bottle='bake bottles:prepare; start .\\Build\\Bottles\\debug'
alias clobber='touch clobber.log && start clobber.log && bake clobber default 2>&1 | cut -c-1000 > clobber.log && echo "----------- DONE -----------" >> clobber.log &'
alias runraven='start "src/packages/RavenDB.Server/tools/Raven.Server.exe"'
alias runkarma='node node_modules/karma/bin/karma start --single-run --browsers PhantomJS'
alias st='storyteller -p chrome'

alias notes='ed "C:\Users\pedli\Documents\00-mine\notes\notes.txt" &'
alias ripple='C\:/Ruby193/lib/ruby/gems/1.9.1/bundler/gems/build-support-5ef4b4bada10/lib/EHBuild/Ripple/buildsupport/ripple.exe'
alias codefolder='cd /c/code/'


alias role='whoami -groups -fo list | grep -i' 
alias cw='compass watch -c ../../ExtendHealth.Adminsuite/config.rb'


###########################
# Git aliases
###########################
alias gd='cmd "/C /home/bin/diff.bat" &'
alias gs='git status'
alias ga='git add --all .'
alias gc='git commit -m'
alias gco='git checkout'
alias gk='git fetch origin; git remote prune origin; gitk --all &'


###########################
# bash functions
###########################

function fu(){
  if [ -z "$1" ] || [ -z "$2" ]
  then
    echo "Missing parameter"
    echo "usage: fu 'file name pattern' 'string pattern'"
  fi
  find . -type f -name "$1" | xargs grep -nsiI "$2"
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




###########################
# change the ls directory color
LS_COLORS="di=01;36:"
export LS_COLORS

codefolder
