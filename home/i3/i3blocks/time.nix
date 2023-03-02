{ pkgs, ... }:
''
# Time -> Thu 02 Mar 19:53:28
[time]
command=${pkgs.coreutils}/bin/date "+%a %d %b %T"
interval=1
''
