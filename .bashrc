# ~/.bashrc

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

###############################################################################
##                                  General                                  ##
###############################################################################

# export editor
export EDITOR="nvim"

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
  xterm* | rxvt* | Eterm | alacritty | aterm | kterm | gnome*)
    _title_cmd='printf "\033]0;%s@%s:%s\007" "${USER}" "${HOSTNAME%%.*}" "${PWD/#$HOME/\~}"'
    ;;
  screen*)
    _title_cmd='printf "\033_%s@%s:%s\033\\" "${USER}" "${HOSTNAME%%.*}" "${PWD/#$HOME/\~}"'
    ;;
  *)
    _title_cmd=""
    ;;
esac

# Case-insensitive Tab completion
bind "set completion-ignore-case on"
# Show all completions on first Tab (no double-Tab needed)
bind "set show-all-if-ambiguous on"

###############################################################################
##                                  History                                  ##
###############################################################################

# Number of command log lines in memory
export HISTSIZE=10000
# Number of command log lines on disk
export HISTFILESIZE=50000

# save datestamp of command in hisory
export HISTTIMEFORMAT='%F %T '

# save commands immediately
#export PROMPT_COMMAND='history -a;history -n'

# don't put duplicate lines (ignoredups) and lines starting with space (ignorespace) in the history.
export HISTCONTROL=ignoreboth # ignoredups + ignorespace
# export HISTCONTROL=ignoreboth:erasedups

# Skip noise commands
export HISTIGNORE="ls:ll:jobs:fg:bg:history:htop:w:exit:clear:pwd:take"

# append to the history file, don't overwrite it
shopt -s histappend

# history navigation
bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'

###############################################################################
##                               Prompt (PS1)                                ##
###############################################################################

#PS1='\[\033[32m\] \u @ \[\033[01;32m\] \h \[\033[00m\]:\[\033[34m\] \w \[\033[00m\] \$ '

# --- git-prompt (distribution-agnostic) ---
for _git_prompt in \
  /usr/share/git/completion/git-prompt.sh \
  /usr/share/git-core/contrib/completion/git-prompt.sh \
  /usr/lib/git-core/git-sh-prompt \
  /opt/homebrew/etc/bash_completion.d/git-prompt.sh
do
  if [ -f "$_git_prompt" ]; then
    # shellcheck source=/dev/null
    source "$_git_prompt"
    break
  fi
done
unset _git_prompt

# Git status indicators in prompt
# export GIT_PS1_DESCRIBE_STYLE='contains'  # detached HEAD
# export GIT_PS1_SHOWCOLORHINTS='true'      # colour inside __git_ps1
# export GIT_PS1_SHOWDIRTYSTATE='true'      # * unstaged  + staged
export GIT_PS1_SHOWSTASHSTATE='true'        # $ stashed
# export GIT_PS1_SHOWUNTRACKEDFILES='true'  # % untracked
# export GIT_PS1_SHOWUPSTREAM=verbose       # ahead/behind upstream
# export GIT_PS1_HIDE_IF_PWD_IGNORED='true' # hides the git prompt if CWD is added to .gitignore

# --- Prompt function ---
function __prompt_command() {
  local EXIT="$?"      # must be first

  # Update window title
  [ -n "$_title_cmd" ] && eval "$_title_cmd"

  # Colours
  local Reset='\[\033[00m\]'
  local Grn='\[\033[00;32m\]'
  local BGrn='\[\033[01;32m\]'
  local LGrn='\[\033[00;92m\]'
  local Red='\[\033[00;31m\]'
  local BRed='\[\033[01;31m\]'
  local LRed='\[\033[00;91m\]'
  local BYel='\[\033[01;33m\]'
  local Pur='\[\033[00;35m\]'
  local BCyn='\[\033[01;36m\]'

  # user@host — red if last command failed
  local status_part
  if [ "$EXIT" -ne 0 ]; then
    status_part="${Red}\u${LRed}@${BRed}\h${Reset}"
  else
    status_part="${Grn}\u${LGrn}@${BGrn}\h${Reset}"
  fi

  PS1="${Pur}\w${BYel}$(__git_ps1 " (%s)")${Reset}\n${status_part}\$ "

  # Prepend active Python venv name
  if [ -n "$VIRTUAL_ENV" ]; then
    PS1="${BCyn}($(basename "$VIRTUAL_ENV"))${Reset} $PS1"
  fi
}
export PROMPT_COMMAND="__prompt_command"

