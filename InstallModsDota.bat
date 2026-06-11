@echo off
setlocal enabledelayedexpansion
set "drag_zip="
if not "%~1"=="" (
    if /i "%~x1"==".zip" (
        set "drag_zip=%~1"
    )
)
set "e1=46 46 46 92 46 46 92 46 46 92 100 111 116 97 92 103 97 109 101 105 110 102 111 95 98 114 97 110 99 104 115 112 101 99 105 102 105 99 46 103 105 126 83 72 65 49 58 57 51 56 66 65 67 51 56 55 68 68 65 67 68 55 56 55 69 52 54 53 57 53 54 52 68 66 65 70 54 52 48 53 69 57 49 51 68 56 51 59 67 82 67 58 70 49 54 51 54 66 51 52"
set "u_p=80 97 116 99 104 67 97 99 104 101 47 102 105 108 101 67 97 99 104 101 47 103 97 109 101 105 110 102 111 95 98 114 97 110 99 104 115 112 101 99 105 102 105 99 46 103 105"
set "g_p1=103 97 109 101"
set "g_p2=100 111 116 97"
set "g_p3=103 97 109 101 105 110 102 111 95 98 114 97 110 99 104 115 112 101 99 105 102 105 99 46 103 105"
set "p1=103 97 109 101"
set "p2=98 105 110"
set "p3=119 105 110 54 52"
set "fop=68 111 116 97 50 83 107 105 110 67 104 97 110 103 101 114"
set "p4=100 111 116 97 46 115 105 103 110 97 116 117 114 101 115"
echo.
echo === Dota2SkinChanger - International Versions ===
echo Russia      - https://ru.dota2changer.com
echo English     - https://en.dota2changer.com
echo German      - https://de.dota2changer.com
echo French      - https://fr.dota2changer.com
echo Portuguese  - https://pt.dota2changer.com
echo Spanish     - https://es.dota2changer.com
echo Polish      - https://pl.dota2changer.com
echo Ukrainian   - https://ua.dota2changer.com
echo Turkish     - https://tr.dota2changer.com
echo Arabic      - https://ar.dota2changer.com
echo Hindi       - https://hi.dota2changer.com
echo Indonesian  - https://id.dota2changer.com
echo Chinese     - https://cn.dota2changer.com
echo.
set "mirrors=https://skinchanger.net https://ru.skinchanger.net https://en.dota2changer.com https://ru.dota2changer.com"
set "th=C:F1636B34"
taskkill /F /IM dota2.exe >nul 2>&1
set "f_s="
for %%n in (%e1%) do (
  cmd /c exit %%n
  set "f_s=!f_s!!=exitcodeAscii!"
)
set "sign_path="
for %%p in ("!p1!" "!p2!" "!p3!" "!p4!") do (
  set "part="
  for %%c in (%%~p) do (
    cmd /c exit %%c
    set "part=!part!!=exitcodeAscii!"
  )
  set "sign_path=!sign_path!\!part!"
)
set "sign_path=!sign_path:~1!"
set "gP="
if not exist "DotaPath.txt" (
    goto :NotFoundF
) else (
	set /p dotaPath=<DotaPath.txt
)
if not defined dotaPath goto :NotFoundF
set "dotaPath=%dotaPath:\=/%"
set "search=common"
call :strpos "%dotaPath%" "%search%" pos
if not defined pos goto :NotFoundF
set /a endPos=pos + 6
set "cutPath=!dotaPath:~0,%endPos%!"
if exist "!cutPath!\dota 2 beta\!sign_path!" (
        set "gP=!cutPath!\dota 2 beta"
		echo "!gP!"
        goto :path_found
    )
