{ pkgs }:
pkgs.writers.writeBashBin "mc-terminal" ''
${pkgs.systemd}/bin/journalctl -fu minecraft-server-mrpack-$1.service &
JOURNALCTL_PID=$!

cleanup() {
    kill "$JOURNALCTL_PID" 2>/dev/null
    wait "$JOURNALCTL_PID" 2>/dev/null
}
trap cleanup EXIT INT TERM

${pkgs.coreutils}/bin/cat - > /run/minecraft-servers/minecraft-server-mrpack-$1.stdin
''
