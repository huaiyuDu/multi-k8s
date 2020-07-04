docker build -t harrydu/multi-client:latest -t harrydu/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t harrydu/multi-server:latest -t harrydu/multi-server:$SHA  -f ./server/Dockerfile ./server
docker build -t harrydu/multi-worker:latest -t harrydu/multi-worker:$SHA  -f ./worker/Dockerfile ./worker

docker push harrydu/multi-client:latest
docker push harrydu/multi-server:latest
docker push harrydu/multi-worker:latest

docker push harrydu/multi-client:$SHA
docker push harrydu/multi-server:$SHA
docker push harrydu/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=harrydu/multi-server:$SHA
kubectl set image deployments/client-deployment client=harrydu/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=harrydu/multi-worker:$SHA
