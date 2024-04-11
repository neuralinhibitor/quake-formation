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
### This script tears down various kubernetes resources defined in quakejs.yml
###
##############################################################################
##############################################################################

source ./config.sh


#point your kubectl at the eks cluster we created earlier
aws eks update-kubeconfig --region $AWS_REGION --name $EKS_CLUSTER_NAME

#delete any existing quakejs kubernetes deployment
kubectl delete -f quakejs.yml

