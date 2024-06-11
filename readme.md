# Tool Convert Webp

## Introduction

This tool automatically converts images in the "input" folder to WebP format and saves them in the "output" folder. The tool runs as a background service and will automatically restart when the computer is restarted.

## System Requirements

- Windows operating system

## Installation Instructions

1. **Download and Extract the Tool:**
   - Download the `Tool Convert Webp.zip` file and extract it to a location on your computer.

2. **Run the Setup Script:**
   - Navigate to the extracted folder.
   - Right-click on `setup_service.bat` and select "Run as administrator" to install and configure the service.

3. **Ensure the Service is Running:**
   - Open `Run` (Win + R), type `services.msc`, and press Enter.
   - In the Services window, find `ConvertToWebPService` and ensure it is running and set to start automatically.

## Usage

1. **Adding Images:**
   - Add images to the `input` folder.
   - The tool will automatically convert new images to WebP format and save them in the `output` folder.

2. **Service Management:**
   - To manually start or stop the service, you can use the following commands in an elevated Command Prompt:
     ```sh
     nssm start ConvertToWebPService
     nssm stop ConvertToWebPService
     ```
   - Alternatively, you can manage the service from the Services window (`services.msc`).

## Notes

- Ensure that PowerShell is installed on your system.
- If you need to reinstall or update the service, you can run the `setup_service.bat` script again.

## Troubleshooting

- If the service is not running, check the event logs for any errors related to `ConvertToWebPService`.
- Make sure that `nssm.exe` and `convert_to_webp.exe` are in the correct directories as specified in the setup script.

## Contact

For further assistance, please contact [your support contact information].

