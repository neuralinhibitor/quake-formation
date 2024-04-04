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
### This script tears down a previously created cloudformation stack.
###
##############################################################################
##############################################################################

source ./config.sh

# Check if the stack exists and if so prompt user before deleting it
if aws cloudformation describe-stacks --stack-name "$STACK_NAME" &> /dev/null; then
    echo "Stack [$STACK_NAME] already exists."

    read -p "Do you want to delete stack [$STACK_NAME] (this may take a long time)? (yY/nN): " choice
    case "$choice" in
      y|Y ) 
		# Undeploy everything from kubernetes
		./undeploy-quake.sh

        # Delete the stack
        echo "Cleaning up existing stack named [$STACK_NAME]. This may take several minutes..." && \
		  aws cloudformation delete-stack --stack-name $STACK_NAME && \
          aws cloudformation wait stack-delete-complete --stack-name $STACK_NAME || echo "error with cleanup (nothing to clean?)"
        ;;
      n|N ) 
        echo "You elected not to delete the stack. There is nothing to do..."
		exit 2 # error condition
        ;;
      * ) 
        echo "Invalid choice. Exiting without deleting the stack."
		exit 1 # error condition
        ;;
    esac
else
    echo "Stack [$STACK_NAME] does not exist. There is nothing to do..."
fi

exit 0

