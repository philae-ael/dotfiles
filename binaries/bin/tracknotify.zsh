#!/usr/bin/zsh

while read f; do
    notify-send -a "mpc" "This song" "$(mpc current -f '%artist% - %title%')"
done < <(mpc idleloop player)
