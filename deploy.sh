#!/bin/bash
echo "Deploying container using Docker Compose..."
docker-compose down
docker-compose up -d --build
echo "Deployment successful! Application is running on port 80."