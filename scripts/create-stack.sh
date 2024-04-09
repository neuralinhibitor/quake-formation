#!/bin/bash

# -----------------------------------------------------------------------------
# Copyright [2024] [Rampart AI, Inc.]
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
# -----------------------------------------------------------------------------





##############################################################################
##############################################################################
###
### This script provisions a cloudformation stack for a Kubernetes cluster.
###  It sets up a managed EKS control plane and two lightweight nodes running 
###  on EC2. If you already have a Kubernetes cluster, skip this script and 
###  move on to deploy-quakejs.sh which actually deploys the quakejs app.
###
##############################################################################
##############################################################################

source ./config.sh

# Do an early check that the NODE_AMI exists 
# (for early failure to save a lot of time downstream if there are issues)
if ! aws ec2 describe-images --image-ids "$NODE_AMI" &> /dev/null; then
    echo "Node AMI [$NODE_AMI] does not exist in your region. Exiting."
    exit 1
fi

# Now create the stack. Strap in...
echo "First we will check if the stack is already running" && \
  ./uncreate-stack.sh && \
echo "Performing lookup of your specified worker node AMI [$NODE_AMI]:" && \
  aws ec2 describe-images --image-ids $NODE_AMI && \
echo "Creating stack [$STACK_NAME]. This may take several minutes..." && \
  aws cloudformation create-stack \
	--stack-name $STACK_NAME \
    --capabilities CAPABILITY_NAMED_IAM \
    --template-body file://`pwd`/kube-stack.yml \
    --parameters \
        ParameterKey=NodeAmi,ParameterValue=$NODE_AMI \
        ParameterKey=ClusterName,ParameterValue=$EKS_CLUSTER_NAME \
        ParameterKey=StackName,ParameterValue=$STACK_NAME && \
  aws cloudformation wait stack-create-complete --stack-name $STACK_NAME && \
echo "Deploy complete." || echo "something has gone horribly wrong"

echo "done."

