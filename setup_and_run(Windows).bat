@echo off
:: Check and elevate to administrator privileges
NET SESSION >nul 2>&1
IF %ERRORLEVEL% NEQ 0 (
    powershell -Command "Start-Process '%~f0' -Verb runAs"
    exit /b
)

SET "SCRIPT_PATH=%~dp0dist\convert_2_webp.exe"
SET "NSSM_DIR=%~dp0nssm"
SET "NSSM_PATH=%NSSM_DIR%\nssm.exe"
SET "INPUT_FOLDER=%USERPROFILE%\Downloads\input folder"
SET "OUTPUT_FOLDER=%USERPROFILE%\Downloads\output folder"

:: Create directories if they do not exist
IF NOT EXIST "%INPUT_FOLDER%" mkdir "%INPUT_FOLDER%"
IF NOT EXIST "%OUTPUT_FOLDER%" mkdir "%OUTPUT_FOLDER%"

:: Create the NSSM directory if it does not exist
IF NOT EXIST "%NSSM_DIR%" (
    mkdir "%NSSM_DIR%"
)

:: Check if NSSM is installed and download if not
IF NOT EXIST "%NSSM_PATH%" (
    echo NSSM is not installed. Downloading NSSM...
    powershell -Command "Invoke-WebRequest -Uri https://nssm.cc/release/nssm-2.24.zip -OutFile '%NSSM_DIR%\nssm.zip'"
    IF EXIST "%NSSM_DIR%\nssm.zip" (
        powershell -Command "Expand-Archive -Path '%NSSM_DIR%\nssm.zip' -DestinationPath '%NSSM_DIR%'"
        IF EXIST "%NSSM_DIR%\nssm-2.24\win64\nssm.exe" (
            move "%NSSM_DIR%\nssm-2.24\win64\nssm.exe" "%NSSM_PATH%"
            rmdir /S /Q "%NSSM_DIR%\nssm-2.24"
        ) ELSE (
            echo Failed to find nssm.exe in the extracted directory.
            pause
            exit /b
        )
        del "%NSSM_DIR%\nssm.zip"
    ) ELSE (
        echo Failed to download NSSM.
        pause
        exit /b
    )
)

:: Remove existing service if it exists
echo Removing existing service if it exists...
"%NSSM_PATH%" stop ConvertToWebPService
"%NSSM_PATH%" remove ConvertToWebPService confirm
IF %ERRORLEVEL% NEQ 0 (
    echo Service does not exist or failed to remove the existing service.
)

:: Install the new service
echo Installing ConvertToWebPService...
"%NSSM_PATH%" install ConvertToWebPService "%SCRIPT_PATH%"
IF %ERRORLEVEL% NEQ 0 (
    echo Failed to install the service.
    pause
    exit /b
)

:: Set parameters for the service
echo Setting parameters for ConvertToWebPService...
"%NSSM_PATH%" set ConvertToWebPService AppParameters "\"%INPUT_FOLDER%\" \"%OUTPUT_FOLDER%\""
IF %ERRORLEVEL% NEQ 0 (
    echo Failed to set parameters for the service.
    pause
    exit /b
)

:: Set service to auto start
"%NSSM_PATH%" set ConvertToWebPService Start SERVICE_AUTO_START
IF %ERRORLEVEL% NEQ 0 (
    echo Failed to set service to auto start.
    pause
    exit /b
)

:: Start the service
echo Starting ConvertToWebPService...
"%NSSM_PATH%" start ConvertToWebPService
IF %ERRORLEVEL% NEQ 0 (
    echo Failed to start the service.
    pause
    exit /b
)

echo Service ConvertToWebPService installed and started successfully.
pause