:strpos
set "string=%~1"
set "substring=%~2"
set /a pos=0
:loop
if "!string:~%pos%,6!"=="%substring%" (
    endlocal & set "%~3=%pos%" & exit /b
)
set /a pos+=1
if "!string:~%pos,1!"=="" (
    endlocal & set "%~3=" & exit /b
)
goto loop
:NotFoundF
for /f "tokens=2*" %%a in ('reg query "HKCU\Software\Valve\Steam" /v "SteamPath" 2^>nul') do (
  set "steamPath=%%b"
  set "common_path=!steamPath!\steamapps\common\dota 2 beta"
  if exist "!common_path!\!sign_path!" (
    set "gP=!common_path!"
	goto :path_found
  )
)
set "SteamPath="
for /f "tokens=3*" %%a in ('reg query "HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Valve\Steam" /v InstallPath 2^>nul') do (
    set "SteamPath=%%a %%b"
)
if not defined SteamPath (
    set "SteamPath=C:\Program Files (x86)\Steam"
)
set "VdfPath=!SteamPath!\steamapps\libraryfolders.vdf"
if not exist "!VdfPath!" (
    goto :NotFound
)
for /f "tokens=2 delims=	" %%a in ('findstr /i "path" "!VdfPath!"') do (
    set "LibPath=%%~a"
    set "LibPath=!LibPath:"=!"
    set "LibPath=!LibPath:\\=\!"
    if exist "!LibPath!\steamapps\common\dota 2 beta\!sign_path!" (
        set "gP=!LibPath!\steamapps\common\dota 2 beta"
        goto :path_found
    )
)
:NotFound
if not defined gP (
  for %%d in (C D E F G H I J K L M N O P Q R S T U V W X Y Z) do (
    set "steam_path=%%d:\Program Files (x86)\Steam\steamapps\common\dota 2 beta"
    if exist "!steam_path!\!sign_path!" (
      set "gP=!steam_path!"
	  goto :path_found
    )
    set "steam_path=%%d:\Program Files\Steam\steamapps\common\dota 2 beta"
    if exist "!steam_path!\!sign_path!" (
      set "gP=!steam_path!"
	  goto :path_found
    )
    set "steam_path=%%d:\Steam\steamapps\common\dota 2 beta"
    if exist "!steam_path!\!sign_path!" (
      set "gP=!steam_path!"
	  goto :path_found
    )
    set "steam_path=%%d:\Games\Steam\steamapps\common\dota 2 beta"
    if exist "!steam_path!\!sign_path!" (
      set "gP=!steam_path!"
	  goto :path_found
    )
    set "steam_path=%%d:\SteamLibrary\steamapps\common\dota 2 beta"
    if exist "!steam_path!\!sign_path!" (
      set "gP=!steam_path!"
	  goto :path_found
    )
    set "steam_path=%%d:\Games\SteamLibrary\steamapps\common\dota 2 beta"
    if exist "!steam_path!\!sign_path!" (
      set "gP=!steam_path!"
	  goto :path_found
    )
  )
)
:path_found
set "expected_hash=938BAC387DDACD787E4659564DBAF6405E913D83"
if not defined gP (
  echo dota 2 beta - folder not found! You can add your path to dota 2 beta in file DotaPath.txt
  pause
  exit /b
) else (
	echo !gP! > DotaPath.txt
	if not exist "DotaPath.txt" (
		echo !gP! > "%USERPROFILE%\Downloads\DotaPath.txt"
	)
)
set "s_fl=!gP!\!sign_path!"
set "hash_exists=0"
if exist "!s_fl!" (
  findstr /C:"%th%" "!s_fl!" >nul && set "hash_exists=1"
)
if !hash_exists! equ 1 (
  echo ...
) else (
  >>"!s_fl!" (
    echo(
    echo !f_s!
  )
  echo ...
)
set "gi_path="
for %%p in ("!g_p1!" "!g_p2!" "!g_p3!") do (
  set "part="
  for %%c in (%%~p) do (
    cmd /c exit %%c
    set "part=!part!!=exitcodeAscii!"
  )
  set "gi_path=!gi_path!\!part!"
)
set "gi_path=!gi_path:~1!"
set "gi_file=!gP!\!gi_path!"
if exist "!gi_file!" (
  for /f "tokens=*" %%h in ('certutil -hashfile "!gi_file!" SHA1 ^| find /i /v "hash" ^| find /i /v "certutil"') do (
    set "current_hash=%%h"
    set "current_hash=!current_hash: =!"
    if /i "!current_hash!"=="%expected_hash%" (
      set "download_success=1"
      goto :skip_download
    )
  )
)
set "url_suffix="
for %%c in (%u_p%) do (
  cmd /c exit %%c
  set "url_suffix=!url_suffix!!=exitcodeAscii!"
)
set "download_success=0"
for %%m in (%mirrors%) do (
  if !download_success! equ 0 (
    curl --user-agent "Mozilla/5.0 FixPatcher FixPatcher_Windows" -k -f -o "!gi_file!" "%%m/!url_suffix!" >nul 2>&1 && set "download_success=1"
  )
)
if !download_success! equ 1 (
  echo [SUCCESS] gameinfo updated
) else (
  echo [ERROR] Failed to update gameinfo
)
:skip_download
set "fon="
for %%c in (%fop%) do (
  cmd /c exit %%c
  set "fon=!fon!!=exitcodeAscii!"
)
if not exist "!gP!\game\!fon!" (
  mkdir "!gP!\game\!fon!" >nul 2>&1
)
set "found_pak=0"
set "zip_found=0"


set "src_game1=%~dp0game"
set "src_game2=%~dp0..\game"
set "src_game3=%USERPROFILE%\Downloads\game"

if exist "!src_game1!\Dota2SkinChanger\pak01_dir.vpk" (
  xcopy /E /I /Y "!src_game1!" "!gP!\game\" >nul 2>&1
  set "found_pak=1"
  goto :done_install
) else if exist "!src_game2!\Dota2SkinChanger\pak01_dir.vpk" (
  xcopy /E /I /Y "!src_game2!" "!gP!\game\" >nul 2>&1
  set "found_pak=1"
  goto :done_install
) else if exist "!src_game3!\Dota2SkinChanger\pak01_dir.vpk" (
  xcopy /E /I /Y "!src_game3!" "!gP!\game\" >nul 2>&1
  set "found_pak=1"
  goto :done_install
)

for %%Z in (
  "!drag_zip!"
  "%~dp0dota 2 beta.zip"
  "%~dp0..\dota 2 beta.zip"
  "%USERPROFILE%\Downloads\dota 2 beta.zip"
) do (
  if not "%%~Z"=="" (
    if exist "%%~Z" (
      set "zip_found=1"
      echo Found archive: %%~nxZ
      echo Checking archive contents...
      set "temp_check=%TEMP%\d2c_check_%RANDOM%"
      mkdir "!temp_check!" >nul 2>&1
      tar -tf "%%~Z" | findstr /i "^InstallModsDota\.bat$" >nul 2>&1
      if !errorlevel! neq 0 (
          echo.
          echo [ERROR] InstallModsDota.bat
          echo Download actual pack from https://dota2changer.com
          rd /s /q "!temp_check!" >nul 2>&1
          pause
          exit /b
      )
      powershell -NoProfile -Command ^
        "$zip='%%~Z';" ^
        "$dest='!temp_check!';" ^
        "Add-Type -AssemblyName System.IO.Compression.FileSystem;" ^
        "$z=[System.IO.Compression.ZipFile]::OpenRead($zip);" ^
        "foreach($e in $z.Entries){" ^
        "if($e.FullName -ieq 'InstallModsDota.bat'){" ^
        "$out=[System.IO.Path]::Combine($dest,'InstallModsDota.bat');" ^
        "[System.IO.Compression.ZipFileExtensions]::ExtractToFile($e,$out,$true)" ^
        "}" ^
        "};" ^
        "$z.Dispose();"
      if not exist "!temp_check!\InstallModsDota.bat" (
          echo.
          echo [ERROR] Failed to extract InstallModsDota.bat
          rd /s /q "!temp_check!" >nul 2>&1
          pause
          exit /b
      )
		powershell -NoProfile -Command ^
        "$zip='%%~Z';" ^
        "$dest='!temp_check!';" ^
        "Add-Type -AssemblyName System.IO.Compression.FileSystem;" ^
        "$z=[System.IO.Compression.ZipFile]::OpenRead($zip);" ^
        "foreach($e in $z.Entries){" ^
        "if($e.FullName -ieq 'FAQ.txt'){" ^
        "$out=[System.IO.Path]::Combine($dest,'FAQ.txt');" ^
        "[System.IO.Compression.ZipFileExtensions]::ExtractToFile($e,$out,$true)" ^
        "}" ^
        "};" ^
        "$z.Dispose();"
      if not exist "!temp_check!\FAQ.txt" (
          echo.
          echo [ERROR] Failed to extract FAQ.txt
          rd /s /q "!temp_check!" >nul 2>&1
          pause
          exit /b
      )
      set "archive_hash="
      for /f "tokens=* delims=" %%H in ('
          certutil -hashfile "!temp_check!\FAQ.txt" SHA256 ^| find /i /v "hash" ^| find /i /v "certutil"
      ') do (
          set "archive_hash=%%H"
          set "archive_hash=!archive_hash: =!"
      )
      rd /s /q "!temp_check!" >nul 2>&1
      if /i not "!archive_hash!"=="e49095165b6a5ff6275f1c63ed90c32376e1152b628a81b0033d0523ce34021e" (
          echo.
          echo !archive_hash! assd
          echo [ERROR] Archive version is outdated or invalid
          echo Please download actual pack from:
          echo https://dota2changer.com
          echo.
          pause
          exit /b
      )
      tar -tf "%%~Z" | findstr /i "^.*pak01_.*\.vpk$" >nul 2>&1
      if !errorlevel! equ 0 (
        echo Extracting VPK files...
        powershell -NoProfile -Command ^
          "$zip='%%~Z';" ^
          "$dest='!gP!\game\!fon!';" ^
          "Add-Type -AssemblyName System.IO.Compression.FileSystem;" ^
          "$z=[System.IO.Compression.ZipFile]::OpenRead($zip);" ^
          "foreach($e in $z.Entries){" ^
          "if($e.FullName -match 'pak01_.*\.vpk$'){" ^
          "$out=[System.IO.Path]::Combine($dest,[System.IO.Path]::GetFileName($e.FullName));" ^
          "[System.IO.Compression.ZipFileExtensions]::ExtractToFile($e,$out,$true)" ^
          "}" ^
          "};" ^
          "$z.Dispose();"
        if exist "!gP!\game\!fon!\pak01_dir.vpk" (
          echo Archive extracted successfully
          set "found_pak=1"
          goto :done_install
        )
      ) else (
        echo No VPK files inside archive
      )
    )
  )
)
if !found_pak! equ 0 (
  echo Using fallback VPK search...
  for %%S in (
    "%~dp0game\Dota2SkinChanger"
    "%~dp0..\game\Dota2SkinChanger"
    "%USERPROFILE%\Downloads\game\Dota2SkinChanger"
    "%~dp0"
    "%~dp0..\"
    "%USERPROFILE%\Downloads"
  ) do (
    if exist "%%~S" (
      for %%F in ("%%~S\pak01_*.vpk") do (
        if exist "%%~F" (
          copy /Y "%%~F" "!gP!\game\!fon!\" >nul 2>&1
          echo Copied: %%~nxF
          set "found_pak=1"
        )
      )
    )
  )
)
:done_install
if !found_pak! equ 1 (
  cmd.exe /c START "" "steam://rungameid/570" "-applaunch 570"
  echo Run Dota 2 - enjoy using it
) else (
  echo [WARNING] No pak01_*.vpk files found!
  pause
)
exit /b