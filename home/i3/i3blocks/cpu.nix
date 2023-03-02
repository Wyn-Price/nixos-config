{ pkgs, ... }:
''
# Get the idle % and run 100 - %idle
[cpu]
command=${pkgs.sysstat}/bin/mpstat 4 1 | tail -1 | awk '{ print 100-$12; }' | ${pkgs.findutils}/bin/xargs ${pkgs.coreutils}/bin/printf "CPU: %0.2f%%\n"
interval=repeat
''
