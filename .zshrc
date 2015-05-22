#------------------------------------------
# Options
#------------------------------------------

# why would you type 'cd dir' if you could just type 'dir'?
setopt AUTO_CD

# If I type cd and then cd again, only save the last one
setopt HIST_IGNORE_DUPS

set -o emacs

zmodload zsh/complist
autoload -U compinit && compinit
autoload -U zmv

#------------------------------------------
# Autocompletion
#------------------------------------------
zstyle ':completion:::::' completer _complete _approximate
zstyle ':completion:*' menu select

zstyle ':completion::complete:*' use-cache 1
zstyle ':completion:*' verbose yes

# allow approximate
zstyle ':completion:*' completer _complete _match _approximate
zstyle ':completion:*:match:*' original only
zstyle ':completion:*:approximate:*' max-errors 1 numeric

# colorizer auto-completion for kill
zstyle ':completion:*:*:kill:*:processes' list-colors "=(#b) #([0-9]#)*=36=31"

# case insensitive completion
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

zstyle ':completion:*' verbose yes
zstyle ':completion:*:descriptions' format '%B%d%b'
zstyle ':completion:*:messages' format '%d'
zstyle ':completion:*:warnings' format 'No matches for: %d'
zstyle ':completion:*' group-name ''
#zstyle ':completion:*' completer _oldlist _expand _force_rehash _complete
zstyle ':completion:*' completer _expand _force_rehash _complete _approximate _ignored

# generate descriptions with magic.
zstyle ':completion:*' auto-description 'specify: %d'

# Don't prompt for a huge list, page it!
zstyle ':completion:*:default' list-prompt '%S%M matches%s'

# Don't prompt for a huge list, menu it!
zstyle ':completion:*:default' menu 'select=0'

# Have the newer files last so I see them first
zstyle ':completion:*' file-sort modification reverse

# color code completion!!!!  Wohoo!
zstyle ':completion:*' list-colors "=(#b) #([0-9]#)*=36=31"
# foo
#------------------------------------------
# Colors
#------------------------------------------
# set colors to make terminal pretty!
autoload colors; colors
export CLICOLOR=1

export LS_OPTIONS='--color=auto'
export LSCOLORS=Exfxcxdxbxegedabagacad

PROMPT='%{$fg[cyan]%}[%n@%m]%{$reset_color%}$(git_super_status) %{$fg[cyan]%}~%{$reset_color%} '
RPROMPT="[%{$fg[yellow]%}%3c%{$reset_color%}][%{$fg[red]%}%?%{$reset_color%}]" # prompt for right side of screen

export USERWM=`which xmonad`
export GREP_OPTIONS='--color=auto'
export GROOVY_HOME='/usr/local/opt/groovy/libexe'
export PATH=/Library/TeX/Root/bin/x86_64-darwin:/Users/ltomlin/bin:/Users/ltomlin/.cabal/bin:$PATH
export PATH=/Users/ltomlin/opt/android-sdk-macosx/platform-tools/:$PATH
export PALANTIR_HOME=/Users/ltomlin/opt/Mac_QS_3.12.4.2/dist

#------------------------------------------
# Key Bindings
#------------------------------------------
bindkey '\e[3~' delete-char
bindkey '\e[1~' beginning-of-line
bindkey '\e[4~' end-of-line
bindkey '^?' backward-delete-char
bindkey '^[[1~' beginning-of-line
bindkey '^[[5~' up-line-or-history
bindkey '^[[3~' delete-char
bindkey '^[[4~' end-of-line
bindkey '^[[6~' down-line-or-history
bindkey '^[[A' up-line-or-search
bindkey '^[[D' backward-char
bindkey '^[[B' down-line-or-search
bindkey '^[[C' forward-char
bindkey "^R" history-incremental-search-backward

setopt no_list_beep

# directory in titlebar
chpwd() {
  [[ -t 1 ]] || return
  case $TERM in
    sun-cmd) print -Pn "\e]l%~\e\\"
      ;;
    *xterm*|rxvt|(dt|k|E)term) print -Pn "\e]2;%~\a"
      ;;
  esac
}

# call chpwd when first loaded
chpwd

