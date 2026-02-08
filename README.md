# wtse-bug-reproduce-fedora43

This repository helps to report wtsexporter bugs for Android

0. It is assumed:
    - WhatsApp is already set up to:
        - backup automatically else-where
        - backups are encrypted with end-to-end encryption using 64 bit hex key
        - the user knows they hex key
    - adb:
        - is installed and configured
        - the user knows how to use it
        - the Android phone is up and connected to the machine
        - the connection is authorized
        - (optional) the user knows phone's adb Id
    - contacts used in the conversations are stored in `contacts.vcf`
    - the user knowns their country's phone code (1-3 digits long) 
1. Clone:
    ```bash
        ```!bash
        mkdir -p ~/src; cd ~/src;
        git clone https://github.com/mvk/wtse-bnug-reproduce-fedora43 wtsexporter
        cd wtsexporter
        cp example.env .env
        ```
        ```
2. Update `.env` using your favorite text editor

    - `HEX_KEY` - 64 bit key for backup
    - `DEV_ID` - phone's adb Id
    - `COUNTRY_CODE` - user's main country code

3. Workflow - run in order: 

    - i. `./bootstrap.sh` to initializes virtual env + install software 
    - ii. `./puller.sh` to pull encrypted backup from the phone to the machine
    - iii. `./extractor.sh` to extract and format the backup data as html in folder `result`


### > [!NOTE]

This repository can probably be done better.
If you have suggestions - do open tickets and send PRs.

See ya around :)
