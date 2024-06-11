@echo off
SET EXE_PATH=%~dp0dist\auto_convert.exe
SET NSSM_PATH=%~dp0nssm\nssm.exe

REM Check if NSSM is installed and download if not
IF NOT EXIST "%NSSM_PATH%" (
    echo NSSM is not installed. Downloading NSSM...
    powershell -Command "Invoke-WebRequest -Uri https://nssm.cc/release/nssm-2.24.zip -OutFile nssm.zip"
    powershell -Command "Expand-Archive -Path nssm.zip -DestinationPath ."
    move nssm-2.24\win64\nssm.exe nssm\nssm.exe
    rmdir /S /Q nssm-2.24
    del nssm.zip
)

REM Check for admin privileges
NET SESSION >nul 2>&1
IF %ERRORLEVEL% NEQ 0 (
    echo Please run this script with administrator privileges.
    pause
    exit /b
)

REM Remove existing service if it exists
echo Removing existing service if it exists...
"%NSSM_PATH%" remove ConvertToWebPService confirm

REM Install the new service
echo Installing ConvertToWebPService...
"%NSSM_PATH%" install ConvertToWebPService "%EXE_PATH%"
"%NSSM_PATH%" set ConvertToWebPService Start SERVICE_AUTO_START

REM Start the service
echo Starting ConvertToWebPService...
"%NSSM_PATH%" start ConvertToWebPService

echo Service ConvertToWebPService installed and started successfully.
pause