extract () {
  if [ -f $1 ] ; then
      case $1 in
          *.tar.bz2)   tar xvjf $1    ;;
          *.tar.gz)    tar xvzf $1    ;;
          *.bz2)       bunzip2 $1     ;;
          *.rar)       unrar x $1     ;;
          *.gz)        gunzip $1      ;;
          *.tar)       tar xvf $1     ;;
          *.tbz2)      tar xvjf $1    ;;
          *.tgz)       tar xvzf $1    ;;
          *.txz)       tar Jxvf $1    ;;
          *.zip)       unzip $1       ;;
          *.Z)         uncompress $1  ;;
          *.7z)        7z x $1        ;;
          *)           echo "don't know how to extract '$1'..." ;;
      esac
  else
      echo "'$1' is not a valid file!"
  fi
}


###


 #	ALIASES 	###

alias la='ls -la'
alias psx="ps aux | grep -i"
alias reload="source ~/.zshrc"
alias hlog='git log --date-order --all --graph --format="%C(green)%h %Creset%C(yellow)%an%Creset %C(blue bold)%ar%Creset %C(red bold)%d%Creset %s"'
alias squid='launchctl load /usr/local/opt/squid/*.plist'
alias wear='adb -d forward tcp:5601 tcp:5601'

# Typos
alias cd..="cd .."
alias dl="curl -L -O"

# Todo list
alias t="~/.todo.sh"
alias h="/Users/ltomlin/Documents/Haskell/hoodoo/src/run"
alias gogit="cd /Volumes/git"

alias gw="./gradlew"

# Mac OS X (my home system) specific things

if [[ "$OSTYPE" == "darwin12.0" ]]; then
   alias preview="/Applications/Preview.app/Contents/MacOS/Preview"
   alias flushdns="dscacheutil -flushcache"
   alias lock="/System/Library/Frameworks/ScreenSaver.framework/Resources/ScreenSaverEngine.app/Contents/MacOS/ScreenSaverEngine"
   alias vim="mvim -v"
else
   PROMPT="%{$fg[yellow]%}[%n@%m] % ~%{$reset_color%} "    # Make the prompt yellow if i'm not on my home system
fi

# unregister broken GHC packages. Run this a few times to resolve dependency rot in installed packages.
# ghc-pkg-clean -f cabal/dev/packages*.conf also works.
function ghc-pkg-clean() {
  for p in `ghc-pkg check $* 2>&1 | grep problems | awk '{print $6}' | sed -e 's/:$//'`
  do
    echo unregistering $p; ghc-pkg $* unregister $p
  done
}

# remove all installed GHC/cabal packages, leaving ~/.cabal binaries and docs in place.
# When all else fails, use this to get out of dependency hell and start over.
function ghc-pkg-reset() {
  if [[ $(readlink -f /proc/$$/exe) =~ zsh ]]; then
    read 'ans?Erasing all your user ghc and cabal packages - are you sure (y/N)? '
  else # assume bash/bash compatible otherwise
    read -p 'Erasing all your user ghc and cabal packages - are you sure (y/N)? ' ans
  fi

  [[ x$ans =~ "xy" ]] && ( \
    echo 'erasing directories under ~/.ghc'; command rm -rf `find ~/.ghc/* -maxdepth 1 -type d`; \
    echo 'erasing ~/.cabal/lib'; command rm -rf ~/.cabal/lib; \
  )
}

export JAVA_HOME=$(/usr/libexec/java_home -v '1.7*')
java6() {
    JAVA_HOME=`/usr/libexec/java_home -v '1.6*'` "$@"
}
java7() {
    JAVA_HOME=`/usr/libexec/java_home -v '1.7*'` "$@"
}
java8() {
    JAVA_HOME=`/usr/libexec/java_home -v '1.8*'` "$@"
}
ntfy() {
    local msg=""
    "$@"
    if [[ $? == 0 ]] ; then
        msg="Run completed ☺"
    else
        msg="Run failed ☹"
    fi
    terminal-notifier -message "$msg" -title "`basename \`pwd\``~ $*"
}

export SPARK_HOME=/opt/Spark/spark-0.9.0-incubating/
alias puffin="tmuxifier load-window puffin"
alias pydis="/Volumes/git/pydi/pydis"
alias sparkshell=/opt/Spark/spark-0.9.0-incubating//bin/spark-shell
export PATH=/usr/local/sbin:$HOME/.tmuxifier/bin:$PATH
eval "$(tmuxifier init -)"
alias gst="git status"
alias gcm="git commit -m"
export EDITOR=vim
alias zeus="ssh -R 1111:localhost:8080 il-pg-alpha-10915.usw1.ptrtech.net"
alias zeusserver="ssh -D 8080 localhost"
alias spark=/Users/ltomlin/opt/spark/spark-1.1.1-bin-cdh4/bin/spark-shell
