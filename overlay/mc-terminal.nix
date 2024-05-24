{ pkgs }:
pkgs.writers.writeBashBin "mc-terminal" ''
${pkgs.systemd}/bin/journalctl -fu minecraft-server-mrpack-$1.service &
${pkgs.coreutils}/bin/cat - > /run/minecraft-servers/minecraft-server-mrpack-$1.stdin
''
