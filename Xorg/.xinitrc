#!/bin/sh

xressources=$HOME/.Xresources


xrandr --setprovideroutputsource modesetting NVIDIA-0
xrandr --auto
xrandr --dpi 96

# merge in defaults and keymaps

if [ -f "$xressources" ]; then
    xrdb -merge "$xressources"
fi

for f in .x11autostart/*
do
	./$f
done

sxhkd -m 1 & # azerty keyboard
exec bspwm