###############################################################################
##                                   Tools                                   ##
###############################################################################

# Creates a directory and goes into it
take() {
  if [ $# -lt 1 ]; then
    echo "Usage: take <directory>" >&2
    return 1
  fi
  mkdir -p -- "$@" && cd -- "$_"
}

# Extract/Unpack any common archive format
extract() {
  if [ $# -lt 1 ]; then
    echo "Usage: extract <file>" >&2
    return 1
  fi
  if [ ! -f "$1" ]; then
    echo "'$1' is not a file" >&2
    return 1
  fi
  case "$1" in
    *.tar.bz2)  tar xjf "$1"    ;;
    *.tar.gz)   tar xzf "$1"    ;;
    *.tar.xz)   tar xJf "$1"    ;;
    *.tar.zst)  tar --zstd -xf "$1" ;;
    *.bz2)      bunzip2 "$1"    ;;
    *.gz)       gunzip "$1"     ;;
    *.tar)      tar xf "$1"     ;;
    *.tbz2)     tar xjf "$1"    ;;
    *.tgz)      tar xzf "$1"    ;;
    *.zip)      unzip "$1"      ;;
    *.7z)       7z x "$1"       ;;
    *.xz)       unxz "$1"       ;;
    *.zst)      zstd -d "$1"    ;;
    *.rar)      unrar x "$1"    ;;
    *)          echo "Don't know how to extract '$1'" >&2; return 1 ;;
  esac
}

# Run devcontainer CLI
devcontainer() {
  # printf 'FROM debian:bookworm-slim\nRUN apt-get update && apt-get install -y --no-install-recommends curl ca-certificates xz-utils docker.io git && rm -rf /var/lib/apt/lists/*\nRUN curl -fsSL https://raw.githubusercontent.com/devcontainers/cli/main/scripts/install.sh | sh\nENTRYPOINT ["/root/.devcontainers/bin/devcontainer"]\n' | docker build -t local/devcontainer-cli -
  local ssh_args=""

  # Checking if ssh-agent is running on the host
  if [ -n "$SSH_AUTH_SOCK" ] && [ -S "$SSH_AUTH_SOCK" ]; then
    ssh_args="--mount type=bind,source=$SSH_AUTH_SOCK,target=/tmp/ssh-agent.sock \
              --env SSH_AUTH_SOCK=/tmp/ssh-agent.sock"
  fi

  docker run -it --rm \
    --mount type=bind,source=/var/run/docker.sock,target=/var/run/docker.sock \
    --mount type=bind,source="$(pwd)",target=/workspace \
    $ssh_args \
    --workdir /workspace \
    local/devcontainer-cli:latest "$@"
}

# make possible to view compressed (methods gzip, bzip2, zip, compress)
# and otherwise encoded files (support for tar, RPM, nroff, MS-Word and many more)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# enable programmable completion features (install bash-completion).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

###############################################################################
##                                  Aliases                                  ##
###############################################################################

# Enable colour support for ls / grep
if [ -x /usr/bin/dircolors ]; then
  test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
fi

# --- Editor ---
alias vi="nvim"
alias vim="nvim"

# --- ls ---
if [ -x /usr/bin/dircolors ]; then
    alias ls="ls --color=auto"
  else
    alias ls="ls -G" # macOS / BSD
fi
alias ll="ls -alF"

# --- grep ---
alias grep="grep --color=auto"

# --- Navigation ---
alias cd..="cd .."

# --- tmux ---
alias tm="tmux attach || tmux new"

###############################################################################
##                                  Suffix                                   ##
###############################################################################

# Machine-local settings (tokens, work paths, etc.)
[ -f ~/.bashrc.local ] && source ~/.bashrc.local

# Reset the return code to 0 so that the prompt is always green when start
:
