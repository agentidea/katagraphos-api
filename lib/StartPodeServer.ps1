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
        $localFileSytem = Join-Path GetTemporaryFileSytemPath $worksheetName
        $records = foreach ($item in $WebEvent.Data){
            [ PSCustomObject ] $item 
        }


        $records | Export-Excel -WorksheetName Log -TableName Log -Path $localFileSytem

       

        $owner = 'agentidea'
        $repo = "katagraphos-store"
        $repoPath = "user_content/Clara.Pup/$worksheetName"

        #Import-PSAdvantageConfig /home/grantsteinfeld/dev/katagraphos.net/api/katagraphos-api/lib/config/config.ps1 # imports config with GitHub Access Token

        $token = "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"




        #Excel is BLOB/ so - Encoding byte

        #$excelFileName = "/Users/grantsteinfeld/Documents/dev/katagraphos.net/api/gh-api/salesData.xlsx"
        $excelFileName = $localFileSytem
        Write-Host $excelFileName
        $content64 = [convert]::ToBase64String((Get-Content -path $excelFileName -AsByteStream))

        $url = "https://api.github.com/repos/$owner/$repo/contents/$repoPath"


        $jsonBody = @"
        {
        "message": "my commit message",
        "committer": {
            "name": "Grant Steinfeld",
            "email": "grant.steinfeld.tech@gmail.com"
        },
        "content": "$content64"
        }
"@


        $headers = @{
        Accept = "application/vnd.github+json"
        Authorization = "token $token"
        }

        Invoke-RestMethod -Method Put -Uri $url -Headers $headers -ContentType "application/json" -Body $jsonBody


# https://zeleskitech.com/2016/03/10/building-json-powershell-objects/

     

       Write-PodeJsonResponse -Value @{ 'dataLocal-Stat' = $path; }

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