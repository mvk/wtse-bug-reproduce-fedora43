# About

This repository helps to report wtsexporter bugs for Android by automating:

1. python venv setup.
2. pulling the backup.
3. Extracting of WhatsApp backup.

## Assumptions

- WhatsApp is already set up to:
    - backup automatically else-where (e.g. Google).
    - backups are encrypted with end-to-end encryption using 64 bit hex key.
    - the user knows they hex key.
- adb works:
    - is installed and configured:
        - The `adb` package (Fedora: `android-tools`) is installed.
        - The group `adbusers` exists, current user is in it.
        - There `udev` rules file that binds attached USB device matching to be properly accessible by group `adbusers` exists and loaded.
    - the user knows how to use it.
    - the phone (Android) is up and connected to the machine.
    - the connection is authorized.
    - (optional) the user knows phone's adb Id.
- The contacts used in the conversations are stored in `contacts.vcf`.
- The user knowns their country's phone code (1-3 digits long).

## Actions

1. Clone this repository:
    ```bash
        ```!bash
        mkdir -p ~/src; cd ~/src;
        git clone https://github.com/mvk/wtse-bnug-reproduce-fedora43 wtsexporter
        cd wtsexporter
        cp example.env .env

        ```
2. Update `.env` using your favorite text editor

    - `HEX_KEY` - 64 bit key for backup
    - `DEV_ID` - phone's adb Id
    - `COUNTRY_CODE` - user's main country code

3. Workflow - run in order:

    - i. `./bootstrap.sh` to initializes virtual env + install software.
    - ii. `./puller.sh` to pull encrypted backup from the phone to the machine.
    - iii. `./extractor.sh` to extract and format the backup data as html in folder `result`.


## NOTE

This repository can probably be improved.
If you have suggestions - do open tickets and send PRs.

See ya around :)
