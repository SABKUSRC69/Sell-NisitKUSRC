@echo off
chcp 65001 >nul
echo ===================================================
echo     Updating website... (Cloudflare/GitHub)
echo ===================================================
echo.
echo [1/3] Preparing files...
git add .
echo [2/3] Saving changes...
git commit -m "Update dashboard and fix bugs"
echo [3/3] Uploading...
git push origin main
echo.
echo ===================================================
echo SUCCESS! Please wait 1-2 minutes and refresh your website.
echo ===================================================
pause
