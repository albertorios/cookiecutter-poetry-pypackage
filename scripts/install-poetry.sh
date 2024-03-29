#!/usr/bin/env bash
set -e
if ! command -v poetry &> /dev/null
then
  {
    # For those who already user venv's in their workflow
    PIP_REQUIRE_VIRTUALENV="1" pip install -U poetry
  } || {
    # For those who dont' use venv's in their workflow
    curl -sSL https://install.python-poetry.org | python3 -
  }
fi
