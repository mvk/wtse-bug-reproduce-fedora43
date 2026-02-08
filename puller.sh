#!/usr/bin/env bash

test -r ".env" && source ".env"

if [[ -z "${DEV_ID}" ]]; then
  count=$(adb devices | grep -v attached | grep -v "^$" | wc -l | grep -c .)
else
  count=$(adb devices | grep -c "^${DEV_ID}")
fi
if [[ "${count}" -ne 1 ]]; then
  echo "FATAL: no phones are attached to USB. Please attach and  authorize."
  exit 1
fi
echo "INFO: Phone $(test -n "${DEV_ID} && echo "ID: ${DEV_ID}") is attached to the machine"

test -z "${INSTALL_DIR}" && INSTALL_DIR="${HOME}/src/wtsexporter"
pushd "${PWD}"
mkdir -p "${INSTALL_DIR}"
cd "${INSTALL_DIR}"


git@github.com:mvk/wtse-bug-reproduce-fedora43.git

SRC_ROOT="${SRC_ROOT:-"/sdcard/Android/media/com.whatsapp/WhatsApp"}"

adb pull "${SRC_ROOT}/Databases"/ "${EXTRACTED_DIR}"/ || { echo "FATAL: Failed to get whatsapp databases."; exit 1; }
adb pull "${SRC_ROOT}/Media"/ "${EXTRACTED_DIR}"/ || { echo "FATAL: Failed to get whatsapp media."; exit 1; }
