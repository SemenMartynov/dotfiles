# ~/.bashrc

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# save datestamp of command in hisory
export HISTTIMEFORMAT='%F %T '

# save commands immediately
#export PROMPT_COMMAND='history -a;history -n'

# don't put duplicate lines (ignoredups) and lines starting with space (ignorespace) in the history.
# export HISTCONTROL=ignoreboth:erasedups
export HISTCONTROL=ignoreboth
export HISTIGNORE="ls:ll:jobs:fg:bg:history:htop:w"

# save quantity comand
export HISTSIZE=1000
# size of history log in KB
export HISTFILESIZE=50000

# export editor
export EDITOR="nvim"

# append to the history file, don't overwrite it
shopt -s histappend
# check the window size after each command and, if necessary, update the values of LINES and COLUMNS.
shopt -s checkwinsize
# correct minor errors in the spelling of a directory component in a cd command
shopt -s cdspell
# correct errors in the arguments' case
shopt -s nocaseglob
# save all lines of a multiple-line command in the same history entry (allows easy re-editing of multi-line commands)
shopt -s cmdhist
# replace directory names with the results of word expansion
shopt -s direxpand

# Alacritty support
case ${TERM} in
  xterm*|rxvt*|Etermi|alacritty|aterm|kterm|gnome*)
     PROMPT_COMMAND=${PROMPT_COMMAND:+$PROMPT_COMMAND; }'printf "\033]0;%s@%s:%s\007" "${USER}" "${HOSTNAME%%.*}" "${PWD/#$HOME/\~}"'
    ;;
  screen*)
    PROMPT_COMMAND=${PROMPT_COMMAND:+$PROMPT_COMMAND; }'printf "\033_%s@%s:%s\033\\" "${USER}" "${HOSTNAME%%.*}" "${PWD/#$HOME/\~}"'
    ;;
esac


# Prompt
#
#PS1='\[\033[32m\] \u @ \[\033[01;32m\] \h \[\033[00m\]:\[\033[34m\] \w \[\033[00m\] \$ '
# Fix "__git_ps1: command not found" on CentOS and RHEL 
if [ -f /usr/share/git/completion/git-prompt.sh ]; then
    source /usr/share/git/completion/git-prompt.sh
elif [ -f /usr/share/git-core/contrib/completion/git-prompt.sh ]; then
    source /usr/share/git-core/contrib/completion/git-prompt.sh
fi

export PROMPT_COMMAND=__prompt_command
function __prompt_command() {
    local EXIT="$?"             # This needs to be first

    local Reset='\[\033[00m\]'
    local  Grn='\[\033[00;32m\]'
    local BGrn='\[\033[01;32m\]'
    local LGrn='\[\033[00;92m\]'
    local  Red='\[\033[00;31m\]'
    local BRed='\[\033[01;31m\]'
    local LRed='\[\033[00;91m\]'
    local BYel='\[\033[01;33m\]'
    local  Pur='\[\033[00;35m\]'
    local BCyn='\[\033[01;36m\]'

    local status=""
    if [ $EXIT != 0 ]; then
        status="${Red}\u${LRed}@${BRed}\h${Reset}"      # Add red if exit code non 0
    else
        status="${Grn}\u${LGrn}@${BGrn}\h${Reset}"
    fi

    PS1="${Pur}\w${BYel}$(__git_ps1)\n$status\$ "

    # Python venv
    if [ ! -z "$VIRTUAL_ENV" ]; then
        PS1="${BCyn}(`basename \"$VIRTUAL_ENV\"`)${Reset} $PS1"
    fi
}

# Creates a directory and goes into it
take() {
    if [ $# -lt 1 ]; then
        echo "Usage: take <directory>" >&2
        return 1
    fi

    mkdir -p -- "$1" && cd -- "$1"
}

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more aliases
alias ll='ls -alF'
alias cd..='cd ..'
alias tm='tmux attach || tmux new'
alias tbox='mkdir -p /tmp/tbox && ln -s /tmp/tbox/ ./tbox && cd tbox'

# make possible to view compressed (methods gzip, bzip2, zip, compress)
# and otherwise encoded files (support for tar, RPM, nroff, MS-Word and many more)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# history navigation
bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'

bind 'set completion-ignore-case on'

# enable programmable completion features (install bash-completion).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

# show whether git repository has pending changes
# export GIT_PS1_DESCRIBE_STYLE='contains'
# export GIT_PS1_SHOWCOLORHINTS='true'
# export GIT_PS1_SHOWDIRTYSTATE='true'
export GIT_PS1_SHOWSTASHSTATE='true'
# export GIT_PS1_SHOWUNTRACKEDFILES='true'
# export GIT_PS1_SHOWUPSTREAM=verbose
# export GIT_PS1_HIDE_IF_PWD_IGNORED='true'
