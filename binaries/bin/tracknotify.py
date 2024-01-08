#!/usr/bin/env python3

#https://wiki.archlinux.org/index.php/Spotify#Show_track_notifications

from subprocess import Popen

from gi import require_version
require_version('Playerctl','1.0')

from gi.repository import Playerctl, GLib


PLAYER = Playerctl.Player()

def on_track_change(player, _):
    track_info = '{artist} - {title}'.format(artist=player.get_artist(), title=player.get_title())
    Popen(['notify-send', "-a", player.props.player_name, track_info])

PLAYER.on('metadata', on_track_change)

GLib.MainLoop().run()
