# $path = Split-Path -Parent -Path (Split-Path -Parent -Path $MyInvocation.MyCommand.Path)
# Import-Module "$($path)/src/Pode.psm1" -Force -ErrorAction Stop

# or just:
Import-Module Pode
Import-Module ImportExcel -Force

# create a server, and start listening on port 8086
# ? lexical scope
Start-PodeServer {
    Export-PodeModule -Name ImportExcel

    Add-PodeEndpoint -Address * -Port 8088 -Protocol Http
    # Add-PodeEndpoint -Address * -Port 8086 -Protocol Http

    # can be hit by sending a GET request to "localhost:8086/api/test"
    Add-PodeRoute -Method Get -Path '/api/test' -ScriptBlock {
        Write-Host "trying std"
        Write-PodeJsonResponse -Value @{ 'hello' = 'world'; }
    }

    # can be hit by sending a POST request to "localhost:8086/list"
    Add-PodeRoute -Method Post -Path '/list' -ContentType 'application/json' -ScriptBlock {
        Write-Host "POsting ....."
        Write-Host (gmo -List ImportExcel)
        try {
        get-process | Export-Excel ./test.xlsx
        } catch {
            Write-Host $_.Error
        }

        Write-PodeJsonResponse -Value @{ 'hello' = 'katagraphos'; 'name' = $WebEvent.Data['name']; }
    }

}