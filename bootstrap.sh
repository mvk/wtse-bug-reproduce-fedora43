#!/usr/bin/env bash

test -r .env && source .env
VENV_DIR="${VENV_DIR:-".venv"}"
test -d "${VENV_DIR}" && {
  echo "INFO: ${VENV_DIR} already exists. if you want to recreate - delete it first"
  exit 0
}

venv_install=(pip install -r ./reqs.txt)
if command -v uv 2>&1 >/dev/null; then
  uv init . &&
    uv venv &&
    uv "${venv_install[@]}" &&
    exit 0
fi

python3 -m venv "${VENV_DIR}" &&
  source "${VENV_DIR}/bin/activate" &&
  "${venv_install[@]}"
