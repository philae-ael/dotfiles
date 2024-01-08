#!/bin/sh

xressources=$HOME/.Xresources

# merge in defaults and keymaps


if [ -f "$xressources" ]; then
    xrdb -merge "$xressources"
fi

for f in .x11autostart/*
do
	./$f
done

sxhkd &
exec bspwm
