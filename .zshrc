
#------------------------------------------------------------------------------------------#
# environment variables                                                                    #
#------------------------------------------------------------------------------------------#

# export FTP_PASSIVE=1
# export SVN_EDITOR=vi
# export PAGER=jless
# export PAGER="lv -c"

## enviroment variables for zsh
PS1='[%n@%m %1d]%% '
HISTFILE=$HOME/.zsh-history
HISTSIZE=100000
SAVEHIST=100000

#------------------------------------------------------------------------------------------#
# aliases                                                                                  #
#------------------------------------------------------------------------------------------#
alias history='lv ~/.zsh-history'
alias ls='ls -G'
alias ll='ls -l'
alias grep='grep --color'
alias la='ls -lA'
alias lh='ls -lAh'
alias bee='cd ~/tools/beeline && ./bin/beeline'


# alias for git
alias gl='git log --pretty=format:"%H \"%s\" by %cn" --graph'

#------------------------------------------------------------------------------------------#
# bindkeys                                                                                 #
#------------------------------------------------------------------------------------------#
bindkey -e
bindkey '\C-u' undo

## dabbrev
HARDCOPYFILE=$HOME/tmp/screen-hardcopy
touch $HARDCOPYFILE

dabbrev-complete () {
    local reply lines=80 # 80¹ÔÊ¬
    screen -X eval "hardcopy -h $HARDCOPYFILE"
    reply=($(sed '/^$/d' $HARDCOPYFILE | sed '$ d' | tail -$lines))
    compadd - "${reply[@]%[*/=@|]}"
}

zle -C dabbrev-complete menu-complete dabbrev-complete
bindkey '^o' dabbrev-complete
bindkey '^o^_' reverse-menu-complete

## cd .. like dired of Emacs
function cdup() {
   echo
   cd ..
   zle reset-prompt 
}
zle -N cdup
#bindkey '\^' cdup

#------------------------------------------------------------------------------------------#
# zsh configuration                                                                        #
#------------------------------------------------------------------------------------------#
limit coredumpsize 102400
unsetopt promptcr
setopt prompt_subst
setopt notify
setopt nobeep
setopt rec_exact
setopt long_list_jobs
setopt list_types
setopt auto_resume
setopt auto_list
setopt hist_ignore_dups
setopt autopushd
setopt pushd_minus
setopt extended_glob
setopt auto_menu
setopt no_list_beep
setopt pushd_ignore_dups
setopt no_nomatch
setopt extended_history
setopt equals
setopt magic_equal_subst
setopt hist_verify
setopt numeric_glob_sort
setopt print_eight_bit
setopt complete_in_word # ZSH FAQ: 4.4
setopt complete_aliases
setopt share_history
unsetopt ignore_eof
unsetopt hash_cmds
zstyle ':completion:*:default' menu select=1
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

setopt auto_cd
setopt auto_param_keys
setopt auto_param_slash
setopt auto_remove_slash
setopt NO_beep
setopt correct

autoload -U compinit
compinit

#------------------------------------------------------------------------------------------#
# functions                                                                                #
#------------------------------------------------------------------------------------------#
function history-all { history -E 1 }
function histail { history -E 1 | grep $1 | tail }


#------------------------------------------------------------------------------------------#
# with screen                                                                              #
# http://nijino.homelinux.net/diary/200206.shtml#200206140                                 #
#------------------------------------------------------------------------------------------#
preexec () {
  echo -ne "\ek${1%% *}\e\\"
}

preexec () {
  [ ${STY} ] && echo -ne "\ek${1%% *}\e\\"  
}

#autoload -Uz VCS_INFO_get_data_git; VCS_INFO_get_data_git 2> /dev/null
function rprompt-git-current-branch {
        local name st color gitdir action
        if [[ "$PWD" =~ '/?.git(/.*)?$' ]]; then
                return
        fi
        name=$(basename "`git symbolic-ref HEAD 2> /dev/null`")
        if [[ -z $name ]]; then
                return
        fi

        gitdir=`git rev-parse --git-dir 2> /dev/null`
        #action=`VCS_INFO_git_getaction "$gitdir"` && action="($action)"

        st=`git status 2> /dev/null`
        if [[ -n `echo "$st" | grep "^nothing to"` ]]; then
                color=%F{green}
        elif [[ -n `echo "$st" | grep "^nothing added"` ]]; then
                color=%F{yellow}
        elif [[ -n `echo "$st" | grep "^# Untracked"` ]]; then
                color=%B%F{red}
        else
                color=%F{red}
        fi
        #echo "$color$name$action%f%b "
        echo "$name%f%b "
}
#setopt prompt_subst
#RPROMPT='[`rprompt-git-current-branch`%~]'

function do_enter() {
  if [ -n "$BUFFER" ]; then
    zle accept-line
    return 0
  fi
  echo
  ls
  
  #if [ "$(git rev-parse --is-inside-work-tree 2> /dev/null)" = 'true' ]; then
  #  echo
  #  echo -e "\e[0;33m--- git status ---\e[0m"
  #  git status -sb
  #fi
  zle reset-prompt
  return 0
}
zle -N do_enter
bindkey '^m' do_enter

setopt auto_cd
function chpwd() { ls }

#------------------------------------------------------------------------------------------#
# my settings                                                                              #
#------------------------------------------------------------------------------------------#
export PATH=/usr/local/bin:$PATH:.

source $(brew --prefix nvm)/nvm.sh

