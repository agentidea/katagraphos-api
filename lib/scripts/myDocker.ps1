param($t)
docker image rm $t
docker build -t pode/example .
docker run -p 8086:8086 -d pode/example
# docker ps 
# docker ps -a
# docker log 266
# docker logs 266