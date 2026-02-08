#!/usr/bin/env bash

test -r .env && source .env
HEX_KEY="${HEX_KEY?cannot continue without HEX_KEY, set via .env}"
COUNTRY_CODE="${COUNTRY_CODE:-""}"
CONTACTS="${CONTACTS:-"contacts.vcf"}"
EXTRACTED_DIR="${EXTRACTED_DIR:-"./whatsapp-db"}"
CHATS_PATH="${CHATS_PATH:-"${EXTRACTED_DIR}/Databases/msgstore.db.crypt15"}"
MEDIA_PATH="${MEDIA_PATH:-"${EXTRACTED_DIR}/Media"}"
VENV_DIR="${VENV_DIR:-".venv"}"

test -d "${INSTALL_DIR}" || {
  echo "FATAL: INSTALL_DIR is not present. refer to README.md of this repository"
  exit 1
}

CMD=("wtsexporter" -a -k "${HEX_KEY}")
test -d "${EXTRACTED_DIR}" ]] || {
  echo "FATAL: EXTRACTED_DIR=${EXTRACTED_DIR} not found/not-dir"
  exit 1
}

test -f "${CHATS_PATH}" || {
  echo "FATAL: CHATS_PATH=${CHATS_PATH} is missing"
  exit 1
}
CMD+=(-b "${CHATS_PATH}")

test -d "${MEDIA_PATH}" || {
  echo "FATAL: MEDIA_PATH='${MEDIA_PATH}' is missing"
  exit 1
}
CMD+=(-m "${MEDIA_PATH}")

test -f "${CONTACTS}" && {
  echo "INFO: adding CONTACTS='${CONTACTS}' to the command"
  CMD+=(--enrich-from-vcards "${CONTACTS}")
}
if [[ -z "${COUNTRY_CODE}" ]]; then
  echo "WARNING: COUNTRY_CODE was not set. It is advised to use it"
else
  echo "INFO: adding COUNTRY_CODE='${COUNTRY_CODE}'"
  CMD+=(--default-country-code "${COUNTRY_CODE}")
fi

# echo "Current command is: '${CMD[*]}'"
if [[ -d "${VENV_DIR}" ]]; then
  source "${VENV_DIR}/bin/activate"
fi

command -v "wtsexporter" || {
  echo "FATAL: wtsexporter is not on PATH. run: ./bootstrap.sh"
  exit 1
}
"${CMD[@]}"
