#! /bin/sh
# Allows the user to interactively select a snippet file to copy.

set -eu
IFS=$(printf "\n\t")

if [ -z "${SNIPPETS_DIR:-""}" ]; then
  printf "The SNIPPETS_DIR environment variable must be set to a non-empty string.\n"
  exit 1
fi

if ! [ -d "$SNIPPETS_DIR" ]; then
  printf "The SNIPPETS_DIR environment variable does not point to a directory.\n"
  exit 1
fi

if [ "$#" -gt 1 ]; then
  printf "Usage: snippet [filename]\n"
  exit 1
fi

out_file_path="${1:-./}"

if ! chosenfile=$(fd . "$SNIPPETS_DIR" | fzf --header="Which snippet do you want to copy?" --preview='bat --color=always {}'); then
  exit 1
fi

cp -i "$chosenfile" "$out_file_path"
