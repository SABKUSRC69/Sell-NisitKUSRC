@echo off
chcp 65001 >nul
title Sales Dashboard Server
echo.
echo  กำลังเริ่มต้น Sales Dashboard Server...
echo.
PowerShell -NoProfile -ExecutionPolicy Bypass -File "%~dp0server.ps1"
echo.
echo  เซิร์ฟเวอร์หยุดทำงานแล้ว
pause
