#!/usr/bin/env bash

## Complete the following steps to get Docker running locally

# Step 1:
# Build image
docker build --tag=innag21/capstone-app . 

# Step 2: 
# Show the image
docker image ls

# Step 3: 
# Test run
docker run -p 8000:80 innag21/capstone-app
