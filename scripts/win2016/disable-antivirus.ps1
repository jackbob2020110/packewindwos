Write-Host "Disabling Antivirus"
Write-Host "==================="

Set-MpPreference -DisableRealtimeMonitoring $true