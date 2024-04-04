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
### Configuration script for the quakejs + Kubernetes example
###
##############################################################################
##############################################################################

# disable aws command output pagination
export AWS_PAGER=""

# a region for your EKS managed control plane
AWS_REGION=us-east-1

#For example:
# AWS:          us-east-1
# AWS GovCloud: us-gov-east-1

# a name for your EKS stack
STACK_NAME=quakejs-stack

# a namefor your cluster
EKS_CLUSTER_NAME=MyClusterName

# an AMI to use for instantiating Kubernetes worker nodes. See note below
NODE_AMI=ami-0b68b257d02b3f053

# *** IMPORTANT NOTE ***
# The NODE_AMI must be an EKS-friendly x86_64 AMI available in your region.
#   Below are examples of two known-working AMIs:
#     ami-0b68b257d02b3f053
#     amazon-eks-node-al2023-x86_64-standard-1.29-v20240315 
#
#     ami-0051607a416876cec
#     ubuntu-eks/k8s_1.29/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-20240301
# *** IMPORTANT NOTE ***



