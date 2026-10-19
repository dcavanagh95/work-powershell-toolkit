# InfoLink Management Menu
# Run PowerShell as Administrator

Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass -Force

do {
    Clear-Host

    Write-Host "=============================="
    Write-Host "     InfoLink Management"
    Write-Host "=============================="
    Write-Host ""
    Write-Host "1. Start InfoLink Services"
    Write-Host "2. Stop InfoLink Services"
    Write-Host "3. Open InfoLink Config Files"
    Write-Host "4. Exit"
    Write-Host ""

    $Choice = Read-Host "Select an option"

    switch ($Choice) {

        "1" {
            Write-Host "`nStarting InfoLink services..." -ForegroundColor Green

            Set-Service "InfoLink" -StartupType Automatic

            Start-Service "InfoLink" -ErrorAction Continue
            Start-Service "InfoLink Module Server" -ErrorAction Continue
            Start-Service "InfoLink Module Server v2" -ErrorAction Continue
            Start-Service "InfoLink Protocol Routing Server" -ErrorAction Continue

            Start-Process services.msc

            Write-Host "`nDone." -ForegroundColor Green
            Read-Host "Press Enter to return to menu"
        }

        "2" {
            Write-Host "`nStopping InfoLink services..." -ForegroundColor Yellow

            Stop-Service "InfoLink" -Force -ErrorAction Continue
            Stop-Service "InfoLink Module Server" -Force -ErrorAction Continue
            Stop-Service "InfoLink Module Server v2" -Force -ErrorAction Continue
            Stop-Service "InfoLink Protocol Routing Server" -Force -ErrorAction Continue

            Set-Service "InfoLink" -StartupType Disabled

            Start-Process services.msc

            Write-Host "`nDone." -ForegroundColor Yellow
            Read-Host "Press Enter to return to menu"
        }

        "3" {
            Write-Host "`nOpening InfoLink configuration files..." -ForegroundColor Cyan

            Start-Process notepad.exe "C:\Program Files\InfoLink\COMServer\module-conf\module-server.properties.local"
            Start-Process notepad.exe "C:\Program Files\InfoLink\AppServer\standalone\configuration\standalone-full.xml"

            Write-Host "`nConfig files opened." -ForegroundColor Cyan
            Read-Host "Press Enter to return to menu"
        }

        "4" {
            Write-Host "`nExiting..."
        }

        default {
            Write-Host "`nInvalid option. Enter 1, 2, 3 or 4." -ForegroundColor Red
            Start-Sleep -Seconds 2
        }
    }

} while ($Choice -ne "4")
