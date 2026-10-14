# Connect to Exchange Online
# Replace with your Exchange Online admin account

$UPN = "admin@contoso.com"

Connect-ExchangeOnline -UserPrincipalName $UPN -DisableWAM
