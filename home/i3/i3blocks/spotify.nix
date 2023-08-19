{ pkgs, ... }:
''
# Custom code
[spotify-title]
command=/home/wp/programming/i3status-rs-spotify/target/debug/i3status-rs-spotify title
interval=persist
format=json

## Broken at some point - reqwest isn't able to query the API?
# [spotify-bpm]
# command=/home/wp/programming/i3status-rs-spotify/target/debug/i3status-rs-spotify bpm
# interval=persist
# format=json

[spotify-progress]
command=/home/wp/programming/i3status-rs-spotify/target/debug/i3status-rs-spotify progress
interval=persist
format=json
''
