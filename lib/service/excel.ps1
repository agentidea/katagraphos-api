Import-Module Pode -MaximumVersion 2.99.99 -Force
Import-Module Pode.Web.psm1 -Force
Import-Module ImportExcel -Force

Start-PodeServer -StatusPageExceptions Show {
    Export-PodeModule -Name ImportExcel


    # add a simple endpoint
    Add-PodeEndpoint -Address * -Port 8090 -Protocol Http
    New-PodeLoggingMethod -Terminal | Enable-PodeErrorLogging

    Add-PodeRoute -Method Get -Path '/api/test' -ScriptBlock {
        Write-Host "trying std"
        Write-PodeJsonResponse -Value @{ 'hello' = 'world'; }
    }

    Add-PodeRoute -Method Post -Path '/api/record' -ScriptBlock {
        Write-Host "posting a list"
        Write-Host $WebEvent.Data

        
        $path = Join-Path (Get-PodeServerPath) '..\storage\neu.xlsx'
        $records = foreach ($item in $WebEvent.Data){
            [ PSCustomObject ] $item 
        }

       $records | Export-Excel -WorksheetName Log -TableName Log -Path $path
        
       Write-PodeJsonResponse -Value @{ 'dataStat' = 'received!!'; }

    }

    Add-PodeRoute -Method Post -Path '/api/record/:worksheetName' -ScriptBlock {

        $worksheetName = $WebEvent.Parameters['worksheetName']
        $path = Join-Path (Get-PodeServerPath) "..\storage\$worksheetName.xlsx"
        $records = foreach ($item in $WebEvent.Data){
            [ PSCustomObject ] $item 
        }

       $records | Export-Excel -WorksheetName Log -TableName Log -Path $path
        
       Write-PodeJsonResponse -Value @{ 'dataStat' = $path; }
       

    }

    Add-PodeRoute -Method Get -Path '/api/read' -ScriptBlock {
        Write-Host "read a list"


        $path = Join-Path (Get-PodeServerPath) '..\storage\neu.xlsx'
        $Data = Import-Excel $path 
        Write-PodeJsonResponse -Value @{ 'dataStat' = $Data; }


    }

    Add-PodeRoute -Method Get -Path '/api/read/:worksheetName' -ScriptBlock {
        Write-Host "read a list"

        $worksheetName = $WebEvent.Parameters['worksheetName']
        $path = Join-Path (Get-PodeServerPath) "..\storage\$worksheetName.xlsx"
        $Data = Import-Excel $path 
        Write-PodeJsonResponse -Value @{ 'dataStat' = $Data; }


    }


}