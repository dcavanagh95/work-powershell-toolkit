# Manage users in AD from one menu​‌
# Features: search users by name, username or email, reset passwords, unlock user accounts, force password change at next logon and view user account details

function Show-Banner {
    Clear-Host
    Write-Host "===================================" -ForegroundColor Cyan
    Write-Host " UserManagementTool" -ForegroundColor Cyan
    Write-Host "===================================" -ForegroundColor Cyan
    Write-Host ""
}

function Search-User {

    while ($true) {

        Show-Banner

        $Search = Read-Host "Enter Name, Username or Email (Q=Quit)"

        if ($Search -match '^[Qq]$') {
            exit
        }

        $Users = Get-ADUser `
            -Filter "Name -like '*$Search*' -or SamAccountName -like '*$Search*' -or mail -like '*$Search*'" `
            -Properties mail,Enabled,LockedOut |
            Sort-Object Name

        if (-not $Users) {
            Write-Host ""
            Write-Host "No users found." -ForegroundColor Red
            Pause
            continue
        }

        Write-Host ""
        Write-Host "Matching Users" -ForegroundColor Green
        Write-Host "--------------"

        for ($i = 0; $i -lt $Users.Count; $i++) {
            Write-Host "[$($i + 1)] $($Users[$i].Name)"
            Write-Host "     Username : $($Users[$i].SamAccountName)"
            Write-Host "     Email    : $($Users[$i].mail)"
            Write-Host ""
        }

        $Choice = Read-Host "Select User Number (B=Back)"

        if ($Choice -match '^[Bb]$') {
            continue
        }

        if ($Choice -notmatch '^\d+$') {
            continue
        }

        if ($Choice -lt 1 -or $Choice -gt $Users.Count) {
            continue
        }

        return $Users[$Choice - 1]
    }
}

function Show-UserDetails {
    param($User)

    $User = Get-ADUser `
        $User.SamAccountName `
        -Properties mail,Enabled,LockedOut,LastLogonDate

    Write-Host ""
    Write-Host "User Details" -ForegroundColor Cyan
    Write-Host "------------"
    Write-Host "Name       : $($User.Name)"
    Write-Host "Username   : $($User.SamAccountName)"
    Write-Host "Email      : $($User.mail)"
    Write-Host "Enabled    : $($User.Enabled)"
    Write-Host "Locked Out : $($User.LockedOut)"
    Write-Host "Last Logon : $($User.LastLogonDate)"
    Write-Host ""
}

function Reset-Password {
    param($User)

    $Password = Read-Host "Enter New Password" -AsSecureString

    try {
        Set-ADAccountPassword `
            -Identity $User.SamAccountName `
            -Reset `
            -NewPassword $Password

        Write-Host ""
        Write-Host "Password reset successful." -ForegroundColor Green
    }
    catch {
        Write-Host ""
        Write-Host "Password reset failed." -ForegroundColor Red
        Write-Host $_.Exception.Message
    }

    Pause
}

function Unlock-User {
    param($User)

    try {
        Unlock-ADAccount -Identity $User.SamAccountName

        Write-Host ""
        Write-Host "Account unlocked." -ForegroundColor Green
    }
    catch {
        Write-Host ""
        Write-Host "Account is not locked or unlock failed." -ForegroundColor Yellow
    }

    Pause
}

function Set-ForcePasswordChange {
    param($User)

    try {
        Set-ADUser `
            -Identity $User.SamAccountName `
            -ChangePasswordAtLogon $true

        Write-Host ""
        Write-Host "User will be prompted to change password at next login." -ForegroundColor Green
    }
    catch {
        Write-Host ""
        Write-Host "Failed to update account." -ForegroundColor Red
    }

    Pause
}

while ($true) {

    $SelectedUser = Search-User

    while ($true) {

        Show-Banner

        Write-Host "Selected User" -ForegroundColor Green
        Write-Host "-------------"
        Write-Host "Name     : $($SelectedUser.Name)"
        Write-Host "Username : $($SelectedUser.SamAccountName)"
        Write-Host "Email    : $($SelectedUser.mail)"
        Write-Host ""

        Write-Host "1 - View User Details"
        Write-Host "2 - Reset Password"
        Write-Host "3 - Unlock Account"
        Write-Host "4 - Force Password Change at Next Login"
        Write-Host "5 - Search Another User"
        Write-Host "6 - Exit"
        Write-Host ""

        $MenuChoice = Read-Host "Select Option"

        switch ($MenuChoice) {

            "1" {
                Show-UserDetails $SelectedUser
            }

            "2" {
                Reset-Password $SelectedUser
            }

            "3" {
                Unlock-User $SelectedUser
            }

            "4" {
                Set-ForcePasswordChange $SelectedUser
            }

            "5" {
                break
            }

            "6" {
                exit
            }

            default {
                Write-Host "Invalid selection." -ForegroundColor Yellow
                Start-Sleep -Seconds 1
            }
        }
    }
}
