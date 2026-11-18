# Application Management Menu
# Template for managing application services and configuration files

Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass -Force

# Application services
$Services = @(
    "Application Service"
    "Application Module Server"
    "Application Module Server v2"
    "Application Routing Server"
)

# Configuration files
$ConfigFile1 = "C:\Program Files\Application\Config\config.properties"
$ConfigFile2 = "C:\Program Files\Application\Config\application.xml"

do {
    Clear-Host

    Write-Host "=============================="
    Write-Host "   Application Management"
    Write-Host "=============================="
    Write-Host ""
    Write-Host "1. Start Application Services"
    Write-Host "2. Stop Application Services"
    Write-Host "3. Open Configuration Files"
    Write-Host "4. Exit"
    Write-Host ""

    $Choice = Read-Host "Select an option"

    switch ($Choice) {

        "1" {
            Write-Host "`nStarting application services..." -ForegroundColor Green

            foreach ($Service in $Services) {
                Set-Service $Service -StartupType Automatic -ErrorAction Continue
                Start-Service $Service -ErrorAction Continue
            }

            Start-Process services.msc

            Write-Host "`nDone." -ForegroundColor Green
            Read-Host "Press Enter to return to menu"
        }

        "2" {
            Write-Host "`nStopping application services..." -ForegroundColor Yellow

            foreach ($Service in $Services) {
                Stop-Service $Service -Force -ErrorAction Continue
                Set-Service $Service -StartupType Disabled -ErrorAction Continue
            }

            Start-Process services.msc

            Write-Host "`nDone." -ForegroundColor Yellow
            Read-Host "Press Enter to return to menu"
        }

        "3" {
            Write-Host "`nOpening configuration files..." -ForegroundColor Cyan

            Start-Process notepad.exe $ConfigFile1
            Start-Process notepad.exe $ConfigFile2

            Write-Host "`nConfiguration files opened." -ForegroundColor Cyan
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
