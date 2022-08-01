function GetTimestamp {
    Get-Date -Format o | ForEach-Object { $_ -replace ":", "." }
    
}