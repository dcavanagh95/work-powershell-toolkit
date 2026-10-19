# Create a Dynamic Distribution Group

$GroupName  = "Example-DynamicGroup"
$GroupEmail = "dynamic.group@contoso.com"
$Country    = "Example Country"
$Department = "Example Department"

# Build recipient filter
$Filter = "(CountryOrRegion -eq '$Country') -and (Department -eq '$Department')"

# Preview matching recipients
Write-Host "`nMatching recipients:`n" -ForegroundColor Cyan

Get-Recipient -Filter $Filter |
    Format-Table DisplayName,PrimarySmtpAddress,Title,Department,CountryOrRegion -AutoSize

# Confirm before creating
$Confirm = Read-Host "`nCreate dynamic distribution group '$GroupName'? (Y/N)"

if ($Confirm -eq "Y") {

    New-DynamicDistributionGroup `
        -Name $GroupName `
        -DisplayName $GroupName `
        -Alias $GroupName `
        -PrimarySmtpAddress $GroupEmail `
        -RecipientFilter $Filter

    Write-Host "`nDynamic distribution group created." -ForegroundColor Green

} else {

    Write-Host "`nNo changes made." -ForegroundColor Yellow
}
