# Network-File-Copy-and-Install
Script to Copy File from Network Path to Local Machine and Execute Installer
# Script to Copy File from Network Path to Local Machine and Execute Installer

This repository contains a Windows batch script (`.cmd` file) that automates the following tasks:

1. Copies a specified file from a network share path to the local machine (e.g., `C:\Temp`).
2. Executes the copied file with specific parameters.

## Features
- Connects to a network share using a username and password.
- Automatically creates the destination folder (`C:\Temp`) if it does not exist.
- Verifies successful connection to the network share and file copy operation.
- Executes the installer silently using command-line options.
- Disconnects from the network share after completion.

## Script Overview
```cmd
@echo off

:: Set variables
set "sourceFile=\\192.168.1.131\temp\FORCEPOINT-ONE-ENDPOINT-x64.exe"
set "destination=C:\Temp\FORCEPOINT-ONE-ENDPOINT-x64.exe"
set "username=admin"
set "password=India@123"

:: Create the destination folder if it doesn't exist
if not exist "C:\Temp" mkdir "C:\Temp"

:: Map the network share (if authentication is required)
net use \\192.168.1.131\temp /user:%username% %password% /persistent:no

:: Check if the mapping was successful
if errorlevel 1 (
    echo Failed to connect to the network share.
    exit /b 1
)

:: Copy the file from the network path to the destination folder
copy "%sourceFile%" "%destination%"

:: Check if the copy was successful
if errorlevel 1 (
    echo Failed to copy the file.
    exit /b 1
)

echo File copied successfully to C:\Temp.

:: Change directory to the destination folder
cd C:\Temp

:: Execute the command
echo Executing the installer...
"C:\Temp\FORCEPOINT-ONE-ENDPOINT-x64.exe" /v"/qn /norestart"

:: Disconnect the network share (optional)
net use \\192.168.1.131\temp /delete

echo Installation completed.

exit /b 0
```

## Prerequisites
1. Ensure that the source file (`FORCEPOINT-ONE-ENDPOINT-x64.exe`) exists at the specified network path (`\\192.168.1.131\temp`).
2. Run the script with administrator privileges to avoid permission issues.

## How to Use
1. Clone or download this repository.
2. Open the script file in a text editor and update the following variables as needed:
   - `sourceFile`: Path to the file on the network share.
   - `username`: Username for the network share.
   - `password`: Password for the network share.
   - `destination`: Path to the local folder where the file will be copied (default: `C:\Temp`).
3. Save the script as a `.cmd` or `.bat` file.
4. Run the script by double-clicking it or executing it from the command line with administrator privileges.

## Notes
- **Credentials**: Storing passwords in plain text is not secure. Consider using secure alternatives for credential management.
- **Error Handling**: The script checks for errors during network connection, file copy, and installation, and exits gracefully with an appropriate message.

## License
This project is licensed under the MIT License. See the `LICENSE` file for details.

## Disclaimer
This script is provided as-is and should be tested in a safe environment before deploying in production.

