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
### This script deploys various kubernetes resources defined in quakejs.yml
###
##############################################################################
##############################################################################

source ./config.sh

#first delete any existing quakejs kubernetes deployment
./undeploy-quake.sh
kubectl create -f quakejs.yml

#wait for deployment to initialize
echo "Waiting for quakejs deployment to become available..."
kubectl wait --for=condition=Available -n quakejs-quakeserver-ns deployment/quakejs-scenario-deployment

#extract the loadbalancer's public endpoint
kubectl get services --namespace=quakejs-proxy-ns --field-selector metadata.name=quakejs-loadbalancer |  awk {'print $1 " " $4'} | column -t
quake_endpoint=`kubectl get services -o jsonpath='{.items[0].status.loadBalancer.ingress[0].hostname}' --namespace=quakejs-proxy-ns --field-selector metadata.name=quakejs-loadbalancer`


echo "You can reach your quake deployment @ https://$quake_endpoint:31337"
echo "NOTE: it may take a few minutes for this endpoint to resolve"

