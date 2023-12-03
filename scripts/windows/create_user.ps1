Write-Host "Creating user"
Write-Host "======================"

function CreateUser {
    if ($env:appveyor_password) {
        # password specified
        cmd /c net user $env:appveyor_user $env:appveyor_password /add /passwordchg:no /passwordreq:yes /active:yes /Y
    } else {
        # random password
        cmd /c net user $env:appveyor_user /add /active:yes /Y
    }
}

CreateUser


cmd /c net localgroup Administrators $env:appveyor_user /add
cmd /c 'winrm set winrm/config/service/auth @{Basic="true"}'

Set-LocalUser -Name $env:appveyor_user -PasswordNeverExpires:$true

Write-Host "User created"
