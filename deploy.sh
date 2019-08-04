docker build -t larsito/multi-client:latest -t larsito/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t larsito/multi-server:latest -t larsito/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t larsito/multi-worker:latest -t larsito/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push larsito/multi-client:latest
docker push larsito/multi-server:latest
docker push larsito/multi-worker:latest

docker push larsito/multi-client:$SHA
docker push larsito/multi-server:$SHA
docker push larsito/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/client-deployment client=larsito/multi-client:$SHA
kubectl set image deployments/server-deployment server=larsito/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=larsito/multi-worker:$SHA
