docker rm psapi --force | true
docker rmi ubs00.ocampa.local:32443/tlaxpsapi:latest | true

docker build  -f ./Dockerfile -t ubs00.ocampa.local:32443/tlaxpsapi:latest .
docker run -d -p 0.0.0.0:8880:8080 --name psapi ubs00.ocampa.local:32443/tlaxpsapi:latest