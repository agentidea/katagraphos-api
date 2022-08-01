# Katagraphos - microservice business logic-server

## powershell microservice

```text
Intention is to manage records by writing to an excel document(s) in a folder called fullName.
```

# Versoin control your data with Excel and GitHub


## What you will learn
1. How to save records using the PowerShell Excel Module and store it in a GitHub repository.
1. Use PowerShell with the PowerShell Pode Module to create a microservice that run's seamlessly in `Docker`
1. Use Microsoft Excel to password protect to your directory in GitHub.
1. Store your list via a Git commit and `push` to an existing GitHub Repo.
1. Retrieve your data with a PowerShell microservice using and a React front end.
1. Use Excel as your primary database, that you can upddate and download in order to centralize and share a singularity 



### REST API

    POST /record/userregistration  {"fullName":"Grant Steinfeld", "ownerSecret":"str0ng-P@ssword", "dateOfBirth":{"day":"02","month":"March","optionalYear":""}}

    POST /record/new {"ListName":"ToDo" , "visibility":"private|public", "items":["learn ImportExcel", "learn PSAdvantage", "spin up REST API server in PowerShell, ? Pode? "], "Authentication":{fullName:Grant%20Steinfeld, dob=0302[1967],ownerSecret:str0ng-P@ssword}}  

    GET /record/findOne?ListName=ToDo&fullName=Grant%20Steinfeld&dob=0302[1967]

    GET /record/findAll?fullName=Grant%20Steinfeld&dob=0302[1967]&ownerSecret=str0ng-P@ssword

