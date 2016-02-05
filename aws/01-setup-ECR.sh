#!/bin/sh

# ECR Login

eval "$(aws ecr get-login)"

# Create docker repositories

ECR_REPOSITORY_GROUP=example-voting-app
aws ecr create-repository --repository-name ${ECR_REPOSITORY_GROUP}/voting-app
aws ecr create-repository --repository-name ${ECR_REPOSITORY_GROUP}/result-app
aws ecr create-repository --repository-name ${ECR_REPOSITORY_GROUP}/worker

aws ecr describe-repositories
