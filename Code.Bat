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
