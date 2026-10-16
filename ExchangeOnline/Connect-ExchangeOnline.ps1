# Connect to Exchange Online
# Replace with your Exchange Online admin account
# DisableWAM can be used as a temporary workaround for WAM authentication issues

$UPN = "admin@contoso.com"

Connect-ExchangeOnline -UserPrincipalName $UPN -DisableWAM
