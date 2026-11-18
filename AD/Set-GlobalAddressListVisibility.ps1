# This environment is AD-synced. Update msExchHideFromAddressLists in Active Directory,
# and the change will sync to Exchange Online

# Update the email address below and set $HideFromGAL to $true or $false
$email = "user@company.com"
$HideFromGAL = $false

$user = Get-ADUser -Filter "mail -eq '$email'" -Properties msExchHideFromAddressLists

$before = $user.msExchHideFromAddressLists

Set-ADUser -Identity $user.DistinguishedName -Replace @{msExchHideFromAddressLists=$HideFromGAL}

$after = (Get-ADUser -Identity $user.DistinguishedName -Properties msExchHideFromAddressLists).msExchHideFromAddressLists

Write-Host "User email: $email"
Write-Host "GAL Hidden Before: $before"
Write-Host "GAL Hidden After : $after"
