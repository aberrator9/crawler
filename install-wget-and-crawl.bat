@echo off
setlocal enabledelayedexpansion

REM Read variables from the configuration file
for /f "delims=" %%a in (config.txt) do set "%%a"

REM Set the directory to store wget (in the user's profile directory)
set "wget_directory=%USERPROFILE%\wget"

REM Create the wget directory if it doesn't exist
if not exist "%wget_directory%" mkdir "%wget_directory%"

REM Set the URL to download wget
set "wget_url=https://eternallybored.org/misc/wget/1.21.4/64/wget.exe"

REM Download wget executable
curl -L "%wget_url%" -o "%wget_directory%\wget.exe"

REM Add wget directory to the system's PATH
setx PATH "%PATH%;%wget_directory%" /M

REM Explicitly set PATH variable in the script
set "PATH=%PATH%;%wget_directory%"

echo Wget installation completed.

REM Get the download folder from the environment variable USERPROFILE
set "download_folder=%USERPROFILE%\Downloads"

REM Create the download directory based on the website name
for %%I in (!website_url!) do set "website_name=%%~nxI"
set "download_directory=!download_folder!\!website_name!"

REM Create the download directory if it doesn't exist
if not exist "!download_directory!" mkdir "!download_directory!"

REM Use wget to download all PDF files from the website to the output directory
@REM wget -r -l1 -A pdf -P "!download_directory!" "!website_url!"
wget --user-agent="Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36" --no-check-certificate --mirror --convert-links --adjust-extension --page-requisites -A pdf -P "!download_directory!" "!website_url!"

echo Download completed.
pause
 