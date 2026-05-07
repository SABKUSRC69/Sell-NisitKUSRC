# Sales Data Local Server - PowerShell HTTP Server
# Serves all files in this folder at http://localhost:8080

$port = 8080
$rootPath = $PSScriptRoot

$listener = New-Object System.Net.HttpListener
$listener.Prefixes.Add("http://localhost:$port/")
$listener.Start()

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  Sales Dashboard - Local Server" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "  Server running at: " -NoNewline
Write-Host "http://localhost:$port" -ForegroundColor Green
Write-Host ""
Write-Host "  วิธีใช้:" -ForegroundColor Yellow
Write-Host "  1. เปิดเบราว์เซอร์แล้วไปที่ http://localhost:$port" -ForegroundColor White
Write-Host "  2. วางไฟล์ Excel ชื่อ 'pos.payment.xlsx' ในโฟลเดอร์นี้" -ForegroundColor White
Write-Host "  3. กดรีเฟรชหน้าเว็บ ข้อมูลจะอัปเดตอัตโนมัติ!" -ForegroundColor White
Write-Host ""
Write-Host "  กด Ctrl+C เพื่อหยุดเซิร์ฟเวอร์" -ForegroundColor Gray
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Open browser automatically
Start-Sleep -Milliseconds 500
Start-Process "http://localhost:$port/index.html"

$mimeTypes = @{
    ".html" = "text/html; charset=utf-8"
    ".css"  = "text/css; charset=utf-8"
    ".js"   = "application/javascript; charset=utf-8"
    ".json" = "application/json; charset=utf-8"
    ".png"  = "image/png"
    ".jpg"  = "image/jpeg"
    ".jpeg" = "image/jpeg"
    ".svg"  = "image/svg+xml"
    ".ico"  = "image/x-icon"
    ".xlsx" = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
    ".xls"  = "application/vnd.ms-excel"
}

while ($listener.IsListening) {
    try {
        $context  = $listener.GetContext()
        $request  = $context.Request
        $response = $context.Response

        # CORS headers (required so fetch() from HTML can access files)
        $response.Headers.Add("Access-Control-Allow-Origin", "*")
        $response.Headers.Add("Access-Control-Allow-Methods", "GET, OPTIONS")
        $response.Headers.Add("Cache-Control", "no-cache, no-store, must-revalidate")

        $urlPath = $request.Url.LocalPath
        if ($urlPath -eq "/") { $urlPath = "/index.html" }

        # Decode URL encoding (%E0%B8%82 etc.)
        $decodedPath = [System.Uri]::UnescapeDataString($urlPath)
        $filePath = Join-Path $rootPath $decodedPath.TrimStart("/").Replace("/", "\")

        Write-Host "  $(Get-Date -Format 'HH:mm:ss')  $($request.HttpMethod) $urlPath" -ForegroundColor DarkGray

        if ((Test-Path $filePath) -and (-not (Get-Item $filePath).PSIsContainer)) {
            $ext = [System.IO.Path]::GetExtension($filePath).ToLower()
            $mime = if ($mimeTypes.ContainsKey($ext)) { $mimeTypes[$ext] } else { "application/octet-stream" }

            $content = [System.IO.File]::ReadAllBytes($filePath)
            $response.StatusCode = 200
            $response.ContentType = $mime
            $response.ContentLength64 = $content.Length
            $response.OutputStream.Write($content, 0, $content.Length)
        } else {
            $body = [System.Text.Encoding]::UTF8.GetBytes("404 Not Found: $decodedPath")
            $response.StatusCode = 404
            $response.ContentType = "text/plain; charset=utf-8"
            $response.ContentLength64 = $body.Length
            $response.OutputStream.Write($body, 0, $body.Length)
        }

        $response.OutputStream.Close()
    } catch {
        # Silently ignore disconnects
    }
}

$listener.Stop()
