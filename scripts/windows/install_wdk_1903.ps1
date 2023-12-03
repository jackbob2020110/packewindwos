Write-Host "Installing WDK 1903 (10.0.18362.1)..." -ForegroundColor Cyan

Write-Host "Downloading..."
$exePath = "$env:temp\wdksetup.exe"
(New-Object Net.WebClient).DownloadFile('https://go.microsoft.com/fwlink/?linkid=2085767', $exePath)
Write-Host "Installing..."
cmd /c start /wait $exePath /quiet
Remove-Item $exePath -Force -ErrorAction Ignore
Write-Host "OK"

$vsPath = "${env:ProgramFiles(x86)}\Microsoft Visual Studio\2019\Community"
if (-not (Test-Path $vsPath)) {
    $vsPath = "${env:ProgramFiles(x86)}\Microsoft Visual Studio\2019\Preview"
}

if (-not (Test-Path $vsPath)) {
  return
}

Write-Host "Installed" -ForegroundColor Green