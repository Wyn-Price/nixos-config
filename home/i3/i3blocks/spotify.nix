{ pkgs, ... }:
''
# These keep spawning loads of threads!
# # Custom code
# [spotify-title]
# command=${pkgs.wp-i3status-conf-rs}/bin/i3status-conf-rs title
# interval=persist
# format=json

## Broken at some point - reqwest isn't able to query the API?
# [spotify-bpm]
# command=${pkgs.wp-i3status-conf-rs}/bin/i3status-conf-rs bpm
# interval=persist
# format=json

# [spotify-progress]
# command=${pkgs.wp-i3status-conf-rs}/bin/i3status-conf-rs progress
# interval=persist
# format=json
''
