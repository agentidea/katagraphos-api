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
