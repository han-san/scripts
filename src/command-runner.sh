#! /bin/sh
# Runs a command using `comma` outside of the terminal.

set -eu

commandline="$(echo "" | tofi --prompt-text="Command to run: " --text-cursor=true --require-match=false)"

if [ -z "$commandline" ]; then
  exit 0
fi

# shellcheck disable=SC2086 # We want the argument spread.
if ! errout="$(comma -P tofi $commandline 2>&1 >/dev/null)"; then
  notify-send --urgency=normal "Command runner" "$errout"
fi
