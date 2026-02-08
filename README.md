# wtse-bug-reproduce-fedora43

This for Android bug reproduction

0. It is assumed:
    - WhatsApp is set up to use end-to-end encryption using 64 bit hex key and the user knows it
    - User knows how to use adb, it is set up, connected to the phone, the connection is authorized and the user knows the adb Id
    - User knowns their country's phone code (1-3 digits long) 
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

