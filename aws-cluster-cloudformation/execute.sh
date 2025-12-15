#!/bin/bash

CLUSTER_NAME="eks-demo"
STACK_NAME="eks-vpc"

####### Create VPC
echo "VPC creating"
#aws cloudformation create-stack \
#  --stack-name $STACK_NAME \
#  --template-body file://eks-vpc.yaml \
#  --capabilities CAPABILITY_NAMED_IAM


####### READ data from created VPC
echo "Obteniendo outputs de CloudFormation para el stack: $STACK_NAME"

# Obtener todos los outputs en formato JSON
OUTPUTS=$(aws cloudformation describe-stacks \
  --stack-name "$STACK_NAME" \
  --query "Stacks[0].Outputs" \
  --output json)

# Extract data using jq
VPC_ID=$(echo "$OUTPUTS" | jq -r '.[] | select(.OutputKey=="VpcId") | .OutputValue')
SUBNET1=$(echo "$OUTPUTS" | jq -r '.[] | select(.OutputKey=="PublicSubnet1") | .OutputValue')
SUBNET2=$(echo "$OUTPUTS" | jq -r '.[] | select(.OutputKey=="PublicSubnet2") | .OutputValue')

export VPC_ID
export SUBNET1
export SUBNET2

echo "VPC DATA:"
echo "  \$VPC_ID   = $VPC_ID"
echo "  \$SUBNET1  = $SUBNET1"
echo "  \$SUBNET2  = $SUBNET2"

########## Create Cluster
echo "Cluster creating"
#aws cloudformation create-stack \
#  --stack-name eks-cluster \
#  --template-body file://eks-cluster.yaml \
#  --parameters \
#      ParameterKey=VpcId,ParameterValue=$VPC_ID \
#      ParameterKey=PublicSubnet1,ParameterValue=$SUBNET1 \
#      ParameterKey=PublicSubnet2,ParameterValue=$SUBNET2 \
#      ParameterKey=ClusterName,ParameterValue=$CLUSTER_NAME \
#  --capabilities CAPABILITY_NAMED_IAM

########## Create Nodegroup
echo "Nodegroup creating"
#aws cloudformation create-stack \
#  --stack-name eks-nodegroup \
#  --template-body file://eks-nodegroup.yaml \
#  --parameters \
#      ParameterKey=ClusterName,ParameterValue=$CLUSTER_NAME \
#      ParameterKey=Subnet1,ParameterValue=$SUBNET1 \
#      ParameterKey=Subnet2,ParameterValue=$SUBNET2 \
#  --capabilities CAPABILITY_NAMED_IAM

echo "-----------------------------------------------------------------------------"
echo "| Cluster is creating. You need to execute this on a few minutes"
echo "| --> aws eks update-kubeconfig --name $CLUSTER_NAME --region eu-north-1"
echo "-----------------------------------------------------------------------------"
