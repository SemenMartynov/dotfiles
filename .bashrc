# ~/.bashrc

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# save datestamp of command in hisory
#export HISTTIMEFORMAT='%F %T '

# save commands immediately
#export PROMPT_COMMAND='history -a;history -n'

# don't put duplicate lines (ignoredups) and lines starting with space (ignorespace) in the history.
export HISTCONTROL=ignoreboth:erasedups

# save quantity comand
#export HISTSIZE=500
# size of history log in KB
#export HISTFILESIZE=500

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

# prompt
PS1='\[\033[32m\]\u@\[\033[01;32m\]\h\[\033[00m\]:\[\033[34m\]\w\[\033[00m\]\$ '

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias ll='ls -la --color=auto'

    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# history navigation
bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'

# some more aliases
alias yandex='mount /media/yandex'
alias cd..='cd ..'
alias tm='tmux attach || tmux new'

# export
export EDITOR="vim"
