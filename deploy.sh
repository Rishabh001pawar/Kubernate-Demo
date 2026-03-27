set -e 

NAME = "kubernate-demo-api"
USERNAME="rishabhpawar007"
IMAGE="$USERNAME/$NAME:latest"

echo "Building Docker image..."
docker build -t $IMAGE .


echo "Image built successfully..."
docker push $IMAGE

echo "applying kubernetes configuration..."
kubectl apply -f k8s/deployment.yaml
kubectl apply -f k8s/service.yaml

echo "Getting pod details..."
kubectl get pods

echo "Getting service details..."
kubectl get services

echo "fetching the main service"
kubectl get service $NAME-service