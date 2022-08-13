Import-Module Pode -MaximumVersion 2.99.99 -Force
Import-Module Pode.Web.psm1 -Force
Import-Module ImportExcel -Force

# Import-Module './common/utils.psm1'
# Import-Module './config/local.psm1'

Start-PodeServer -StatusPageExceptions Show {
    
    Import-PodeModule -Path './common/utils.psm1'
    Import-PodeModule -Path './config/local.psm1'
    Export-PodeModule -Name ImportExcel


    # add a simple endpoint
    Add-PodeEndpoint -Address * -Port 8090 -Protocol Http
    New-PodeLoggingMethod -Terminal | Enable-PodeErrorLogging

    Add-PodeRoute -Method Get -Path '/api/ping' -ScriptBlock {
       
        Write-PodeJsonResponse -Value @{ 
            'company' = GetStorageRepoProject;
            'timestamp' = GetTimestamp;
         }
    }

    Add-PodeRoute -Method Post -Path '/api/record/:worksheetName' -ScriptBlock {

        $worksheetName = $WebEvent.Parameters['worksheetName']
        $path = Join-Path GetTemporaryFileSytemPath $worksheetName
        $records = foreach ($item in $WebEvent.Data){
            [ PSCustomObject ] $item 
        }

        #https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/new-temporaryfile?view=powershell-7.2

        $TempFile = New-TemporaryFile

       $records | Export-Excel -WorksheetName Log -TableName Log -Path $TempFile
     

       Write-PodeJsonResponse -Value @{ 'dataStat' = $path; }

    }

    Add-PodeRoute -Method Get -Path '/api/read' -ScriptBlock {
        Write-Host "$to del" 
        # read all lists"


        # $path = Join-Path (Get-PodeServerPath) '..\storage\neu.xlsx'
        # $Data = Import-Excel $path 
        Write-PodeJsonResponse -Value @{ 'status' = 'nyi'; }


    }

    Add-PodeRoute -Method Get -Path '/api/read/:worksheetName' -ScriptBlock {
        Write-Host "read a list"

        $worksheetName = $WebEvent.Parameters['worksheetName']
        $path = Join-Path GetTemporaryFileSytemPath $worksheetName
        $Data = Import-Excel $path 
        Write-PodeJsonResponse -Value @{ 'dataStat' = $Data; }


    }
}