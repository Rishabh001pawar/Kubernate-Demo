# Kubernate-Demo

A simple Node.js + Express API prepared for Docker and Kubernetes deployment.

## Overview

This project exposes a small HTTP API with health endpoints and includes:

- Local development scripts
- Dockerfile for container image builds
- Docker Compose for local container runs
- Kubernetes manifests for Deployment and Service
- Deployment automation script for Windows PowerShell

## API Endpoints

The server runs on port `3000` by default.

- `GET /` returns service metadata and current time
- `GET /readyz` readiness probe endpoint
- `GET /healthz` liveness probe endpoint

Example response from `/`:

```json
{
	"message": "Hello, Kubernetes!",
	"service": "hello-node",
	"pod": "kubernate-demo-api-xxxxx",
	"time": "2026-03-26T12:00:00.000Z"
}
```

## Project Structure

```text
Kubernate-Demo/
	index.js
	package.json
	dockerfile
	docker-compose.yaml
	deploy.ps1
	deploy.sh
	k8s/
		deployment.yml
		service.yaml
```

## Prerequisites

- Node.js 18+
- npm
- Docker Desktop (for Docker and local Kubernetes)
- kubectl configured for your cluster

## Run Locally (Node)

Install dependencies:

```bash
npm install
```

Start in development mode (auto-reload):

```bash
npm run dev
```

Start in production mode:

```bash
npm start
```

Test the API:

```bash
curl http://localhost:3000/
curl http://localhost:3000/readyz
curl http://localhost:3000/healthz
```

## Run with Docker Compose

Build and start:

```bash
docker compose up --build
```

Stop:

```bash
docker compose down
```

## Build Docker Image Manually

```bash
docker build -t kubernate-demo-api:latest -f dockerfile .
docker run --rm -p 3000:3000 kubernate-demo-api:latest
```

## Deploy to Kubernetes

Apply manifests:

```bash
kubectl apply -f k8s/deployment.yml
kubectl apply -f k8s/service.yaml
```

Check resources:

```bash
kubectl get pods
kubectl get services
kubectl describe deployment kubernate-demo-api
```

## Windows Deployment Script

You can run the included PowerShell deployment command:

```bash
npm run deploy
```

This script:

- Builds and pushes a Docker image
- Applies Kubernetes manifests
- Prints pod and service status

## Configuration Notes

- The app reads `PORT` and `POD_NAME` from environment variables.
- Kubernetes `deployment.yml` currently references image `node-api:latest`.
- `deploy.ps1` builds and pushes `rishabhpawar007/kubernate-demo-api:latest`.

If you deploy to a remote cluster, make sure the image in `k8s/deployment.yml` matches the pushed image name.

## Known Issues

- `deploy.sh` has shell syntax and filename mismatches:
	- variable assignment contains spaces (`NAME = ...`)
	- it references `k8s/deployment.yaml` but the repository file is `k8s/deployment.yml`

Use `deploy.ps1` on Windows, or fix `deploy.sh` before using it on Linux/macOS.

## License

ISC