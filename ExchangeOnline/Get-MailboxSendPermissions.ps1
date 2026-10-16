# Prompts for the mailbox email address you want to check
# Displays Send As and Send on Behalf permissions

$Mailbox = Read-Host "Enter mailbox email address"

Write-Host "`nSEND AS:"
Get-RecipientPermission $Mailbox |
    Where-Object {
        $_.AccessRights -contains "SendAs" -and
        $_.Trustee -ne "NT AUTHORITY\SELF"
    } |
    Select-Object Trustee, AccessRights

Write-Host "`nSEND ON BEHALF:"
Get-Mailbox $Mailbox |
    Select-Object -ExpandProperty GrantSendOnBehalfTo
