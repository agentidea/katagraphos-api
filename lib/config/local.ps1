# Development configuration

function GetTemporaryFileSytemPath {
    return Join-Path (Get-PodeServerPath) "..\temp_storage\"
}