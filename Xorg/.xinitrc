#!/bin/sh

xressources=$HOME/.Xresources

# merge in defaults and keymaps

source ~/.xprofile

if [ -f "$xressources" ]; then
    xrdb -merge "$xressources"
fi


case $2 in
    g|gnome|gdm )
        exec gnome-session
        ;;
    b|bspwm|* )
        for f in .x11autostart/*
        do
                ./$f
        done
        sxhkd -m 1 & # azerty keyboard
        exec bspwm
esac
