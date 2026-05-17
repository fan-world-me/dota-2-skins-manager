@echo off
setlocal enabledelayedexpansion
title Dota 2 Font Replacer - Monocraft
color 0B

:: --- CONFIGURATION ---
set "SOURCE_FONT=C:\Users\yarik\OneDrive\Desktop\Monocraft.ttc"
set "BACKUP_DIR_NAME=backup_fonts"

echo ============================================================
echo           DOTA 2 AUTOMATIC FONT REPLACER
echo ============================================================
echo.

:: 1. Check if source font exists
if not exist "%SOURCE_FONT%" (
    color 0C
    echo [ERROR] Source font not found at:
    echo "%SOURCE_FONT%"
    echo Please make sure Monocraft.ttc is on your Desktop.
    pause
    exit /b
)

:: 2. Find Dota 2 Path
echo [INFO] Searching for Dota 2 installation...

set "DOTA_PATH="

:: Try Registry (Steam App 570)
for /f "tokens=2*" %%a in ('reg query "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Steam App 570" /v InstallLocation 2^>nul') do set "DOTA_PATH=%%b"
if not defined DOTA_PATH (
    for /f "tokens=2*" %%a in ('reg query "HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\Steam App 570" /v InstallLocation 2^>nul') do set "DOTA_PATH=%%b"
)

:: Try Steam Path + Default location
if not defined DOTA_PATH (
    for /f "tokens=2*" %%a in ('reg query "HKEY_CURRENT_USER\Software\Valve\Steam" /v SteamPath 2^>nul') do set "STEAM_PATH=%%b"
    if defined STEAM_PATH (
        set "STEAM_PATH=!STEAM_PATH:/=\!"
        if exist "!STEAM_PATH!\steamapps\common\dota 2 beta" (
            set "DOTA_PATH=!STEAM_PATH!\steamapps\common\dota 2 beta"
        )
    )
)

:: Fallback to local DotaPath.txt if available in current dir
if not defined DOTA_PATH (
    if exist "DotaPath.txt" (
        set /p DOTA_PATH=<DotaPath.txt
        set "DOTA_PATH=!DOTA_PATH:/=\!"
        :: Remove trailing spaces if any
        for /f "tokens=* delims= " %%a in ("!DOTA_PATH!") do set "DOTA_PATH=%%a"
    )
)

:: Final Check
if not defined DOTA_PATH (
    color 0C
    echo [ERROR] Could not find Dota 2 installation path.
    echo Please run Steam or ensure Dota 2 is installed.
    pause
    exit /b
)

if not exist "%DOTA_PATH%\game\dota" (
    color 0C
    echo [ERROR] Found path seems invalid: "%DOTA_PATH%"
    pause
    exit /b
)

echo [SUCCESS] Found Dota 2 at: "%DOTA_PATH%"
echo.

:: 3. Process Fonts (Following Steam Guide Method)
echo [INFO] Starting font replacement (Steam Guide Method)...
echo [INFO] This method clears the fonts folder and places the custom font.
echo.

set "TARGET_FOLDERS="%DOTA_PATH%\game\dota\panorama\fonts" "%DOTA_PATH%\game\core\panorama\fonts""

for %%F in (%TARGET_FOLDERS%) do (
    set "FOLDER=%%~F"
    if exist "!FOLDER!" (
        echo [PROCESS] Folder: "!FOLDER!"
        
        :: Create Backup Dir
        if not exist "!FOLDER!\%BACKUP_DIR_NAME%" (
            mkdir "!FOLDER!\%BACKUP_DIR_NAME!"
            echo   - Created backup folder.
        )
        
        :: Backup ALL current files
        echo   - Backing up original files...
        copy /y "!FOLDER!\*.ttf" "!FOLDER!\%BACKUP_DIR_NAME%\" >nul 2>&1
        copy /y "!FOLDER!\*.otf" "!FOLDER!\%BACKUP_DIR_NAME%\" >nul 2>&1
        
        :: Clear the folder (except the backup dir and the source font if it was there)
        echo   - Clearing folder...
        for %%A in ("!FOLDER!\*.ttf" "!FOLDER!\*.otf") do (
            del /f /q "%%A"
        )
        
        :: Copy the custom font
        echo   - Installing Monocraft...
        :: The guide mentions .otf is preferred, so we copy as .ttc and also as .otf for compatibility
        copy /y "%SOURCE_FONT%" "!FOLDER!\Monocraft.ttc" >nul
        copy /y "%SOURCE_FONT%" "!FOLDER!\Monocraft.otf" >nul
        
        :: To be 100% sure, we also rename it to 'radiance.otf' as it is the main Dota font
        copy /y "%SOURCE_FONT%" "!FOLDER!\radiance.otf" >nul
        copy /y "%SOURCE_FONT%" "!FOLDER!\radiance.ttf" >nul
        
    ) else (
        echo [SKIP] Folder not found: "!FOLDER!"
    )
)

echo.
:: 4. Create Global Config File
echo [INFO] Creating font configuration file...
set "CONF_DIR=%DOTA_PATH%\game\core\panorama\fonts\conf.d"
set "CONF_FILE=%CONF_DIR%\42-repl-global.conf"

if not exist "%CONF_DIR%" mkdir "%CONF_DIR%"

(
echo ^<?xml version='1.0'?^>
echo ^<!DOCTYPE fontconfig SYSTEM 'fonts.dtd'^>
echo ^<fontconfig^>
echo.
echo ^<match target="font"^>
echo ^<test name="family"^>
echo ^<string^>Radiance^</string^>
echo ^</test^>
echo.
echo ^<edit name="family" mode="assign"^>
echo ^<string^>Monocraft^</string^>
echo ^</edit^>
echo ^</match^>
echo.
echo ^<match target="pattern"^>
echo ^<test name="family"^>
echo ^<string^>Radiance^</string^>
echo ^</test^>
echo.
echo ^<edit name="family" mode="prepend" binding="strong"^>
echo ^<string^>Monocraft^</string^>
echo ^</edit^>
echo ^</match^>
echo.
echo ^</fontconfig^>
) > "%CONF_FILE%"

echo [SUCCESS] Config created at: "%CONF_FILE%"
echo.

:: 5. Finalize
echo ============================================================
echo           Fonts successfully replaced
echo ============================================================
echo.
echo All original fonts are moved to 'backup_fonts' folders.
echo Dota 2 will now use Monocraft instead of standard fonts.
echo.
pause
exit /b
