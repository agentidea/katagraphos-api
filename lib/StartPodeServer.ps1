Import-Module Pode -MaximumVersion 2.99.99 -Force
Import-Module Pode.Web.psm1 -Force
Import-Module ImportExcel -Force

Start-PodeServer -StatusPageExceptions Show {
    
    Import-PodeModule -Path './common/utils.psm1'
    Import-PodeModule -Path './config/local.psm1'
    Import-PodeModule -Path './config/local.psm1'
    import-module './service/katagraphosRestAPI.psm1'

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

    Add-PodeRoute -Method Post -Path '/api/record/:worksheetName/:username' -ScriptBlock {

        $worksheetName = $WebEvent.Parameters['worksheetName']
        $username = $WebEvent.Parameters['username']
        #$to_do: add username to this path vvv to prevent, rare unlikely hood of 
        # name collision
        $hamchunkshackpath = "/home/grantsteinfeld/dev/katagraphos.net/api/katagraphos-api/lib/temp_storage"
        
   
        $worksheetNamePlusExt = InvokeFileExtensionChecker $worksheetName
        
        $excelFileName = Join-Path $hamchunkshackpath $worksheetNamePlusExt

        Write-Host "excel file name is $excelFileName"

        # Create PSCustormObject [] of items in a specific JSON array
        # regard file 
        # ../../expectedJSON.md
        $records = foreach ($item in $WebEvent.Data){
            [ PSCustomObject ] $item 
        }

  
        $owner = GetStorageRepoProject
        write-host "owner is $owner"
        $repo = GetStorageRepo
        write-host "repo is $repo"
        $repoPath = "user_content/$username/$worksheetNamePlusExt"
        write-host "repo path is $repoPath"
        $token = GetGHtoken
        write-host "toke is $token"

        #Excel is BLOB/ so - Encoding byte
        $content64 = [convert]::ToBase64String((Get-Content -path $excelFileName -AsByteStream))

        $url = "https://api.github.com/repos/$owner/$repo/contents/$repoPath"
        write-host "target repo API address is $url"
        $tim = GetTimestamp

        $jsonBody = @"
        {
        "message": "Uploaded Excel at $tim",
        "committer": {
            "name": $username,
            "email": "$username@gmail.com"
        },
        "content": "$content64"
        }
"@

        # Write-Host "Get-Member of jsonBody begin"
        # $gmsg = Get-Member @jsonBody
        # Write-Host @gmsg
        # Write-Host "Get-Member of jsonBody begin"

        Write-Host "JSON body begin"
        Write-Host @jsonBody
        Write-Host "JSON body end"

 
        $headers = @{
            Accept = "application/vnd.github+json"
            Authorization = "token $token"
        }

        try {
            Write-Host "irm start"
            Invoke-RestMethod -Method Put -Uri $url -Headers $headers -ContentType "application/json" -Body $jsonBody
            Write-Host "irm end"
        }
        catch {
            "irm catch all"
            Write-Host $_
        }

        # Write-Host "now lets delete that tmp [ $excelFileName ] file on local storage"
        # Remove-Item -Path $excelFileName -Force

       Write-PodeJsonResponse -Value @{ 
        'msg'="$username added file $excelFileName"
        'repo'="$owner/$repo";
        'repo_path' = $repoPath;
        'time' = $tim }

    }

    Add-PodeRoute -Method Get -Path '/api/records/:username' -ScriptBlock {

        # read all lists for a given Katagraphos user
        $username = $WebEvent.Parameters['username']

        # ref gh (GitHub CLI) 'api'
        # https://cli.github.com/manual/gh_api

        $owner = GetStorageRepoProject
        $repo = GetStorageRepo
        $path = "user_content/$username"

        $env:GITHUB_TOKEN = GetGHtoken
        $res = (gh api -H "Accept: application/vnd.github+json" "/repos/$owner/$repo/contents/$path")

        # $resObject = $res | ConvertFrom-Json

        #stuff begin
        $xlsx = @()
        $res | ConvertFrom-Json | foreach-object { 
            foreach ($property in $_.PSObject.Properties) {
            # $x = $property.value.name -like "*.xlsx"
            $xlsx += $property.value
            }
        }
        #stuff end



        Write-PodeJsonResponse -Value $xlsx
        # Write-PodeJsonResponse -Value @{ 'results' = $xlsx; }


    }

    Add-PodeRoute -Method Get -Path '/api/read/:worksheetName' -ScriptBlock {
        Write-Host "read a list"

        $worksheetName = $WebEvent.Parameters['worksheetName']
        $path = Join-Path GetTemporaryFileSytemPath $worksheetName
        $Data = Import-Excel $path 
        Write-PodeJsonResponse -Value @{ 'dataStat' = $Data; }


    }
}