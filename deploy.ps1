$ErrorActionPreference = "Stop"

$name = "kubernate-demo-api"
$username = "rishabhpawar007"
$image = "$username/$name`:latest"

Write-Host "Building Docker image..."
docker build -t $image .

Write-Host "Image built successfully. Pushing image..."
docker push $image

Write-Host "Applying Kubernetes configuration..."
kubectl apply -f k8s/deployment.yml
kubectl apply -f k8s/service.yaml

Write-Host "Getting pod details..."
kubectl get pods

Write-Host "Getting service details..."
kubectl get services

Write-Host "Fetching the main service..."
kubectl get service $name
