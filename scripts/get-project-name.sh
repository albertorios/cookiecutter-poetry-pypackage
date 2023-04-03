#!/usr/bin/env bash
set -e
if command -v poetry &> /dev/null
then
  PROJECT_NAME=$(poetry version | cut -d ' ' -f 1)
else
  PROJECT_NAME=$(cat pyproject.toml | \
    grep -A1 '^\[tool.poetry\]$' | \
    grep '^name\|^ - ' | \
    cut -s -d'=' -f 2 | \
    tr -s ' ' | \
    tr -d '"' \
  )
fi
echo $PROJECT_NAME
