docker build -t shonphand/multi-client:latest -t shonphand/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t shonphand/multi-server:latest -t shonphand/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t shonphand/multi-worker:latest -t shonphand/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push shonphand/multi-client:latest
docker push shonphand/multi-server:latest
docker push shonphand/multi-worker:latest
docker push shonphand/multi-client:$SHA
docker push shonphand/multi-server:$SHA
docker push shonphand/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=shonphand/multi-server:$SHA
kubectl set image deployments/client-deployment client=shonphand/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=shonphand/multi-worker:$SHA