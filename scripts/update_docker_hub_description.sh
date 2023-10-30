#!/bin/bash

# Define variables
DOCKERHUB_USERNAME=$1
DOCKERHUB_PASSWORD=$2
DOCKERHUB_REPO=$3
IMAGE_DESCRIPTION=$(cat $4)

# Get token
TOKEN=$(curl -s -H "Content-Type: application/json" -X POST -d '{"username": "'${DOCKERHUB_USERNAME}'", "password": "'${DOCKERHUB_PASSWORD}'"}' https://hub.docker.com/v2/users/login/ | jq -r .token)

# Update description
curl -s -H "Authorization: JWT ${TOKEN}" -X PATCH --data '{"full_description": "'${IMAGE_DESCRIPTION}'"}' https://hub.docker.com/v2/repositories/${DOCKERHUB_REPO}/
