Write-Host "Enabling RDP..."
Set-ItemProperty -Path "HKLM:\System\CurrentControlSet\Control\Terminal Server" -Name "fDenyTSConnections" -Value 0


(Get-WmiObject -class "Win32_TSGeneralSetting" -Namespace root\cimv2\terminalservices -ComputerName $env:COMPUTERNAME -Filter "TerminalName='RDP-tcp'").SetUserAuthenticationRequired(0)

Write-Host "Enable PS Remoting"
Enable-PSRemoting -Force
Get-Service WinRM




# Disable UAC
Write-Host "Disabling UAC..."
Set-ItemProperty "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" -Name "ConsentPromptBehaviorAdmin" -Value 00000000
Set-ItemProperty "HKLM:\Software\Microsoft\Windows\CurrentVersion\Policies\System" -Name "EnableLUA" -Value "0"
Write-Host "User Access Control (UAC) has been disabled." -ForegroundColor Green  

Write-Host "Disable Firewall ..."
Set-NetFirewallProfile -Profile Domain, Public, Private -Enabled False

# Enable-NetFirewallRule -DisplayGroup "Remote Desktop"
# Enable-NetFirewallRule -DisplayGroup "Windows Remote Management"
# Enable-NetFirewallRule -DisplayGroup "Remote Event Log Management"
# Enable-NetFirewallRule -DisplayGroup "Remote Service Management"
# Enable-NetFirewallRule -DisplayGroup "Windows Firewall Remote Management"
# Enable-NetFirewallRule -DisplayGroup "Remote Volume Management"
# Enable-NetFirewallRule -DisplayGroup "File and Printer Sharing"

# Set PowerShell execution policy to unrestricted
Write-Host "Changing PS execution policy to Unrestricted"
Write-Host "============================================"
Set-ExecutionPolicy -ExecutionPolicy Unrestricted -Force -ErrorAction Ignore -Scope Process
Set-ExecutionPolicy -ExecutionPolicy Unrestricted -Force -ErrorAction Ignore
Write-Host "PS policy updated"




Write-Host "Disabling Shutdown Event Tracker..."
New-Item -Path "registry::HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows NT" -Name Reliability -Force
Set-ItemProperty -Path "registry::HKLM\SOFTWARE\Policies\Microsoft\Windows NT\Reliability" -Name "ShutdownReasonUI" -Value 0

Write-Host "Setting file extensions display..."
Set-ItemProperty -Path "registry::HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "HideFileExt" -Value 0

Write-Host "Disabling hybernation..."
Set-ItemProperty -Path "registry::HKLM\SYSTEM\CurrentControlSet\Control\Power" -Name "HibernateEnabled" -Value 0

Write-Host "Disabling Screensaver"
Set-ItemProperty "HKCU:\Control Panel\Desktop" -Name ScreenSaveActive -Value 0 -Type DWord
& powercfg -x -monitor-timeout-ac 0
& powercfg -x -monitor-timeout-dc 0

Write-Host "Setting timezone..."
& "$env:windir\system32\tzutil.exe" /s "China Standard Time"

Write-Host "Disabling Server Manager opening at logon..."
New-ItemProperty -Path "HKLM:\Software\Microsoft\ServerManager" -Name "DoNotOpenServerManagerAtLogon" -PropertyType "DWORD" -Value "0x1" -Force

Write-Host "Setting Network location to Public..."
Set-NetConnectionProfile -NetworkCategory "Public"

Write-Host "Enabling DiskPerf in Task Manager..."
Invoke-Command {diskperf -Y}

try {
    Get-ItemProperty -Path "registry::HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Server\ServerLevels" | `
    Select-Object -ExpandProperty "Server-Gui-Shell" -ErrorAction Stop | Out-Null

    Write-Host "Disabling IE Enhanced security..."
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Active Setup\Installed Components\{A509B1A7-37EF-4b3f-8CFC-4F3A74704073}" -Name "IsInstalled" -Value 0
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Active Setup\Installed Components\{A509B1A8-37EF-4b3f-8CFC-4F3A74704073}" -Name "IsInstalled" -Value 0
} catch {
    Write-Host "Disabling IE Enhanced security is irrelevant for Core installation"
}


# Disable Windows Update

Write-Host "Disabling Windows Updates"
Write-Host "========================="

$AutoUpdatePath = "HKLM:SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU"
If (Test-Path -Path $AutoUpdatePath) {
    Set-ItemProperty -Path $AutoUpdatePath -Name NoAutoUpdate -Value 1
    Write-Host "Disabled Windows Update"
}
else {
    Write-Host "Windows Update key does not exist"
}
