@echo off
chcp 65001 >nul
cd /d "%~dp0"

powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp000_UploadPublicRepo.ps1"

echo.
pause

