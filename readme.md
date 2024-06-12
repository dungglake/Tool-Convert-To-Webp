# Auto Convert to WebP Service

This tool automatically converts images in a specified input folder to WebP format and saves them in an output folder. It is designed to run as a Windows service that starts automatically when the computer is rebooted.

## Prerequisites

- Windows Operating System
- Administrator privileges to install the service

## Installation Guide

### Step 1: Download and Extract the Tool

1. Download the tool package and extract it to a folder, e.g., `C:\Users\YourUsername\Downloads\Tool Convert WebP`.

### Step 2: Run the Setup Script

1. Navigate to the folder where you extracted the tool.
2. Double-click on `setup_service.bat` to run the setup script.
3. The script will:
    - Download and install NSSM (Non-Sucking Service Manager) if it's not already installed.
    - Install and configure the service to start automatically on system boot.

### Step 3: Verify the Service Installation

1. After running the `setup_service.bat` script, the service should be installed and started automatically.
2. You can verify the service by checking the Windows Services Manager:
    - Press `Win + R`, type `services.msc`, and press `Enter`.
    - Look for a service named `ConvertToWebPService`.

## Usage Guide
- You do not need to create these folders manually. The tool will create them automatically if they do not exist.
### Adding Images

1. Place your images (PNG, JPG, JPEG, BMP, TIFF) into the input folder.
2. The tool will automatically convert these images to WebP format and save them in the output folder.

## Uninstallation Guide

### Step 1: Remove the Service

1. Open a command prompt as administrator.
2. Navigate to the folder where the tool is installed.
3. Run the following command to stop and remove the service:
    ```batch
    nssm\nssm.exe stop ConvertToWebPService
    nssm\nssm.exe remove ConvertToWebPService confirm
    ```

### Step 2: Clean Up

1. Delete the tool folder and its contents.

## Troubleshooting

### Service Not Starting

- Ensure you have administrator privileges.
- Check the service logs for errors.
- Verify that required packages are installed correctly.

### Images Not Converting

- Ensure that images are placed in the correct input folder.
- Check the output folder for converted images.
- Verify the service is running in the Windows Services Manager.

## Contact

For any issues or support, please contact [hoangdung0904@gmail.com].
