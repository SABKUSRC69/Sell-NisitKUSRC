@echo off
echo ===================================================
echo     Dashboard Cleaner - Removing Auto-Seeded Data
echo ===================================================
echo.
powershell -Command "$content = [IO.File]::ReadAllText('index.html', [Text.Encoding]::UTF8); $content = $content -replace '(?s)<script>\s*// Auto-seeded data.*?</script>\s*', ''; [IO.File]::WriteAllText('index.html', $content, [Text.Encoding]::UTF8)"
echo Done! The index.html file has been cleaned successfully.
echo.
pause
