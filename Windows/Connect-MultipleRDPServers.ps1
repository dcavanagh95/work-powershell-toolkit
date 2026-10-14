$Servers = @(
    "SERVER01",
    "SERVER02",
    "SERVER03"
)

foreach ($Server in $Servers) {
    Write-Host "Opening $Server..."
    Start-Process mstsc.exe -ArgumentList "/v:$Server"
    Start-Sleep -Milliseconds 500
}
