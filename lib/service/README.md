# Katagraphos  PowerShell API server

### Pre-requistes

Docker


### Pode web/rest httpd
https://pode.readthedocs.io/en/latest/Hosting/Docker/#build-and-run


### Building Docker file
```powershell

docker build -t pode/example .

docker run -p 8086:8086 -d pode/example
```

### routes ( draft )
### REST API

    POST /record/userregistration  {"fullName":"Grant Steinfeld", "ownerSecret":"str0ng-P@ssword", "dateOfBirth":{"day":"02","month":"March","optionalYear":""}}

    POST /record/new {"ListName":"ToDo" , "visibility":"private|public", "items":["learn ImportExcel", "learn PSAdvantage", "spin up REST API server in PowerShell, ? Pode? "], "Authentication":{fullName:Grant%20Steinfeld, dob=0302[1967],ownerSecret:str0ng-P@ssword}}  

    GET /record/findOne?ListName=ToDo&fullName=Grant%20Steinfeld&dob=0302[1967]

    GET /record/findAll?fullName=Grant%20Steinfeld&dob=0302[1967]&ownerSecret=str0ng-P@ssword