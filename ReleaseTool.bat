@echo off
setlocal EnableDelayedExpansion

:: 0. 讓使用者輸入版本號
set /p VERSION="Please enter version number (e.g., 1.0): "

:: 檢查是否輸入版本號
if "!VERSION!"=="" (
    echo Error: No version number entered!
    exit /b 1
)

:: 設定目標資料夾名稱
set "RELEASE_DIR=Release\v!VERSION!"

:: 1. 若資料夾存在則刪除，然後建立新資料夾
if exist "!RELEASE_DIR!" (
    echo Deleting existing !RELEASE_DIR! ...
    rd /s /q "!RELEASE_DIR!"
)
echo Creating directory !RELEASE_DIR! ...
mkdir "Release" 2>nul
mkdir "!RELEASE_DIR!" 2>nul
mkdir "!RELEASE_DIR!\git" 2>nul

:: 2. 複製指定檔案和資料夾到目標路徑
echo Copying files to !RELEASE_DIR! ...
for %%f in ("git\*") do (
    copy "%%f" "!RELEASE_DIR!\git" /Y >nul 2>nul
)
copy "docker-compose.yml" "!RELEASE_DIR!\docker-compose.yml" /Y >nul 2>nul
copy "Dockerfile" "!RELEASE_DIR!\Dockerfile" /Y >nul 2>nul
copy "Read.md" "!RELEASE_DIR!\Read.md" /Y >nul 2>nul
copy "set.bat" "!RELEASE_DIR!\set.bat" /Y >nul 2>nul

:: 3. 使用 7-Zip 壓縮到 Release 資料夾
echo Compressing to Release\v!VERSION!.zip ...
"C:\Program Files\7-Zip\7z.exe" a -tzip "Release\v!VERSION!.zip" "!RELEASE_DIR!" >nul 2>nul
if errorlevel 1 (
    echo Error: Compression failed! Please ensure 7-Zip is installed at 'C:\Program Files\7-Zip\7z.exe'.
) else (
    echo Done! Generated Release\v!VERSION!.zip
)

pause