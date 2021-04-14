#!/usr/bin/env bash
# This file tags and uploads an image to Docker Hub

# Assumes that an image is built via `run_docker.sh`

# Step 1:
# Create dockerpath
# dockerpath=<your docker ID/path>
dockerpath=innag21/capstone-app

# Step 2:  
# Authenticate & tag
export DOCKER_ID_USER="innag21"
docker login
docker tag devops-capstone:latest $DOCKER_ID_USER/devops-capstone
echo "Docker ID and Image: $dockerpath"

# Step 3:
# Push image to a docker repository
docker push $dockerpath
