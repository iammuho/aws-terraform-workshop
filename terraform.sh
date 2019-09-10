#!/bin/bash

echo "Enter your environment (staging or production)"
read environment

rm -Rf .terraform/

terraform12 init -upgrade=true -var-file=vars/$environment.tfvars
terraform12 apply -var-file=vars/$environment.tfvars
