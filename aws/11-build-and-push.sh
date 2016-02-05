#!/bin/sh

SERVICE=$1
if [ "$SERVICE" == "" ]; then
	echo "[Error] Need an argument to specify a service name." 1>&2
	exit 1
fi
if [ ! -d $SERVICE ]; then
	echo "[Error] Invalid service name." 1>&2
	exit 1
fi

# ECR Login

eval "$(aws ecr get-login)"

# Configure environment variables

AWS_ACCOUNT_ID=$( aws ec2 describe-security-groups --query 'SecurityGroups[0].OwnerId' --output text )
ECR_REGISTRY=${AWS_ACCOUNT_ID}.dkr.ecr.us-east-1.amazonaws.com
ECR_REPOSITORY_GROUP=example-voting-app
DATETIME=$(date '+%Y%m%d%H%M%S')

# Docker build & push

cd ${SERVICE}
docker build -t ${ECR_REGISTRY}/${ECR_REPOSITORY_GROUP}/${SERVICE}:${DATETIME} .
docker push ${ECR_REGISTRY}/${ECR_REPOSITORY_GROUP}/${SERVICE}:${DATETIME}

aws ecr list-images --repository-name ${ECR_REPOSITORY_GROUP}/${SERVICE}
