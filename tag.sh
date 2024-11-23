#!/bin/bash

# Fetch the latest release tag
latest_tag=$(git describe --tags `git rev-list --tags --max-count=1`)

# Checkout the latest release
git checkout $latest_tag

# Build the Docker image
docker build -t python-web-app:$latest_tag .

# Run the Docker container
docker run -d -p 5000:5000 python-web-app:$latest_tag

# Get the container ID
container_id=$(docker ps -q --filter ancestor=python-web-app:$latest_tag)

# Print the container's IP address
container_ip=$(docker inspect -f '{{range.NetworkSettings.Networks}}{{.IPAddress}}{{end}}' $container_id)
echo "Container IP Address: $container_ip"

# Get the host machine's IP address
host_ip=$(hostname -I | awk '{print $1}')

# Print the host machine IP address
echo "Host Machine IP Address: $host_ip"
