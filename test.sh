reply=$(dbus-send \
    --print-reply \
    --dest=org.mpris.MediaPlayer2.spotify \
    /org/mpris/MediaPlayer2 \
    org.freedesktop.DBus.Properties.GetAll \
    string:org.mpris.MediaPlayer2.Player
);

get_string() {
    skip=${2:-}
    (sed -n "/\"$1\"/{n;${skip}p}" | cut -d '"' -f 2) <<< $reply;
}

get_value() {
    (sed -n "/\"$1\"/{n;p}" | awk '{ print $3 }' ) <<< $reply;
}

# Playing
# Paused
# ??
PlaybackStatus=$( get_string PlaybackStatus )

# Playlist -> loop forever
# Track    -> loop this track
# None     -> no looping
LoopStatus=$( get_string LoopStatus )

# true / false
ShuffleStatus=$( get_value Shuffle )

# The current track position in microseconds
TrackPosition=$( get_value Position )

# Current track length in microseconds
TrackLength=$( get_value mpris:length )

# Track stuff
TrackAlbum=$( get_string xesam:album )
TrackArtist=$( get_string xesam:artist n\;)
TrackTitle=$( get_string xesam:title )
