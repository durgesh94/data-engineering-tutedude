#!/bin/zsh

set -euo pipefail

repo_root="${1:-$(git rev-parse --show-toplevel)}"
readme_path="$repo_root/README.md"

if [[ ! -f "$readme_path" ]]; then
    exit 0
fi

today="$(date '+%B %-d, %Y')"
tmp_file="$(mktemp)"

awk -v today="$today" '
    BEGIN { updated = 0 }
    /^\*\*Last Updated\*\*:/ {
        print "**Last Updated**: " today "  "
        updated = 1
        next
    }
    { print }
    END {
        if (updated == 0) {
            exit 1
        }
    }
' "$readme_path" > "$tmp_file"

mv "$tmp_file" "$readme_path"
