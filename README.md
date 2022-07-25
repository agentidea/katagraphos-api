# Katagraphos - microservice business logic-server

## powershell microservice

```text
Intention is to manage records by writing to an excel document(s) in a folder called fullName.
```

### REST API

    POST /record/userregistration  {"fullName":"Grant Steinfeld", "ownerSecret":"str0ng-P@ssword", "dateOfBirth":{"day":"02","month":"March","optionalYear":""}}

    POST /record/new {"ListName":"ToDo" , "visibility":"private|public", "items":["learn ImportExcel", "learn PSAdvantage", "spin up REST API server in PowerShell, ? Pode? "], "Authentication":{fullName:Grant%20Steinfeld, dob=0302[1967],ownerSecret:str0ng-P@ssword}}  

    GET /record/findOne?ListName=ToDo&fullName=Grant%20Steinfeld&dob=0302[1967]

    GET /record/findAll?fullName=Grant%20Steinfeld&dob=0302[1967]&ownerSecret=str0ng-P@ssword

