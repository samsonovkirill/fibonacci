docker build -t kvsamsonov/multi-client:latest -t kvsamsonov/multi-client:$SHA -f ./client/Dockerfile.dev ./client
docker build -t kvsamsonov/multi-server:latest -t kvsamsonov/multi-server:$SHA -f ./server/Dockerfile.dev ./server
docker build -t kvsamsonov/multi-worker:latest -t kvsamsonov/multi-worker:$SHA -f ./worker/Dockerfile.dev ./worker

docker push kvsamsonov/multi-client:latest
docker push kvsamsonov/multi-server:latest
docker push kvsamsonov/multi-worker:latest

docker push kvsamsonov/multi-client:$SHA
docker push kvsamsonov/multi-server:$SHA
docker push kvsamsonov/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=kvsamsonov/multi-server:$SHA
kubectl set image deployments/client-deployment client=kvsamsonov/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=kvsamsonov/multi-worker:$SHA
