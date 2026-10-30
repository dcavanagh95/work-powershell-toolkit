# Checks the ArchiveStatus of the specified mailbox. Enables an Exchange Online Archive Mailbox if it is not already enabled
# Requires Exchange Administrator or equivalent recipient management permissions

param(
    [Parameter(Mandatory)]
    [string]$Identity
)

try {
    $Mailbox = Get-Mailbox -Identity $Identity -ErrorAction Stop

    if ($Mailbox.ArchiveStatus -eq "Active") {
        Write-Host "[OK] Online Archive is already enabled for '$Identity'." -ForegroundColor Green
        return
    }

    Write-Host "[INFO] Online Archive is not enabled for '$Identity'." -ForegroundColor Yellow
    Write-Host "[INFO] Enabling Online Archive..." -ForegroundColor Yellow

    Enable-Mailbox -Identity $Identity -Archive -ErrorAction Stop

    Start-Sleep -Seconds 5

    $Mailbox = Get-Mailbox -Identity $Identity

    if ($Mailbox.ArchiveStatus -eq "Active") {
        Write-Host "[SUCCESS] Online Archive enabled successfully." -ForegroundColor Green
    }
    else {
        Write-Host "[WARNING] Archive enable command completed but status is not yet Active." -ForegroundColor Yellow
    }
}
catch {
    Write-Host "[ERROR] $($_.Exception.Message)" -ForegroundColor Red
}
