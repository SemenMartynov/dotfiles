#!/bin/sh
# Touchpad
syndaemon -t -i 2 -d &
# Terminal daemon (tempory, I hope...)
urxvtd --quiet --opendisplay --fork
# include Xresources file
[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources
# VirtulBox guest additions
#VBoxClient-all &
# set cursor
xsetroot -cursor_name left_ptr
# trayer
exec trayer --edge top --align right --margin 440 --widthtype percent --width 10 --heighttype pixels --height 16 --SetDockType true --SetPartialStrut true --transparent true --alpha 0 --tint 0x000000 --expand true &
# Keyboard layout switcher
setxkbmap -layout "us,ru(winkeys)" -option "grp:ctrl_shift_toggle"
# Wallpaper
feh --bg-scale ~/.wallpapers/math.png
# Dropbox
(sleep 20s && dropboxd) &
# start x
exec xmonad
