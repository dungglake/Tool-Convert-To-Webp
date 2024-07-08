# Image Conversion to WebP

This project monitors a folder for new images and converts them to WebP format.

## Requirements

- Python 3.x
- `Pillow` library
- `watchdog` library

## Setup and Run

### Windows

1. Unzip the folder you just downloaded.
2. Double-click `setup_and_run(Windows).bat` to install required libraries and start monitoring.
    - If the script is running in the background when you close the terminal, you can stop it by finding and ending the process in Task Manager:
        1. Press `Windows+R`, type `services.msc`, and press Enter.
        2. Find the service named `ConvertToWebPService` and end the process.

**Note**: This is an automatic tool on Windows, so you do not need to run a terminal or create shortcuts. It will automatically convert new image files and skip old images as well as subfolders. This is a tool that runs in the background without consuming much resources. If you have deleted the services of this tool, you just need to restart it by double-clicking `setup_and_run(Windows).bat`. When you turn off the service, you just need to restart this service on `services.msc`.

### Linux

1. Run `unzip Tool Convert to Webp.zip` in terminal or `Extract file` by right-click file when you done the download.
2. Navigate to the directory containing `setup_and_run.sh`.
3. Run the script:
    `chmod +x setup_and_run.sh`
   `./setup_and_run.sh`
4. The script will stop if the action is done and when you close the terminal.

**Note**: If you want to services runs automatically when you turn off terminal or reboot the computer:
    -Open the crontab to edit: run `crontab -e`
    -If you encounter a situation where you need to choose a number, choose number 1 and enter to edit the nano file. If not, do the next step as usual
    -Add this line into nano file `@reboot nohup /bin/bash /home/dung/Downloads/Tool\ Convert\ to\ Webp/setup_and_run.sh &`
    -If you are using nano (default editor), press Ctrl+O to save and Ctrl+X to exit.
