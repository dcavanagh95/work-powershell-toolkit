# Add a user to multiple distribution groups

$User = Read-Host "Enter user email address"

$Groups = @(
    "group1@example.com",
    "group2@example.com",
    "group3@example.com"
)

foreach ($Group in $Groups) {

    try {
        Add-DistributionGroupMember -Identity $Group -Member $User -ErrorAction Stop
        Write-Host "SUCCESS: Added $User to $Group" -ForegroundColor Green
    }
    catch {
        Write-Host "FAILED: $Group" -ForegroundColor Red
        Write-Host $_.Exception.Message -ForegroundColor Yellow
    }
}
