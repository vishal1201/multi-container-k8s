docker build -t vzambare/multi-client:latest -t vzambare/multi-client:$GIT_SHA -f ./client/Dockerfile ./client
docker build -t vzambare/multi-server:latest -t vzambare/multi-server:$GIT_SHA -f ./server/Dockerfile ./server
docker build -t vzambare/multi-worker:latest -t vzambare/multi-worker:$GIT_SHA -f ./worker/Dockerfile ./worker
docker push vzambare/multi-client:$GIT_SHA
docker push vzambare/multi-server:$GIT_SHA
docker push vzambare/multi-worker:$GIT_SHA
docker push vzambare/multi-client:latest
docker push vzambare/multi-server:latest
docker push vzambare/multi-worker:latest
kubectl apply -f k8s

kubectl set image deployments/server-deployment server=vzambare/multi-server:$GIT_SHA
kubectl set image deployments/client-deployment client=vzambare/multi-client:$GIT_SHA
kubectl set image deployments/worker-deployment worker=vzambare/multi-worker:$GIT_SHA