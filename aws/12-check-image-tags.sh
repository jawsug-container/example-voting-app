#!/bin/sh

AWS_ACCOUNT_ID=$( aws ec2 describe-security-groups --query 'SecurityGroups[0].OwnerId' --output text )
ECR_REGISTRY=${AWS_ACCOUNT_ID}.dkr.ecr.us-east-1.amazonaws.com
ECR_REPOSITORY_GROUP=example-voting-app

echo ' '
echo 'export VOTING=voting-app:'
aws ecr list-images --repository-name ${ECR_REPOSITORY_GROUP}/voting-app

echo ' '
echo 'export RESULT=result-app:'
aws ecr list-images --repository-name ${ECR_REPOSITORY_GROUP}/result-app

echo ' '
echo 'export WORKER=worker:'
aws ecr list-images --repository-name ${ECR_REPOSITORY_GROUP}/worker
