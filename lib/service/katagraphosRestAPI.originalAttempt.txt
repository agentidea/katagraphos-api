Import-Module Pode -MaximumVersion 2.99.99 -Force
Import-Module Pode.Web.psm1 -Force
Import-Module ImportExcel -Force

Import-PodeModule -Path '../common/utils.psm1'
Import-PodeModule -Path '../common/psRestAPI.psm1'


# error's here????

#Import-PodeModule -Path '../config/local.psm1'

# Get-PodeWildcardFiles: /home/grantsteinfeld/.local/share/powershell/Modules/Pode/2.7.1/Public/Utilities.ps1:440:50
# Line |
# 440 |              $paths = Get-PodeWildcardFiles -Path $Path -RootPath $roo …
#     |                                                   ~~~~~
#     | Cannot bind argument to parameter 'Path' because it is an
#     | empty string.

# Exception: /home/grantsteinfeld/.local/share/powershell/Modules/Pode/2.7.1/Public/Utilities.ps1:453:9
# Line |
# 453 |          throw "Failed to import module: $(Protect-PodeValue -Value $P …
#     |          ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#     | Failed to import module: 


Start-PodeServer -StatusPageExceptions Show {
    Export-PodeModule -Name ImportExcel

    #$temp_storage_path = Join-Path (Get-PodeServerPath) "..\temp_storage\"
    
    # add a simple endpoint
    Add-PodeEndpoint -Address * -Port 8090 -Protocol Http
    New-PodeLoggingMethod -Terminal | Enable-PodeErrorLogging

    Add-PodeRoute -Method Get -Path '/api/ping' -ScriptBlock {
        $timestamp = GetTimestamp
        Write-PodeJsonResponse -Value @{ 
            'ping'     = 'pong';
            'timestamp' = $timestamp;
        }
    }



    # Add-PodeRoute -Method Post -Path '/api/record/:worksheetName' -ScriptBlock {

    #     $worksheetName = $WebEvent.Parameters['worksheetName']
    #     $path = Join-Path (Get-PodeServerPath) "..\temp_storage\$worksheetName.xlsx"
    #     $records = foreach ($item in $WebEvent.Data) {
    #         [ PSCustomObject ] $item 
    #     }

    #     #write to temp storage
    #     $records | Export-Excel -WorksheetName Log -TableName Log -Path $path
        

    #     # read from temp storage and use PSAdvantage to update Katagraphos Storage PRIVATE GitHub repository
       
    #     # return ack
    #     Write-PodeJsonResponse -Value @{ 'dataStat' = $path; }
    # }


    # Add-PodeRoute -Method Get -Path '/api/read/:worksheetName' -ScriptBlock {
    #     Write-Host "read a list"

    #     $worksheetName = $WebEvent.Parameters['worksheetName']
    #     $path = Join-Path (Get-PodeServerPath) "..\storage\$worksheetName.xlsx"
    #     $Data = Import-Excel $path 
    #     Write-PodeJsonResponse -Value @{ 'dataStat' = $Data; }
    # }
}