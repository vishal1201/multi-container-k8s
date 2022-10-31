docker build -t vzambare/multi-client:latest -t vzambare/multi-client:$GIT_SHA -f ./client/Dockerfile ./client
docker build -t vzambare/multi-server:latest -t vzambare/multi-server:$GIT_SHA -f ./server/Dockerfile ./server
docker build -t vzambare/multi-worker:latest -t vzambare/multi-worker:$GIT_SHA -f ./worker/Dockerfile ./worker
docker push vzambare/multi-client:$GIT_SHA vzambare/multi-client:latest
docker push vzambare/multi-server:$GIT_SHA vzambare/multi-server:latest
docker push vzambare/multi-worker:$GIT_SHA vzambare/multi-worker:latest
docker push vzambare/multi-client:latest
docker push vzambare/multi-server:latest
docker push vzambare/multi-worker:latest
kubectl apply -f k8s

kubectl set image deployments/server-deployment server=vzambare/multi-server:$GIT_SHA
kubectl set image deployments/client-deployment server=vzambare/multi-client:$GIT_SHA
kubectl set image deployments/worker-deployment server=vzambare/multi-worker:$GIT_SHA