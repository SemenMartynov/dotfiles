## файл истории команд
HISTFILE=~/.histfile
## Число команд, сохраняемых в HISTFILE
HISTSIZE=1000
## Чucлo koмaнg, coxpaняeмыx в сеансе
SAVEHIST=1000
## Дополнение файла истрии
setopt  APPEND_HISTORY
## Игнopupoвaть вce пoвтopeнuя команд
setopt  HIST_IGNORE_ALL_DUPS
## Игнopupo лишние пpoбeлы
setopt  HIST_IGNORE_SPACE
## Удалять из файл истории пустые строки
setopt  HIST_REDUCE_BLANKS
# History search
bindkey    "^[[A" history-beginning-search-backward
bindkey    "^[[B" history-beginning-search-forward
bindkey    "^[[1~" vi-beginning-of-line   # Home
bindkey    "^[[4~" vi-end-of-line         # End
bindkey    '^[[2~' beep                   # Insert
bindkey    '^[[3~' delete-char            # Del
bindkey    '^[[5~' vi-backward-blank-word # Page Up
bindkey    '^[[6~' vi-forward-blank-word  # Page Down

# режим навигации в стиле vi
#bindkey -v

# Editor
#setopt VI
export EDITOR="vim"

# beeps are annoying
setopt no_beep
# Для разворота сокращенного ввода
autoload -Uz compinit
compinit
# Autocompletion with an arrow-key driven interface
zstyle ':completion:*' menu select
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

zstyle ':completion:*:processes' command 'ps -ax' 
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;32'
zstyle ':completion:*:*:kill:*' menu yes select
zstyle ':completion:*:kill:*'   force-list always

zstyle ':completion:*:processes-names' command 'ps -e -o comm='
zstyle ':completion:*:*:killall:*' menu yes select
zstyle ':completion:*:killall:*'   force-list always

# spelling correction
setopt correct

# The "command not found" hook
if [[ -s '/usr/share/doc/pkgfile/command-not-found.zsh' ]]; then
  source /usr/share/doc/pkgfile/command-not-found.zsh
fi

# set ignore case for ls etc
setopt no_case_glob
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

# Colors
autoload -U colors && colors

# Prompt
PROMPT="%{$fg[cyan]%}%n@%B%m%b%{$reset_color%} %{$fg_no_bold[gray]%}%~ %{$reset_color%}%# "

# Алиасы
alias ls='ls --color'
alias ll='ls -la --color'

alias grep='grep --color'

alias yandex='mount /media/yandex'
alias cd..='cd ..'
alias tm='tmux attach || tmux new'
