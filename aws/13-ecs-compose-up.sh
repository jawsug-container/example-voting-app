#!/bin/sh

ID=${1:-$(date '+%Y%m%d%H%M%S')}
echo 'Service ID: '$ID

if [ "$VOTING" == "" ]; then
	echo "[Error] Need VOTING." 1>&2
	exit 1
fi
if [ "$RESULT" == "" ]; then
	echo "[Error] Need RESULT." 1>&2
	exit 1
fi
if [ "$WORKER" == "" ]; then
	echo "[Error] Need WORKER." 1>&2
	exit 1
fi

# Configure environment variables

AWS_ACCOUNT_ID=$( aws ec2 describe-security-groups --query 'SecurityGroups[0].OwnerId' --output text )
ECR_REGISTRY=${AWS_ACCOUNT_ID}.dkr.ecr.us-east-1.amazonaws.com
ECR_REPOSITORY_GROUP=example-voting-app
EC2_HOST=$( aws --region ap-northeast-1 ec2 describe-instances --filter "Name=tag-key,Values=aws:cloudformation:logical-id" --query "Reservations[].Instances[].PrivateIpAddress" --output text )

# Configure ECS yaml

sed -e 's/@VOTING/'${ECR_REGISTRY}'\/'${ECR_REPOSITORY_GROUP}'\/'${VOTING}'/' aws/ecs-template.yml > aws/ecs-template-$ID.yml
sed -i '' -e 's/@RESULT/'${ECR_REGISTRY}'\/'${ECR_REPOSITORY_GROUP}'\/'${RESULT}'/' aws/ecs-template-$ID.yml
sed -i '' -e 's/@WORKER/'${ECR_REGISTRY}'\/'${ECR_REPOSITORY_GROUP}'\/'${WORKER}'/' aws/ecs-template-$ID.yml
sed -i '' -e 's/@HOST/'${EC2_HOST}'/g' aws/ecs-template-$ID.yml

# Start ECS services

ecs-cli compose --file aws/ecs-template-$ID.yml service up
