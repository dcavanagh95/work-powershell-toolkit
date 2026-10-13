Set-Service "InfoLink" -StartupType Automatic
 
Start-Service "InfoLink"
Start-Service "InfoLink Module Server"
Start-Service "InfoLink Module Server v2"
Start-Service "InfoLink Protocol Routing Server"
 
Start-Process services.msc