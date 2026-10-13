Stop-Service "InfoLink" -Force
Stop-Service "InfoLink Module Server" -Force
Stop-Service "InfoLink Module Server v2" -Force
Stop-Service "InfoLink Protocol Routing Server" -Force
 
Set-Service "InfoLink" -StartupType Disabled
 
Start-Process services.msc