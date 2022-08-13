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

        $hamchunkshackpath = "/home/grantsteinfeld/dev/katagraphos.net/api/katagraphos-api/lib/temp_storage"
        $worksheetName = $WebEvent.Parameters['worksheetName']

        #$to_do: Pester unit test this logic!!!
        $worksheetNamePlusExt = $worksheetName
        $excelExt = ".xlsx"
        
       
        if ($worksheetName -cmatch '\.[^.]+$') {
            # worksheetName has a file extesnion
            $extension = $matches[0]
            if ($extension -EQ $excelExt){
                #good nothing to do
            }
            else
            {
                throw "odd file extension, $extension, either provide no extension, or use .xlsx"
            }
        }
        else
        {
            #no ext add xlsx
            $worksheetNamePlusExt = "$worksheetName.xlsx"
        }
        

        $excelFileName = Join-Path $hamchunkshackpath $worksheetNamePlusExt

        $records = foreach ($item in $WebEvent.Data){
            [ PSCustomObject ] $item 
        }

  
        $records | Export-Excel -WorksheetName Log -TableName Log -Path $excelFileName

        write-host "saved local spreadsheet $worksheetNamePlusExt here ==> $localFileSytem"

        $owner = GetStorageRepoProject
        $repo = GetStorageRepo
        $repoPath = "user_content/Clara.Pup/$worksheetNamePlusExt"
        $token = GetGHtoken

        #Excel is BLOB/ so - Encoding byte


        $content64 = [convert]::ToBase64String((Get-Content -path $excelFileName -AsByteStream))

        $url = "https://api.github.com/repos/$owner/$repo/contents/$repoPath"


        $jsonBody = @"
        {
        "message": "Upload Excel list ",
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

       Write-PodeJsonResponse -Value @{ 
        
        'repo':"$owner/$repo";
        'repo_path' = $repoPath; }

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