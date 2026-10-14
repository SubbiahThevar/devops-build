#!/bin/bash
echo "Building Docker image..."
docker build -t react-app:latest .
echo "Docker build complete!"