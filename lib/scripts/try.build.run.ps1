param($t)
docker image rm $t
docker build -t pode/example .
docker run -p 8090:8090 -d pode/example
