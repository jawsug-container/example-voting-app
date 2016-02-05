#!/bin/sh

CLUSTER=$1
if [ "$CLUSTER" == "" ]; then
	echo "[Error] Need an argument to specify a cluster name." 1>&2
	exit 1
fi
KEYPAIR=$2
if [ "$KEYPAIR" == "" ]; then
	echo "[Error] Need an argument to specify a EC2 KayPair name." 1>&2
	exit 1
fi
INSTANCE_TYPE=${3:-"t2.medium"}
INSTANCE_NUMS=${4:-1}

# Configure ECS-CLI
ecs-cli configure --region ap-northeast-1 --cluster $CLUSTER

# Activate IAM, VPC, ASG & EC2 instances
ecs-cli up --capability-iam --keypair $KEYPAIR --instance-type $INSTANCE_TYPE --size $INSTANCE_NUMS
