﻿Write-Host "Installing IIS..." -ForegroundColor Cyan

#webpicmd /Install /Products:"IIS7" /AcceptEula
Write-Host "Main command..."
cmd /c start /wait dism /Online /Enable-Feature /FeatureName:IIS-WebServer /FeatureName:IIS-WebServerManagementTools /FeatureName:IIS-WebServerRole /FeatureName:IIS-ManagementConsole /FeatureName:IIS-ApplicationDevelopment /FeatureName:IIS-ASPNET /FeatureName:IIS-ASPNET45 /FeatureName:IIS-NetFxExtensibility /FeatureName:IIS-NetFxExtensibility45 /FeatureName:NetFx4Extended-ASPNET45 /FeatureName:IIS-CommonHttpFeatures /FeatureName:IIS-DefaultDocument /FeatureName:IIS-DirectoryBrowsing /FeatureName:IIS-HealthAndDiagnostics /FeatureName:IIS-HttpLogging /FeatureName:IIS-LoggingLibraries /FeatureName:IIS-RequestMonitor /FeatureName:IIS-HttpCompressionStatic /FeatureName:IIS-HttpErrors /FeatureName:IIS-HttpRedirect /FeatureName:IIS-IIS6ManagementCompatibility /FeatureName:IIS-ISAPIExtensions /FeatureName:IIS-ISAPIFilter /FeatureName:IIS-WebSockets /FeatureName:IIS-RequestFiltering /FeatureName:IIS-Performance /FeatureName:IIS-Security /FeatureName:IIS-StaticContent /FeatureName:WAS-ConfigurationAPI /FeatureName:WAS-NetFxEnvironment /FeatureName:WAS-ProcessModel /FeatureName:WAS-WindowsActivationService /All

Write-Host "ASP.NET 4.5..."
cmd /c start /wait dism /Online /Enable-Feature /FeatureName:IIS-ASPNET45 /All

Write-Host "WAS..."
Install-WindowsFeature "Web-Server","Web-Http-Errors","Web-App-Dev","Web-Asp-Net","Web-Net-Ext","Web-ASP","Web-CGI","Web-ISAPI-Ext","Web-ISAPI-Filter","Web-Includes","Web-Basic-Auth","Web-Windows-Auth","Web-Mgmt-Compat","Web-Metabase","Web-WMI","Web-Lgcy-Scripting","Web-Lgcy-Mgmt-Console","NET-HTTP-Activation","NET-HTTP-Activation","NET-Non-HTTP-Activ","NET-WCF-HTTP-Activation45","NET-WCF-MSMQ-Activation45","NET-WCF-Pipe-Activation45","NET-WCF-TCP-Activation45","AS-NET-Framework"

Write-Host "Disabling services..."
Stop-Service IISADMIN
Stop-Service NetMsmqActivator
Stop-Service NetPipeActivator
Stop-Service NetTcpActivator
Stop-Service NetTcpPortSharing
Stop-Service W3SVC
Stop-Service WAS

Set-Service IISADMIN -StartupType Manual
Set-Service NetMsmqActivator -StartupType Manual
Set-Service NetPipeActivator -StartupType Manual
Set-Service NetTcpActivator -StartupType Manual
Set-Service NetTcpPortSharing -StartupType Manual
Set-Service WAS -StartupType Manual
Set-Service W3SVC -StartupType Manual


Write-Host "IIS installed" -ForegroundColor Green