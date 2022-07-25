# Katagraphos business logic-server

## powershell microservice

```text
Intention is to manage lists by writing to an excel document(s) in a folder called fullName.
```


    POST /list/userregistration  {"fullName":"Grant Steinfeld", "ownerSecret":"str0ng-P@ssword", "dateOfBirth":{"day":"02","month":"March","optionalYear":""}}

    POST /list/new {"ListName":"ToDo" , "visibility":"private|public", "items":["learn ImportExcel", "learn PSAdvantage", "spin up REST API server in PowerShell, ? Pode? "], "Authentication":{fullName:Grant%20Steinfeld, dob=0302[1967],ownerSecret:str0ng-P@ssword}}  

    GET /list/findOne?ListName=ToDo&fullName=Grant%20Steinfeld&dob=0302[1967]

    GET /list/findAll?fullName=Grant%20Steinfeld&dob=0302[1967]&ownerSecret=str0ng-P@ssword

