#!/bin/sh

untracked_files=$(git ls-files --others --exclude-standard)
if [ -n "$untracked_files" ]; then
  echo "Pre-commit failed: Found untracked files:"
  echo "$untracked_files" | sed 's/^/  /'
  echo ""
  echo "Please add these files to git or add them to .gitignore"
  exit 1
fi
